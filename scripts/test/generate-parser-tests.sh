#!/usr/bin/env bash

set -euxo pipefail

PROJECT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

printf "\n=======================================================\n"
printf "PROJECT ROOT DIR: %s\n" "$PROJECT_ROOT"
printf "\n=======================================================\n"

source "$(dirname "$0")/common.sh"
source "$(dirname "$0")/parser-generator.sh"

generate_variable_tests
generate_assignment_tests

generate_primary_tests
generate_unary_tests
generate_factor_tests
generate_term_tests
generate_comparison_tests
generate_equality_tests
generate_logical_and_tests
generate_logical_or_tests
generate_precedence_tests

generate_diagnostic_tests
generate_regression_tests

header "Done"

info "Parser test suite generated successfully."
