#!/usr/bin/env bash

###############################################################################
#
# generate-ast-snapshots.sh
#
# Generates canonical AST snapshots for every parser test case.
#
# Responsibilities
# ----------------
#   • Discover parser test inputs.
#   • Execute the parser.
#   • Render the resulting AST.
#   • Produce deterministic .ast snapshots.
#
# This script NEVER validates parser output.
# Validation is performed by parser-tests-runner.sh.
#
###############################################################################

set -Eeuo pipefail

###############################################################################
# Script Location
###############################################################################

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd -- "${SCRIPT_DIR}/../.." && pwd)"

source "${SCRIPT_DIR}/common.sh"

###############################################################################
# Configuration
###############################################################################

readonly SCRIPT_NAME="$(basename "$0")"

readonly TEST_ROOT="${PROJECT_ROOT}/tests/parser"

readonly SNAPSHOT_EXTENSION=".ast"

readonly INPUT_EXTENSION=".jua"

readonly PARSER_MAIN_CLASS="compiler.reference.ParserRunner"

readonly MVN_COMMAND="mvn"

readonly COMPILER_RUNNER="${PARSER_MAIN_CLASS}"

###############################################################################
# Global State
###############################################################################

UPDATE_EXISTING=false

GENERATE_MISSING_ONLY=false

VERBOSE=false

DRY_RUN=false

TARGET_SUITE=""

TARGET_CASE=""

GENERATED_COUNT=0

UPDATED_COUNT=0

SKIPPED_COUNT=0

FAILED_COUNT=0

###############################################################################
# Usage
###############################################################################

usage() {

cat <<EOF

Usage

    ${SCRIPT_NAME} [options]

Description

    Generates canonical AST snapshots for parser test cases.

Options

    --update
        Regenerate existing snapshots.

    --missing
        Generate snapshots only when they do not exist.

    --suite <suite>
        Restrict generation to a parser suite.

    --case <case>
        Restrict generation to one parser case.

    --verbose
        Display parser execution output.

    --dry-run
        Show planned actions without modifying files.

    --help
        Display this help message.

EOF

}

###############################################################################
# Command-Line Parsing
###############################################################################

parse_arguments() {

    while [[ $# -gt 0 ]]
    do

        case "$1" in

            --update)

                UPDATE_EXISTING=true
                shift
                ;;

            --missing)

                GENERATE_MISSING_ONLY=true
                shift
                ;;

            --suite)

                [[ $# -lt 2 ]] && die "Missing suite name."

                TARGET_SUITE="$2"

                shift 2
                ;;

            --case)

                [[ $# -lt 2 ]] && die "Missing case name."

                TARGET_CASE="$2"

                shift 2
                ;;

            --verbose)

                VERBOSE=true
                shift
                ;;

            --dry-run)

                DRY_RUN=true
                shift
                ;;

            --help)

                usage
                exit 0
                ;;

            *)

                die "Unknown option: $1"

                ;;

        esac

    done

}

###############################################################################
# Initialization
###############################################################################

initialize() {

    info "Project Root : ${PROJECT_ROOT}"
    info "Parser Tests : ${TEST_ROOT}"

    if [[ ! -d "${TEST_ROOT}" ]]
    then
        die "Parser test directory not found."
    fi

}


###############################################################################
# Logging
###############################################################################

log_generated() {

    success "Generated  : $1"

}

log_updated() {

    success "Updated    : $1"

}

log_skipped() {

    info "Skipped    : $1"

}

log_failed() {

    error "Failed     : $1"

}

###############################################################################
# Snapshot Utilities
###############################################################################

snapshot_path() {

    local input="$1"

    printf "%s%s" \
        "${input%"${INPUT_EXTENSION}"}" \
        "${SNAPSHOT_EXTENSION}"

}

normalize_snapshot() {

    local snapshot="$1"

    python3 <<EOF
from pathlib import Path

path = Path(r"${snapshot}")

text = path.read_text(encoding="utf-8")

lines = [line.rstrip() for line in text.splitlines()]

path.write_text(
    "\n".join(lines) + "\n",
    encoding="utf-8",
    newline="\n",
)
EOF

}

###############################################################################
# Parser Execution
###############################################################################

run_parser() {

    local input="$1"

    if [[ "${VERBOSE}" == true ]]
    then

        ${MVN_COMMAND} \
            -q \
            exec:java \
            -Dexec.mainClass="${PARSER_MAIN_CLASS}" \
            -Dexec.args="${input}"

    else

        ${MVN_COMMAND} \
            -q \
            exec:java \
            -Dexec.mainClass="${PARSER_MAIN_CLASS}" \
            -Dexec.args="${input}" \
            2>/dev/null

    fi

}

###############################################################################
# Parser Discovery
###############################################################################

discover_parser_cases() {

    local find_command=(
        find
        "${TEST_ROOT}"
        -type f
        -name "*${INPUT_EXTENSION}"
    )

    if [[ -n "${TARGET_SUITE}" ]]
    then

        find_command+=(
            -path
            "*/${TARGET_SUITE}/*"
        )

    fi

    "${find_command[@]}" |
        sort

}

###############################################################################
# Snapshot Generation
###############################################################################

generate_snapshot() {

    local input="$1"

    local snapshot
    snapshot="$(snapshot_path "${input}")"

    ###########################################################################
    # Determine generation mode
    ###########################################################################

    if [[ -f "${snapshot}" ]]
    then

        if [[ "${GENERATE_MISSING_ONLY}" == true ]]
        then
            ((++SKIPPED_COUNT))
            log_skipped "${input}"
            return 0
        fi

        if [[ "${UPDATE_EXISTING}" == false ]]
        then
            ((++SKIPPED_COUNT))
            log_skipped "${input}"
            return 0
        fi

    fi

    ###########################################################################
    # Dry Run
    ###########################################################################

    if [[ "${DRY_RUN}" == true ]]
    then

        info "Would generate snapshot for ${input}"

        return 0

    fi

    ###########################################################################
    # Temporary Output
    ###########################################################################

    local temporary_snapshot

    temporary_snapshot="$(mktemp)"

    ###########################################################################
    # Execute Parser
    ###########################################################################

    if ! run_parser "${input}" > "${temporary_snapshot}"
    then

        rm -f "${temporary_snapshot}"

        ((++FAILED_COUNT))

        log_failed "${input}"

        return 1

    fi

    ###########################################################################
    # Normalize Snapshot
    ###########################################################################

    normalize_snapshot "${temporary_snapshot}"

    ###########################################################################
    # Write Snapshot
    ###########################################################################

    if [[ -f "${snapshot}" ]]
    then

        if cmp -s "${temporary_snapshot}" "${snapshot}"
        then

            rm -f "${temporary_snapshot}"

            ((++SKIPPED_COUNT))

            log_skipped "${input}"

            return 0

        fi

        mv "${temporary_snapshot}" "${snapshot}"

        ((++UPDATED_COUNT))

        log_updated "${input}"

    else

        mv "${temporary_snapshot}" "${snapshot}"

        ((++GENERATED_COUNT))

        log_generated "${input}"

    fi

}

###############################################################################
# Suite Generation
###############################################################################

generate_snapshots() {

    local parser_case

    while IFS= read -r parser_case
    do

        if [[ -n "${TARGET_CASE}" ]]
        then

            local case_name

            case_name="$(basename "${parser_case}" "${INPUT_EXTENSION}")"

            [[ "${case_name}" != "${TARGET_CASE}" ]] && continue

        fi

        generate_snapshot "${parser_case}"

    done < <(discover_parser_cases)

}

###############################################################################
# Summary
###############################################################################

print_summary() {

    printf "\n"

    printf "============================================================\n"
    printf " AST Snapshot Generation Summary\n"
    printf "============================================================\n"

    printf " Generated : %5d\n" "${GENERATED_COUNT}"
    printf " Updated   : %5d\n" "${UPDATED_COUNT}"
    printf " Skipped   : %5d\n" "${SKIPPED_COUNT}"
    printf " Failed    : %5d\n" "${FAILED_COUNT}"

    printf "============================================================\n"

}

###############################################################################
# Main
###############################################################################

main() {

    parse_arguments "$@"

    initialize

    info "Discovering parser test cases..."

    generate_snapshots

    print_summary

    if [[ "${FAILED_COUNT}" -gt 0 ]]
    then

        error "Snapshot generation completed with failures."

        exit 1

    fi

    success "Snapshot generation completed successfully."

    exit 0

}

###############################################################################
# Entry Point
###############################################################################

main "$@"
