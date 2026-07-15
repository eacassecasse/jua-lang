#!/usr/bin/env bash

source "$(dirname "$0")/common.sh"

###############################################################################
# Parser test root
###############################################################################

TEST_ROOT="$PROJECT_ROOT/tests/parser"

DECLARATIONS="$TEST_ROOT/declarations"

VARIABLE="$DECLARATIONS/variable"

ASSIGNMENT="$DECLARATIONS/assignment"

EXPRESSIONS="$TEST_ROOT/expressions"

PRIMARY="$EXPRESSIONS/primary"

UNARY="$EXPRESSIONS/unary"

FACTOR="$EXPRESSIONS/factor"

TERM="$EXPRESSIONS/term"

COMPARISON="$EXPRESSIONS/comparison"

EQUALITY="$EXPRESSIONS/equality"

LOGICAL_AND="$EXPRESSIONS/logical-and"

LOGICAL_OR="$EXPRESSIONS/logical-or"

PRECEDENCE="$EXPRESSIONS/precedence"

DIAGNOSTICS="$TEST_ROOT/diagnostics"

EXPECTED="$TEST_ROOT/expected"

REGRESSION="$TEST_ROOT/regression"

variable() {

    local category="$1"
    local filename="$2"
    local qualifier="$3"
    local initializer="$4"

    local directory="$VARIABLE/$category"

    if [[ -z "$initializer" ]]; then

        write_file "$directory/$filename.jua" <<EOF
# Variable declaration without initializer.

create $qualifier value
EOF

        return
    fi

    #
    # If the initializer is a simple identifier, declare it first.
    #
    if [[ "$initializer" =~ ^[A-Za-z_][A-Za-z0-9_]*$ ]]; then

        write_file "$directory/$filename.jua" <<EOF
# Variable declaration initialized from another variable.

create other = 10
create $qualifier value = $initializer
EOF

        return
    fi

    write_file "$directory/$filename.jua" <<EOF
# Variable declaration.

create $qualifier value = $initializer
EOF

}

assignment() {

    local category="$1"
    local filename="$2"
    local expression="$3"

    local directory="$ASSIGNMENT/$category"

    if [[ "$expression" =~ ^[A-Za-z_][A-Za-z0-9_]*$ ]]; then

        write_file "$directory/$filename.jua" <<EOF
# Assignment from another variable.

create other = 10
create mutable value

value = $expression
EOF

        return
    fi

    write_file "$directory/$filename.jua" <<EOF
# Assignment statement.

create mutable value

value = $expression
EOF

}

expression() {

    local production="$1"
    local filename="$2"
    local source="$3"
    local preamble="${4:-}"

    local directory="$EXPRESSIONS/$production"

    if [[ -n "$preamble" ]]; then

        write_file "$directory/$filename.jua" <<EOF
# Parser test.

$preamble

create value = $source
EOF

    else

        write_file "$directory/$filename.jua" <<EOF
# Parser test.

create value = $source
EOF

    fi

}

###############################################################################
# Generates a parser diagnostic test.
#
# Arguments:
#   $1 -> category
#   $2 -> test name
#   $3 -> source
#   $4 -> expected diagnostic
###############################################################################

diagnostic() {

    [[ $# -eq 4 ]] || {
        error "diagnostic(): expected 4 arguments, got $#"
        return 1
    }

    local readonly category="$1"
    local readonly name="$2"
    local readonly source="$3"
    local readonly expected="$4"

    local readonly input_dir="$DIAGNOSTICS/$category"
    local readonly expected_dir="$EXPECTED/diagnostics/$category"

    ensure_directory "$input_dir"
    ensure_directory "$expected_dir"

    write_file "$input_dir/${name}.jua" <<EOF
# Diagnostic test.

$source
EOF

    write_file "$expected_dir/${name}.err" <<EOF
# Diagnostic test.

$expected
EOF

    return 0
}

###############################################################################
# Generates a parser regression test.
#
# Arguments:
#   $1 -> category
#   $2 -> test name
#   $3 -> source
#   $4 -> description
###############################################################################

regression() {

    [[ $# -eq 4 ]] || {
        error "regression(): expected 4 arguments, got $#"
        return 1
    }

    local readonly category="$1"
    local readonly name="$2"
    local readonly source="$3"
    local readonly description="$4"

    local readonly input_dir="$REGRESSION/$category"

    ensure_directory "$input_dir"

    write_file "$input_dir/${name}.jua" <<EOF
# Regression test.

$source
EOF

    write_file "$input_dir/${name}.txt" <<EOF
# Regression test.

$description
EOF

    return 0
}

###############################################################################
# Variable declaration tests
###############################################################################

generate_variable_tests() {

    header "Variable declarations"

    local count=0

    ###########################################################################
    # Immutable declarations
    ###########################################################################

    info "Immutable declarations"

    variable immutable immutable_integer "" "42"; ((++count))
    variable immutable immutable_zero "" "0"; ((++count))
    variable immutable immutable_negative "" "-42"; ((++count))

    variable immutable immutable_float "" "3.14f"; ((++count))
    variable immutable immutable_float_zero "" "0.0f"; ((++count))
    variable immutable immutable_float_negative "" "-3.14f"; ((++count))

    variable immutable immutable_double "" "3.141592653589793"; ((++count))
    variable immutable immutable_double_zero "" "0.0"; ((++count))
    variable immutable immutable_double_negative "" "-3.141592653589793"; ((++count))

    variable immutable immutable_string "" "\"Hello\""; ((++count))
    variable immutable immutable_empty_string "" "\"\""; ((++count))
    variable immutable immutable_string_spaces "" "\"Hello World\""; ((++count))

    variable immutable immutable_true "" "true"; ((++count))
    variable immutable immutable_false "" "false"; ((++count))
    variable immutable immutable_null "" "null"; ((++count))

    variable immutable immutable_identifier "" "other"; ((++count))

    variable immutable immutable_grouping "" "(42)"; ((++count))
    variable immutable immutable_nested_grouping "" "(((42)))"; ((++count))

    variable immutable immutable_unary_negate "" "-42"; ((++count))
    variable immutable immutable_unary_not "" "!false"; ((++count))

    variable immutable immutable_addition "" "1 + 2"; ((++count))
    variable immutable immutable_subtraction "" "5 - 2"; ((++count))
    variable immutable immutable_multiplication "" "4 * 3"; ((++count))
    variable immutable immutable_division "" "20 / 4"; ((++count))
    variable immutable immutable_modulo "" "20 % 3"; ((++count))

    variable immutable immutable_less "" "1 < 2"; ((++count))
    variable immutable immutable_less_equal "" "1 <= 2"; ((++count))
    variable immutable immutable_greater "" "2 > 1"; ((++count))
    variable immutable immutable_greater_equal "" "2 >= 1"; ((++count))

    variable immutable immutable_equal "" "1 == 1"; ((++count))
    variable immutable immutable_not_equal "" "1 != 2"; ((++count))

    variable immutable immutable_logical_and "" "true and false"; ((++count))
    variable immutable immutable_logical_or "" "true or false"; ((++count))

    variable immutable immutable_precedence "" "1 + 2 * 3"; ((++count))
    variable immutable immutable_grouping_precedence "" "(1 + 2) * 3"; ((++count))

    ###########################################################################
    # Mutable declarations
    ###########################################################################

    info "Mutable declarations"

    variable mutable mutable_integer "mutable" "42"; ((++count))
    variable mutable mutable_zero "mutable" "0"; ((++count))
    variable mutable mutable_negative "mutable" "-42"; ((++count))

    variable mutable mutable_float "mutable" "3.14f"; ((++count))
    variable mutable mutable_float_zero "mutable" "0.0f"; ((++count))
    variable mutable mutable_float_negative "mutable" "-3.14f"; ((++count))

    variable mutable mutable_double "mutable" "3.141592653589793"; ((++count))
    variable mutable mutable_double_zero "mutable" "0.0"; ((++count))
    variable mutable mutable_double_negative "mutable" "-3.141592653589793"; ((++count))

    variable mutable mutable_string "mutable" "\"Hello\""; ((++count))
    variable mutable mutable_empty_string "mutable" "\"\""; ((++count))
    variable mutable mutable_string_spaces "mutable" "\"Hello World\""; ((++count))

    variable mutable mutable_true "mutable" "true"; ((++count))
    variable mutable mutable_false "mutable" "false"; ((++count))
    variable mutable mutable_null "mutable" "null"; ((++count))

    variable mutable mutable_identifier "mutable" "other"; ((++count))

    variable mutable mutable_grouping "mutable" "(42)"; ((++count))
    variable mutable mutable_nested_grouping "mutable" "(((42)))"; ((++count))

    variable mutable mutable_unary_negate "mutable" "-42"; ((++count))
    variable mutable mutable_unary_not "mutable" "!false"; ((++count))

    variable mutable mutable_addition "mutable" "1 + 2"; ((++count))
    variable mutable mutable_subtraction "mutable" "5 - 2"; ((++count))
    variable mutable mutable_multiplication "mutable" "4 * 3"; ((++count))
    variable mutable mutable_division "mutable" "20 / 4"; ((++count))
    variable mutable mutable_modulo "mutable" "20 % 3"; ((++count))

    variable mutable mutable_less "mutable" "1 < 2"; ((++count))
    variable mutable mutable_less_equal "mutable" "1 <= 2"; ((++count))
    variable mutable mutable_greater "mutable" "2 > 1"; ((++count))
    variable mutable mutable_greater_equal "mutable" "2 >= 1"; ((++count))

    variable mutable mutable_equal "mutable" "1 == 1"; ((++count))
    variable mutable mutable_not_equal "mutable" "1 != 2"; ((++count))

    variable mutable mutable_logical_and "mutable" "true and false"; ((++count))
    variable mutable mutable_logical_or "mutable" "true or false"; ((++count))

    variable mutable mutable_precedence "mutable" "1 + 2 * 3"; ((++count))
    variable mutable mutable_grouping_precedence "mutable" "(1 + 2) * 3"; ((++count))

    ###########################################################################
    # Uninitialized declarations
    ###########################################################################

    info "Uninitialized declarations"

    variable uninitialized uninitialized_immutable "" ""; ((++count))
    variable uninitialized uninitialized_mutable "mutable" ""; ((++count))

    printf "  ✓ Generated %d variable declaration tests.\n" "$count"

}

generate_assignment_tests() {

    header "Assignment statements"

    local count=0

    ###########################################################################
    # Simple assignments
    ###########################################################################

    info "Simple assignments"

    assignment simple assign_integer              "42"; ((++count))
    assignment simple assign_zero                 "0"; ((++count))
    assignment simple assign_negative             "-42"; ((++count))

    assignment simple assign_float                "3.14f"; ((++count))
    assignment simple assign_double               "3.141592653589793"; ((++count))

    assignment simple assign_string               "\"Hello\""; ((++count))
    assignment simple assign_empty_string         "\"\""; ((++count))

    assignment simple assign_true                 "true"; ((++count))
    assignment simple assign_false                "false"; ((++count))
    assignment simple assign_null                 "null"; ((++count))

    assignment simple assign_identifier           "other"; ((++count))

    ###########################################################################
    # Unary expressions
    ###########################################################################

    info "Unary expressions"

    assignment expressions assign_unary_negate    "-42"; ((++count))
    assignment expressions assign_unary_not       "!false"; ((++count))

    ###########################################################################
    # Arithmetic expressions
    ###########################################################################

    info "Arithmetic expressions"

    assignment expressions assign_addition         "1 + 2"; ((++count))
    assignment expressions assign_subtraction      "5 - 2"; ((++count))
    assignment expressions assign_multiplication   "4 * 3"; ((++count))
    assignment expressions assign_division         "20 / 4"; ((++count))
    assignment expressions assign_modulo           "20 % 3"; ((++count))

    ###########################################################################
    # Comparison expressions
    ###########################################################################

    info "Comparison expressions"

    assignment expressions assign_less             "1 < 2"; ((++count))
    assignment expressions assign_less_equal       "1 <= 2"; ((++count))
    assignment expressions assign_greater          "2 > 1"; ((++count))
    assignment expressions assign_greater_equal    "2 >= 1"; ((++count))

    assignment expressions assign_equal            "1 == 1"; ((++count))
    assignment expressions assign_not_equal        "1 != 2"; ((++count))

    ###########################################################################
    # Logical expressions
    ###########################################################################

    info "Logical expressions"

    assignment expressions assign_logical_and      "true and false"; ((++count))
    assignment expressions assign_logical_or       "true or false"; ((++count))

    ###########################################################################
    # Grouping
    ###########################################################################

    info "Grouping"

    assignment expressions assign_grouping         "(1 + 2)"; ((++count))
    assignment expressions assign_nested_grouping  "(((42)))"; ((++count))

    ###########################################################################
    # Operator precedence
    ###########################################################################

    info "Operator precedence"

    assignment expressions assign_precedence_01    "1 + 2 * 3"; ((++count))
    assignment expressions assign_precedence_02    "(1 + 2) * 3"; ((++count))
    assignment expressions assign_precedence_03    "1 + 2 * 3 < 10"; ((++count))
    assignment expressions assign_precedence_04    "1 == 1 and true"; ((++count))
    assignment expressions assign_precedence_05    "true or false and true"; ((++count))
    assignment expressions assign_precedence_06    "!(1 == 2)"; ((++count))

    printf "  ✓ Generated %d assignment tests.\n" "$count"

}

###############################################################################
# Primary expressions
###############################################################################

generate_primary_tests() {

    header "Primary expressions"

    local count=0

    ###########################################################################
    # Integer literals
    ###########################################################################

    info "Integer literals"

    expression primary integer_zero              "0"; ((++count))
    expression primary integer_positive          "42"; ((++count))
    expression primary integer_negative          "-42"; ((++count))
    expression primary integer_large             "2147483647"; ((++count))
    expression primary integer_grouped           "(42)"; ((++count))
    expression primary integer_nested_grouped    "(((42)))"; ((++count))

    ###########################################################################
    # Float literals
    ###########################################################################

    info "Float literals"

    expression primary float_zero               "0.0f"; ((++count))
    expression primary float_positive           "3.14f"; ((++count))
    expression primary float_negative           "-3.14f"; ((++count))
    expression primary float_large              "999999.999f"; ((++count))
    expression primary float_grouped            "(3.14f)"; ((++count))

    ###########################################################################
    # Double literals
    ###########################################################################

    info "Double literals"

    expression primary double_zero             "0.0"; ((++count))
    expression primary double_positive         "3.141592653589793"; ((++count))
    expression primary double_negative         "-3.141592653589793"; ((++count))
    expression primary double_large            "9999999999.999999"; ((++count))
    expression primary double_grouped          "(3.141592653589793)"; ((++count))

    ###########################################################################
    # String literals
    ###########################################################################

    info "String literals"

    expression primary string_empty            "\"\""; ((++count))
    expression primary string_ascii            "\"hello\""; ((++count))
    expression primary string_spaces           "\"hello world\""; ((++count))
    expression primary string_symbols          "\"!@#$%^&*\""; ((++count))
    expression primary string_grouped          "(\"hello\")"; ((++count))

    ###########################################################################
    # Boolean literals
    ###########################################################################

    info "Boolean literals"

    expression primary boolean_true            "true"; ((++count))
    expression primary boolean_false           "false"; ((++count))
    expression primary grouped_true            "(true)"; ((++count))
    expression primary grouped_false           "(false)"; ((++count))

    ###########################################################################
    # Null literal
    ###########################################################################

    info "Null literal"

    expression primary null_literal            "null"; ((++count))
    expression primary grouped_null            "(null)"; ((++count))

    ###########################################################################
    # Identifier
    ###########################################################################

    info "Identifiers"

    expression \
        primary \
        identifier \
        "other" \
        "create other = 42"
    ((++count))

    expression \
        primary \
        grouped_identifier \
        "(other)" \
        "create other = 42"
    ((++count))

    expression \
        primary \
        nested_grouped_identifier \
        "(((other)))" \
        "create other = 42"
    ((++count))

    printf "  ✓ Generated %d primary expression tests.\n" "$count"

}

###############################################################################
# Unary expressions
###############################################################################

generate_unary_tests() {

    header "Unary expressions"

    local count=0

    ###########################################################################
    # Negation
    ###########################################################################

    info "Arithmetic negation"

    expression unary negate_integer                 "-42"; ((++count))
    expression unary negate_zero                    "-0"; ((++count))
    expression unary negate_float                   "-3.14f"; ((++count))
    expression unary negate_double                  "-3.141592653589793"; ((++count))

    ###########################################################################
    # Logical NOT
    ###########################################################################

    info "Logical NOT"

    expression unary not_true                       "!true"; ((++count))
    expression unary not_false                      "!false"; ((++count))

    ###########################################################################
    # Recursive unary expressions
    ###########################################################################

    info "Recursive unary expressions"

    expression unary double_negation                "--42"; ((++count))
    expression unary triple_negation                "---42"; ((++count))
    expression unary quadruple_negation             "----42"; ((++count))

    expression unary double_not                     "!!true"; ((++count))
    expression unary triple_not                     "!!!true"; ((++count))
    expression unary quadruple_not                  "!!!!true"; ((++count))

    ###########################################################################
    # Nested parenthesized unary expressions
    ###########################################################################

    info "Unary with grouping"

    expression unary negate_grouping                "-(42)"; ((++count))
    expression unary negate_nested_grouping         "-(((42)))"; ((++count))

    expression unary logical_not_grouping           "!(true)"; ((++count))
    expression unary logical_not_nested_grouping    "!(((true)))"; ((++count))

    ###########################################################################
    # Unary applied to expressions
    ###########################################################################

    info "Unary over expressions"

    expression unary negate_addition                "-(1 + 2)"; ((++count))
    expression unary negate_subtraction             "-(5 - 2)"; ((++count))
    expression unary negate_multiplication          "-(4 * 8)"; ((++count))
    expression unary negate_division                "-(20 / 4)"; ((++count))

    expression unary not_comparison                 "!(1 < 2)"; ((++count))
    expression unary not_equality                   "!(1 == 2)"; ((++count))
    expression unary not_logical                    "!(true and false)"; ((++count))

    ###########################################################################
    # Unary over identifiers
    ###########################################################################

    info "Unary over identifiers"

    expression \
        unary \
        negate_identifier \
        "-value" \
        "create value = 42"
    ((++count))

    expression \
        unary \
        logical_not_identifier \
        "!flag" \
        "create flag = true"
    ((++count))

    ###########################################################################
    # Mixed recursive unary expressions
    ###########################################################################

    info "Mixed recursive unary"

    expression unary negate_not_true                "-!true"; ((++count))
    expression unary not_negate_integer             "!-42"; ((++count))
    expression unary negate_not_grouped             "-(!(1 < 2))"; ((++count))
    expression unary not_negate_grouped             "!(-(1 + 2))"; ((++count))

    printf "  ✓ Generated %d unary expression tests.\n" "$count"

}

###############################################################################
# Multiplicative expressions
###############################################################################

generate_factor_tests() {

    header "Factor expressions"

    local count=0

    ###########################################################################
    # Multiplication
    ###########################################################################

    info "Multiplication"

    expression factor multiply_simple                     "2 * 3"; ((++count))
    expression factor multiply_zero                       "0 * 5"; ((++count))
    expression factor multiply_negative                   "-2 * 5"; ((++count))
    expression factor multiply_grouped                    "(2 + 3) * 4"; ((++count))
    expression factor multiply_nested_grouped             "((2 + 3)) * ((4))"; ((++count))

    ###########################################################################
    # Division
    ###########################################################################

    info "Division"

    expression factor divide_simple                       "20 / 5"; ((++count))
    expression factor divide_negative                     "-20 / 5"; ((++count))
    expression factor divide_grouped                      "(20 + 4) / 2"; ((++count))
    expression factor divide_nested_grouped               "((20)) / ((2))"; ((++count))

    ###########################################################################
    # Modulo
    ###########################################################################

    info "Modulo"

    expression factor modulo_simple                       "20 % 3"; ((++count))
    expression factor modulo_negative                     "-20 % 3"; ((++count))
    expression factor modulo_grouped                      "(20 + 1) % 4"; ((++count))

    ###########################################################################
    # Left associativity
    ###########################################################################

    info "Left associativity"

    expression factor multiply_chain                      "2 * 3 * 4"; ((++count))
    expression factor divide_chain                        "20 / 5 / 2"; ((++count))
    expression factor modulo_chain                        "20 % 7 % 3"; ((++count))

    ###########################################################################
    # Mixed multiplicative operators
    ###########################################################################

    info "Mixed multiplicative operators"

    expression factor multiply_divide                     "2 * 3 / 4"; ((++count))
    expression factor divide_multiply                     "20 / 5 * 3"; ((++count))
    expression factor multiply_modulo                     "8 * 3 % 5"; ((++count))
    expression factor modulo_multiply                     "20 % 6 * 2"; ((++count))
    expression factor divide_modulo                       "20 / 5 % 3"; ((++count))
    expression factor modulo_divide                       "20 % 6 / 2"; ((++count))

    ###########################################################################
    # Long chains
    ###########################################################################

    info "Long operator chains"

    expression factor chain_01                            "1 * 2 * 3 * 4"; ((++count))
    expression factor chain_02                            "100 / 2 / 5 / 2"; ((++count))
    expression factor chain_03                            "100 % 9 % 5 % 2"; ((++count))

    expression factor chain_04                            "1 * 2 / 3 % 4"; ((++count))
    expression factor chain_05                            "100 / 5 * 2 % 3"; ((++count))
    expression factor chain_06                            "100 % 9 * 3 / 2"; ((++count))

    ###########################################################################
    # Unary interaction
    ###########################################################################

    info "Unary interaction"

    expression factor unary_left                          "-2 * 4"; ((++count))
    expression factor unary_right                         "2 * -4"; ((++count))
    expression factor unary_both                          "-2 * -4"; ((++count))

    expression factor unary_division                      "-20 / -5"; ((++count))
    expression factor unary_modulo                        "-20 % -3"; ((++count))

    ###########################################################################
    # Grouping interaction
    ###########################################################################

    info "Grouping interaction"

    expression factor grouped_left                        "(2 + 3) * 4"; ((++count))
    expression factor grouped_right                       "4 * (2 + 3)"; ((++count))
    expression factor grouped_both                        "(2 + 3) * (4 + 5)"; ((++count))

    expression factor nested_grouping                     "((2 + 3)) * (((4)))"; ((++count))

    ###########################################################################
    # Identifier interaction
    ###########################################################################

    info "Identifier interaction"

    expression \
        factor \
        identifier_left \
        "value * 2" \
        "create value = 10"
    ((++count))

    expression \
        factor \
        identifier_right \
        "2 * value" \
        "create value = 10"
    ((++count))

    expression \
        factor \
        identifiers \
        "left * right" \
        $'create left = 2\ncreate right = 3'
    ((++count))

    ###########################################################################
    # Complex multiplicative expressions
    ###########################################################################

    info "Complex expressions"

    expression factor complex_01 "(1 + 2) * (3 + 4)"; ((++count))
    expression factor complex_02 "-(1 + 2) * (3 * 4)"; ((++count))
    expression factor complex_03 "((1 + 2) * 3) / (4 % 2 + 1)"; ((++count))
    expression factor complex_04 "-((2 * 3) % (4 + 5))"; ((++count))

    printf "  ✓ Generated %d factor expression tests.\n" "$count"

}

###############################################################################
# Additive expressions
###############################################################################

generate_term_tests() {

    header "Term expressions"

    local count=0

    ###########################################################################
    # Addition
    ###########################################################################

    info "Addition"

    expression term addition_simple                    "1 + 2"; ((++count))
    expression term addition_zero                      "0 + 5"; ((++count))
    expression term addition_negative                  "-1 + 2"; ((++count))
    expression term addition_grouped                   "(1 + 2) + 3"; ((++count))
    expression term addition_nested_grouping           "((1 + 2)) + (((3)))"; ((++count))

    ###########################################################################
    # Subtraction
    ###########################################################################

    info "Subtraction"

    expression term subtraction_simple                 "5 - 2"; ((++count))
    expression term subtraction_zero                   "5 - 0"; ((++count))
    expression term subtraction_negative               "-5 - -2"; ((++count))
    expression term subtraction_grouped                "(5 - 2) - 1"; ((++count))

    ###########################################################################
    # Left associativity
    ###########################################################################

    info "Left associativity"

    expression term addition_chain                     "1 + 2 + 3"; ((++count))
    expression term subtraction_chain                  "10 - 5 - 2"; ((++count))

    expression term long_addition_chain                "1 + 2 + 3 + 4 + 5"; ((++count))
    expression term long_subtraction_chain             "20 - 5 - 4 - 3 - 2"; ((++count))

    ###########################################################################
    # Mixed additive operators
    ###########################################################################

    info "Mixed additive operators"

    expression term add_subtract                       "1 + 2 - 3"; ((++count))
    expression term subtract_add                       "10 - 5 + 3"; ((++count))

    expression term mixed_chain_01                     "1 + 2 - 3 + 4"; ((++count))
    expression term mixed_chain_02                     "20 - 5 + 3 - 1"; ((++count))

    ###########################################################################
    # Precedence over factor
    ###########################################################################

    info "Operator precedence"

    expression term precedence_01                      "1 + 2 * 3"; ((++count))
    expression term precedence_02                      "2 * 3 + 4"; ((++count))
    expression term precedence_03                      "8 / 2 + 1"; ((++count))
    expression term precedence_04                      "8 + 6 / 2"; ((++count))
    expression term precedence_05                      "8 % 3 + 2"; ((++count))
    expression term precedence_06                      "8 + 10 % 4"; ((++count))

    ###########################################################################
    # Parenthesized precedence
    ###########################################################################

    info "Grouped precedence"

    expression term grouped_precedence_01              "(1 + 2) * 3"; ((++count))
    expression term grouped_precedence_02              "3 * (1 + 2)"; ((++count))
    expression term grouped_precedence_03              "(8 - 2) / 3"; ((++count))
    expression term grouped_precedence_04              "8 / (6 - 2)"; ((++count))

    ###########################################################################
    # Unary interaction
    ###########################################################################

    info "Unary interaction"

    expression term unary_left                         "-1 + 2"; ((++count))
    expression term unary_right                        "1 + -2"; ((++count))
    expression term unary_both                         "-1 + -2"; ((++count))

    expression term unary_subtraction                  "-10 - -5"; ((++count))

    ###########################################################################
    # Identifier interaction
    ###########################################################################

    info "Identifier interaction"

    expression \
        term \
        identifier_left \
        "value + 2" \
        "create value = 10"
    ((++count))

    expression \
        term \
        identifier_right \
        "2 + value" \
        "create value = 10"
    ((++count))

    expression \
        term \
        identifiers_addition \
        "left + right" \
        $'create left = 10\ncreate right = 20'
    ((++count))

    expression \
        term \
        identifiers_subtraction \
        "left - right" \
        $'create left = 10\ncreate right = 20'
    ((++count))

    ###########################################################################
    # Deep recursive expressions
    ###########################################################################

    info "Recursive expressions"

    expression term recursive_01                       "((((1 + 2))))"; ((++count))
    expression term recursive_02                       "(((1 + 2) - (3 + 4)))"; ((++count))
    expression term recursive_03                       "((((1)))) + ((((2))))"; ((++count))

    ###########################################################################
    # Complex expressions
    ###########################################################################

    info "Complex expressions"

    expression term complex_01                         "(1 + 2) * (3 + 4) - 5"; ((++count))
    expression term complex_02                         "1 + 2 * 3 - 4 / 2"; ((++count))
    expression term complex_03                         "-(1 + 2) + (3 * 4)"; ((++count))
    expression term complex_04                         "((1 + 2) * (3 + 4)) - (5 % 2)"; ((++count))
    expression term complex_05                         "((1 + 2 + 3) * (4 - 2)) / 5"; ((++count))

    printf "  ✓ Generated %d term expression tests.\n" "$count"

}

###############################################################################
# Comparison expressions
###############################################################################

generate_comparison_tests() {

    header "Comparison expressions"

    local count=0

    ###########################################################################
    # Less than
    ###########################################################################

    info "Less than"

    expression comparison less_simple                 "1 < 2"; ((++count))
    expression comparison less_negative               "-1 < 2"; ((++count))
    expression comparison less_grouped                "(1 + 2) < 5"; ((++count))
    expression comparison less_complex                "1 + 2 < 3 * 4"; ((++count))

    ###########################################################################
    # Less or equal
    ###########################################################################

    info "Less or equal"

    expression comparison less_equal_simple           "1 <= 2"; ((++count))
    expression comparison less_equal_negative         "-1 <= 2"; ((++count))
    expression comparison less_equal_grouped          "(2 + 3) <= 5"; ((++count))
    expression comparison less_equal_complex          "1 + 2 <= 3 * 4"; ((++count))

    ###########################################################################
    # Greater than
    ###########################################################################

    info "Greater than"

    expression comparison greater_simple              "5 > 2"; ((++count))
    expression comparison greater_negative            "-5 > -10"; ((++count))
    expression comparison greater_grouped             "(5 * 2) > (3 + 1)"; ((++count))
    expression comparison greater_complex             "5 * 3 > 10 + 1"; ((++count))

    ###########################################################################
    # Greater or equal
    ###########################################################################

    info "Greater or equal"

    expression comparison greater_equal_simple        "5 >= 2"; ((++count))
    expression comparison greater_equal_negative      "-5 >= -10"; ((++count))
    expression comparison greater_equal_grouped       "(5 * 2) >= (3 + 1)"; ((++count))
    expression comparison greater_equal_complex       "5 * 3 >= 10 + 1"; ((++count))

    ###########################################################################
    # Unary interaction
    ###########################################################################

    info "Unary interaction"

    expression comparison unary_left                  "-1 < 2"; ((++count))
    expression comparison unary_right                 "1 < -2"; ((++count))
    expression comparison unary_both                  "-1 < -2"; ((++count))

    ###########################################################################
    # Grouping
    ###########################################################################

    info "Grouping"

    expression comparison grouping_left               "(1 + 2) < 4"; ((++count))
    expression comparison grouping_right              "4 < (5 + 6)"; ((++count))
    expression comparison grouping_both               "(1 + 2) < (3 + 4)"; ((++count))

    ###########################################################################
    # Identifier interaction
    ###########################################################################

    info "Identifiers"

    expression \
        comparison \
        identifier_left \
        "value < 10" \
        "create value = 5"
    ((++count))

    expression \
        comparison \
        identifier_right \
        "10 < value" \
        "create value = 20"
    ((++count))

    expression \
        comparison \
        identifiers \
        "left < right" \
        $'create left = 1\ncreate right = 2'
    ((++count))

    ###########################################################################
    # Arithmetic interaction
    ###########################################################################

    info "Arithmetic interaction"

    expression comparison arithmetic_01              "1 + 2 < 3 + 4"; ((++count))
    expression comparison arithmetic_02              "2 * 3 < 4 * 5"; ((++count))
    expression comparison arithmetic_03              "(1 + 2) * 3 < 20"; ((++count))
    expression comparison arithmetic_04              "10 < (3 + 4) * 2"; ((++count))

    ###########################################################################
    # Deep expressions
    ###########################################################################

    info "Deep expressions"

    expression comparison deep_01                    "((1 + 2) * 3) < ((4 + 5) * 6)"; ((++count))
    expression comparison deep_02                    "-((1 + 2) * 3) >= ((4 - 5) * 6)"; ((++count))

    printf "  ✓ Generated %d comparison expression tests.\n" "$count"

}

###############################################################################
# Equality expressions
###############################################################################

generate_equality_tests() {

    header "Equality expressions"

    local count=0

    ###########################################################################
    # Equality
    ###########################################################################

    info "Equality"

    expression equality equal_integer                  "1 == 1"; ((++count))
    expression equality equal_float                    "1.5f == 1.5f"; ((++count))
    expression equality equal_double                   "3.14 == 3.14"; ((++count))
    expression equality equal_string                   "\"abc\" == \"abc\""; ((++count))
    expression equality equal_true                     "true == true"; ((++count))
    expression equality equal_false                    "false == false"; ((++count))
    expression equality equal_null                     "null == null"; ((++count))

    ###########################################################################
    # Not equal
    ###########################################################################

    info "Not equal"

    expression equality not_equal_integer              "1 != 2"; ((++count))
    expression equality not_equal_float                "1.5f != 2.5f"; ((++count))
    expression equality not_equal_double               "3.14 != 2.71"; ((++count))
    expression equality not_equal_string               "\"abc\" != \"def\""; ((++count))
    expression equality not_equal_boolean              "true != false"; ((++count))
    expression equality not_equal_null                 "null != true"; ((++count))

    ###########################################################################
    # Left associativity
    ###########################################################################

    info "Left associativity"

    expression equality equal_chain                    "1 == 2 == 3"; ((++count))
    expression equality not_equal_chain                "1 != 2 != 3"; ((++count))
    expression equality mixed_chain                    "1 == 2 != 3"; ((++count))
    expression equality mixed_chain_reverse            "1 != 2 == 3"; ((++count))

    ###########################################################################
    # Comparison interaction
    ###########################################################################

    info "Comparison interaction"

    expression equality comparison_left                "1 < 2 == true"; ((++count))
    expression equality comparison_right               "true == 1 < 2"; ((++count))

    expression equality less_equal                     "1 <= 2 == true"; ((++count))
    expression equality greater                        "5 > 3 == true"; ((++count))
    expression equality greater_equal                  "5 >= 5 == true"; ((++count))

    ###########################################################################
    # Arithmetic interaction
    ###########################################################################

    info "Arithmetic interaction"

    expression equality arithmetic_equal               "1 + 2 == 3"; ((++count))
    expression equality arithmetic_not_equal           "2 * 3 != 5"; ((++count))
    expression equality grouped_arithmetic             "(1 + 2) == (3 * 1)"; ((++count))
    expression equality nested_arithmetic              "((1 + 2) * 3) == 9"; ((++count))

    ###########################################################################
    # Unary interaction
    ###########################################################################

    info "Unary interaction"

    expression equality unary_not                      "!true == false"; ((++count))
    expression equality unary_negation                 "-1 == -1"; ((++count))
    expression equality grouped_unary                  "!(1 < 2) == false"; ((++count))

    ###########################################################################
    # Grouping
    ###########################################################################

    info "Grouping"

    expression equality grouped_equal                  "(1 == 1)"; ((++count))
    expression equality nested_grouping                "(((1 == 1)))"; ((++count))
    expression equality grouped_not_equal              "(1 != 2)"; ((++count))

    ###########################################################################
    # Identifier interaction
    ###########################################################################

    info "Identifiers"

    expression \
        equality \
        identifier_equal \
        "value == 10" \
        "create value = 10"
    ((++count))

    expression \
        equality \
        identifier_not_equal \
        "value != 20" \
        "create value = 10"
    ((++count))

    expression \
        equality \
        identifiers_equal \
        "left == right" \
        $'create left = 10\ncreate right = 10'
    ((++count))

    expression \
        equality \
        identifiers_not_equal \
        "left != right" \
        $'create left = 10\ncreate right = 20'
    ((++count))

    ###########################################################################
    # Complex expressions
    ###########################################################################

    info "Complex expressions"

    expression equality complex_01 \
        "(1 + 2) * 3 == 9"
    ((++count))

    expression equality complex_02 \
        "(1 < 2) == (3 > 4)"
    ((++count))

    expression equality complex_03 \
        "!(1 < 2) != (3 == 4)"
    ((++count))

    expression equality complex_04 \
        "((1 + 2) * (3 + 4)) == 21"
    ((++count))

    expression equality complex_05 \
        "((1 + 2) * (3 + 4)) != ((5 + 6) * 2)"
    ((++count))

    printf "  ✓ Generated %d equality expression tests.\n" "$count"

}

###############################################################################
# Logical AND expressions
###############################################################################

generate_logical_and_tests() {

    header "Logical AND expressions"

    local count=0

    ###########################################################################
    # Simple AND
    ###########################################################################

    info "Simple logical AND"

    expression logical and_true_true              "true and true"; ((++count))
    expression logical and_true_false             "true and false"; ((++count))
    expression logical and_false_true             "false and true"; ((++count))
    expression logical and_false_false            "false and false"; ((++count))

    ###########################################################################
    # Equality interaction
    ###########################################################################

    info "Equality interaction"

    expression logical and_equal                  "1 == 1 and true"; ((++count))
    expression logical and_not_equal              "1 != 2 and false"; ((++count))
    expression logical and_comparison             "1 < 2 and 3 > 2"; ((++count))
    expression logical and_arithmetic             "(1 + 2) == 3 and (4 * 2) == 8"; ((++count))

    ###########################################################################
    # Left associativity
    ###########################################################################

    info "Left associativity"

    expression logical and_chain_01               "true and true and true"; ((++count))
    expression logical and_chain_02               "true and false and true"; ((++count))
    expression logical and_chain_03               "false and true and false"; ((++count))
    expression logical and_chain_04               "true and true and true and false"; ((++count))

    ###########################################################################
    # Unary interaction
    ###########################################################################

    info "Unary interaction"

    expression logical and_unary_01               "!true and false"; ((++count))
    expression logical and_unary_02               "true and !false"; ((++count))
    expression logical and_unary_03               "!true and !false"; ((++count))

    ###########################################################################
    # Grouping
    ###########################################################################

    info "Grouping"

    expression logical and_group_01               "(true and false)"; ((++count))
    expression logical and_group_02               "(1 < 2) and (3 < 4)"; ((++count))
    expression logical and_group_03               "((true)) and (((false)))"; ((++count))

    ###########################################################################
    # Identifiers
    ###########################################################################

    info "Identifiers"

    expression \
        logical \
        and_identifier_left \
        "left and true" \
        "create left = true"
    ((++count))

    expression \
        logical \
        and_identifier_right \
        "true and right" \
        "create right = false"
    ((++count))

    expression \
        logical \
        and_identifiers \
        "left and right" \
        $'create left = true\ncreate right = false'
    ((++count))

    ###########################################################################
    # Complex
    ###########################################################################

    info "Complex expressions"

    expression logical complex_and_01 \
        "(1 + 2 == 3) and ((4 * 5) > 10)"
    ((++count))

    expression logical complex_and_02 \
        "!(1 == 2) and ((3 < 4) == true)"
    ((++count))

    printf "  ✓ Generated %d logical AND tests.\n" "$count"

}

###############################################################################
# Logical OR expressions
###############################################################################

generate_logical_or_tests() {

    header "Logical OR expressions"

    local count=0

    ###########################################################################
    # Simple OR
    ###########################################################################

    info "Simple logical OR"

    expression logical or_true_true               "true or true"; ((++count))
    expression logical or_true_false              "true or false"; ((++count))
    expression logical or_false_true              "false or true"; ((++count))
    expression logical or_false_false             "false or false"; ((++count))

    ###########################################################################
    # Equality interaction
    ###########################################################################

    info "Equality interaction"

    expression logical or_equal                   "1 == 1 or false"; ((++count))
    expression logical or_not_equal               "1 != 2 or false"; ((++count))
    expression logical or_comparison              "1 < 2 or 3 > 5"; ((++count))
    expression logical or_arithmetic              "(1 + 2) == 3 or (4 * 2) == 7"; ((++count))

    ###########################################################################
    # Left associativity
    ###########################################################################

    info "Left associativity"

    expression logical or_chain_01                "true or true or true"; ((++count))
    expression logical or_chain_02                "true or false or true"; ((++count))
    expression logical or_chain_03                "false or false or true"; ((++count))
    expression logical or_chain_04                "false or false or false or true"; ((++count))

    ###########################################################################
    # AND precedence
    ###########################################################################

    info "AND precedence"

    expression logical precedence_01              "true or false and true"; ((++count))
    expression logical precedence_02              "false and true or true"; ((++count))
    expression logical precedence_03              "true or true and false"; ((++count))
    expression logical precedence_04              "true and false or false"; ((++count))
    expression logical precedence_05              "true or false and false or true"; ((++count))

    ###########################################################################
    # Unary interaction
    ###########################################################################

    info "Unary interaction"

    expression logical or_unary_01                "!true or false"; ((++count))
    expression logical or_unary_02                "true or !false"; ((++count))
    expression logical or_unary_03                "!true or !false"; ((++count))

    ###########################################################################
    # Grouping
    ###########################################################################

    info "Grouping"

    expression logical or_group_01                "(true or false)"; ((++count))
    expression logical or_group_02                "(true and false) or true"; ((++count))
    expression logical or_group_03                "true or (false and true)"; ((++count))
    expression logical or_group_04                "(true or false) and true"; ((++count))

    ###########################################################################
    # Identifiers
    ###########################################################################

    info "Identifiers"

    expression \
        logical \
        or_identifier_left \
        "left or true" \
        "create left = false"
    ((++count))

    expression \
        logical \
        or_identifier_right \
        "true or right" \
        "create right = false"
    ((++count))

    expression \
        logical \
        or_identifiers \
        "left or right" \
        $'create left = false\ncreate right = true'
    ((++count))

    ###########################################################################
    # Complex expressions
    ###########################################################################

    info "Complex expressions"

    expression logical complex_or_01 \
        "(1 + 2 == 3) or ((4 * 5) > 30)"
    ((++count))

    expression logical complex_or_02 \
        "!(1 == 2) or ((3 < 4) == false)"
    ((++count))

    expression logical complex_or_03 \
        "(true and false) or (false and true) or true"
    ((++count))

    printf "  ✓ Generated %d logical OR tests.\n" "$count"

}

###############################################################################
# Operator precedence tests
###############################################################################

generate_precedence_tests() {

    header "Operator precedence"

    local count=0

    ###########################################################################
    # Unary > Factor
    ###########################################################################

    info "Unary over multiplicative"

    expression precedence unary_factor_01                 "-1 * 2"; ((++count))
    expression precedence unary_factor_02                 "2 * -3"; ((++count))
    expression precedence unary_factor_03                 "-1 / -2"; ((++count))
    expression precedence unary_factor_04                 "-1 % 2"; ((++count))

    ###########################################################################
    # Factor > Term
    ###########################################################################

    info "Multiplication before addition"

    expression precedence factor_term_01                  "1 + 2 * 3"; ((++count))
    expression precedence factor_term_02                  "2 * 3 + 4"; ((++count))
    expression precedence factor_term_03                  "10 - 6 / 2"; ((++count))
    expression precedence factor_term_04                  "12 % 5 + 3"; ((++count))
    expression precedence factor_term_05                  "1 + 2 * 3 - 4"; ((++count))
    expression precedence factor_term_06                  "8 / 2 + 5 * 3"; ((++count))

    ###########################################################################
    # Parentheses override precedence
    ###########################################################################

    info "Grouping"

    expression precedence grouping_01                     "(1 + 2) * 3"; ((++count))
    expression precedence grouping_02                     "3 * (1 + 2)"; ((++count))
    expression precedence grouping_03                     "(10 - 4) / 2"; ((++count))
    expression precedence grouping_04                     "10 / (6 - 1)"; ((++count))
    expression precedence grouping_05                     "((1 + 2) * 3)"; ((++count))

    ###########################################################################
    # Comparison after arithmetic
    ###########################################################################

    info "Comparison"

    expression precedence comparison_01                  "1 + 2 < 4"; ((++count))
    expression precedence comparison_02                  "2 * 3 > 5"; ((++count))
    expression precedence comparison_03                  "10 - 4 <= 8"; ((++count))
    expression precedence comparison_04                  "20 / 4 >= 5"; ((++count))
    expression precedence comparison_05                  "(1 + 2) * 3 < 20"; ((++count))

    ###########################################################################
    # Equality after comparison
    ###########################################################################

    info "Equality"

    expression precedence equality_01                    "1 < 2 == true"; ((++count))
    expression precedence equality_02                    "3 > 2 != false"; ((++count))
    expression precedence equality_03                    "(1 + 2) == (3 * 1)"; ((++count))
    expression precedence equality_04                    "5 >= 5 == true"; ((++count))

    ###########################################################################
    # Logical AND after equality
    ###########################################################################

    info "Logical AND"

    expression precedence logical_and_01                 "1 == 1 and true"; ((++count))
    expression precedence logical_and_02                 "1 < 2 and 3 > 2"; ((++count))
    expression precedence logical_and_03                 "true and false == false"; ((++count))
    expression precedence logical_and_04                 "(1 + 2 == 3) and (4 > 2)"; ((++count))

    ###########################################################################
    # Logical OR after AND
    ###########################################################################

    info "Logical OR"

    expression precedence logical_or_01                  "true or false and true"; ((++count))
    expression precedence logical_or_02                  "false and true or true"; ((++count))
    expression precedence logical_or_03                  "true or true and false"; ((++count))
    expression precedence logical_or_04                  "true and false or false"; ((++count))
    expression precedence logical_or_05                  "(true or false) and true"; ((++count))

    ###########################################################################
    # Mixed hierarchy
    ###########################################################################

    info "Mixed hierarchy"

    expression precedence hierarchy_01 \
        "1 + 2 * 3 < 10"
    ((++count))

    expression precedence hierarchy_02 \
        "1 + 2 * 3 == 7"
    ((++count))

    expression precedence hierarchy_03 \
        "1 + 2 * 3 == 7 and true"
    ((++count))

    expression precedence hierarchy_04 \
        "1 + 2 * 3 == 7 and true or false"
    ((++count))

    expression precedence hierarchy_05 \
        "!(1 + 2 * 3 == 7)"
    ((++count))

    expression precedence hierarchy_06 \
        "!(1 + 2 * 3 == 7) or false"
    ((++count))

    expression precedence hierarchy_07 \
        "!(1 + 2 * 3 == 7) or false and true"
    ((++count))

    ###########################################################################
    # Deep nesting
    ###########################################################################

    info "Deep nesting"

    expression precedence deep_01 \
        "(((1 + 2) * (3 + 4)))"
    ((++count))

    expression precedence deep_02 \
        "((((1 + 2) * (3 + 4)) == 21))"
    ((++count))

    expression precedence deep_03 \
        "((((1 + 2) * (3 + 4)) == 21) and true)"
    ((++count))

    expression precedence deep_04 \
        "((((1 + 2) * (3 + 4)) == 21) and true) or false"
    ((++count))

    ###########################################################################
    # Stress expressions
    ###########################################################################

    info "Stress expressions"

    expression precedence stress_01 \
        "1 + 2 * 3 - 4 / 2 % 2"
    ((++count))

    expression precedence stress_02 \
        "1 + 2 * 3 < 10 == true"
    ((++count))

    expression precedence stress_03 \
        "1 + 2 * 3 < 10 == true and false"
    ((++count))

    expression precedence stress_04 \
        "1 + 2 * 3 < 10 == true and false or true"
    ((++count))

    expression precedence stress_05 \
        "!(1 + 2 * 3 < 10 == true and false or true)"
    ((++count))

    ###########################################################################
    # Maximum parser depth
    ###########################################################################

    info "Parser depth"

    expression precedence depth_01 \
        "((((((((((((42))))))))))))"
    ((++count))

    expression precedence depth_02 \
        "-(-(-(-(-42))))"
    ((++count))

    expression precedence depth_03 \
        "!(!(!(!true)))"
    ((++count))

    printf "  ✓ Generated %d precedence tests.\n" "$count"

}

###############################################################################
# Variable declaration diagnostics
###############################################################################

generate_declaration_diagnostics() {

    header "Declaration diagnostics"

    local count=0

    diagnostic declaration missing_identifier \
        "create = 10" \
        "syntax-error"
    ((++count))

    diagnostic declaration missing_assignment \
        "create value 10" \
        "syntax-error"
    ((++count))

    diagnostic declaration missing_initializer \
        "create value =" \
        "syntax-error"
    ((++count))

    diagnostic declaration mutable_missing_identifier \
        "create mutable = 10" \
        "syntax-error"
    ((++count))

    diagnostic declaration mutable_missing_assignment \
        "create mutable value 10" \
        "syntax-error"
    ((++count))

    diagnostic declaration mutable_missing_initializer \
        "create mutable value =" \
        "syntax-error"
    ((++count))

    diagnostic declaration duplicated_assign \
        "create value = = 10" \
        "syntax-error"
    ((++count))

    diagnostic declaration keyword_identifier \
        "create create = 10" \
        "syntax-error"
    ((++count))

    diagnostic declaration mutable_keyword_identifier \
        "create mutable mutable = 10" \
        "syntax-error"
    ((++count))

    diagnostic declaration invalid_identifier_literal \
        "create 123abc = 10" \
        "syntax-error"
    ((++count))

    diagnostic declaration missing_newline \
        $'create value = 10 create other = 20' \
        "syntax-error"
    ((++count))

    diagnostic declaration dangling_create \
        "create" \
        "syntax-error"
    ((++count))

    diagnostic declaration dangling_mutable \
        "create mutable" \
        "syntax-error"
    ((++count))

    diagnostic declaration dangling_identifier \
        "create value" \
        "syntax-error"
    ((++count))

    diagnostic declaration dangling_assign \
        "create value =" \
        "syntax-error"
    ((++count))

    printf "  ✓ Generated %d declaration diagnostics.\n" "$count"

}

###############################################################################
# Assignment diagnostics
###############################################################################

generate_assignment_diagnostics() {

    header "Assignment diagnostics"

    local count=0

    diagnostic assignment missing_identifier \
        "= 10" \
        "syntax-error"
    ((++count))

    diagnostic assignment missing_value \
        "value =" \
        "syntax-error"
    ((++count))

    diagnostic assignment double_assign \
        "value = = 10" \
        "syntax-error"
    ((++count))

    diagnostic assignment equality_operator \
        "value == 10" \
        "syntax-error"
    ((++count))

    diagnostic assignment mutable_keyword \
        "mutable = 10" \
        "syntax-error"
    ((++count))

    diagnostic assignment create_keyword \
        "create = 10" \
        "syntax-error"
    ((++count))

    diagnostic assignment operator_only \
        "=" \
        "syntax-error"
    ((++count))

    diagnostic assignment dangling_identifier \
        "value" \
        "syntax-error"
    ((++count))

    printf "  ✓ Generated %d assignment diagnostics.\n" "$count"

}

###############################################################################
# Unary diagnostics
###############################################################################

generate_unary_diagnostics() {

    header "Unary diagnostics"

    local count=0

    diagnostic unary missing_operand_minus \
        "-" \
        "syntax-error"
    ((++count))

    diagnostic unary missing_operand_not \
        "!" \
        "syntax-error"
    ((++count))

    diagnostic unary declaration_minus \
        "create value = -" \
        "syntax-error"
    ((++count))

    diagnostic unary declaration_not \
        "create value = !" \
        "syntax-error"
    ((++count))

    diagnostic unary double_minus \
        "--" \
        "syntax-error"
    ((++count))

    diagnostic unary double_not \
        "!!" \
        "syntax-error"
    ((++count))

    diagnostic unary minus_before_operator \
        "- +" \
        "syntax-error"
    ((++count))

    diagnostic unary not_before_operator \
        "! *" \
        "syntax-error"
    ((++count))

    printf "  ✓ Generated %d unary diagnostics.\n" "$count"

}

###############################################################################
# Binary operator diagnostics
###############################################################################

generate_binary_diagnostics() {

    header "Binary diagnostics"

    local count=0

    diagnostic binary plus_missing_rhs \
        "1 +" \
        "syntax-error"
    ((++count))

    diagnostic binary minus_missing_rhs \
        "1 -" \
        "syntax-error"
    ((++count))

    diagnostic binary star_missing_rhs \
        "1 *" \
        "syntax-error"
    ((++count))

    diagnostic binary slash_missing_rhs \
        "1 /" \
        "syntax-error"
    ((++count))

    diagnostic binary modulo_missing_rhs \
        "1 %" \
        "syntax-error"
    ((++count))

    diagnostic binary plus_missing_lhs \
        "+ 1" \
        "syntax-error"
    ((++count))

    diagnostic binary star_missing_lhs \
        "* 1" \
        "syntax-error"
    ((++count))

    diagnostic binary slash_missing_lhs \
        "/ 1" \
        "syntax-error"
    ((++count))

    diagnostic binary modulo_missing_lhs \
        "% 1" \
        "syntax-error"
    ((++count))

    diagnostic binary duplicated_plus \
        "1 + + 2" \
        "syntax-error"
    ((++count))

    diagnostic binary duplicated_minus \
        "1 - - 2" \
        "syntax-error"
    ((++count))

    diagnostic binary duplicated_star \
        "1 * * 2" \
        "syntax-error"
    ((++count))

    diagnostic binary duplicated_slash \
        "1 / / 2" \
        "syntax-error"
    ((++count))

    diagnostic binary duplicated_modulo \
        "1 % % 2" \
        "syntax-error"
    ((++count))

    printf "  ✓ Generated %d binary diagnostics.\n" "$count"

}

###############################################################################
# Comparison diagnostics
###############################################################################

generate_comparison_diagnostics() {

    header "Comparison diagnostics"

    local count=0

    diagnostic comparison less_missing_rhs \
        "1 <" \
        "syntax-error"
    ((++count))

    diagnostic comparison less_equal_missing_rhs \
        "1 <=" \
        "syntax-error"
    ((++count))

    diagnostic comparison greater_missing_rhs \
        "1 >" \
        "syntax-error"
    ((++count))

    diagnostic comparison greater_equal_missing_rhs \
        "1 >=" \
        "syntax-error"
    ((++count))

    diagnostic comparison chained_less \
        "1 < 2 < 3" \
        "syntax-error"
    ((++count))

    diagnostic comparison chained_less_equal \
        "1 <= 2 <= 3" \
        "syntax-error"
    ((++count))

    diagnostic comparison chained_greater \
        "5 > 4 > 3" \
        "syntax-error"
    ((++count))

    diagnostic comparison chained_greater_equal \
        "5 >= 4 >= 3" \
        "syntax-error"
    ((++count))

    diagnostic comparison mixed_chain \
        "1 < 2 >= 3" \
        "syntax-error"
    ((++count))

    printf "  ✓ Generated %d comparison diagnostics.\n" "$count"

}

###############################################################################
# Equality diagnostics
###############################################################################

generate_equality_diagnostics() {

    header "Equality diagnostics"

    local count=0

    diagnostic equality equal_missing_rhs \
        "1 ==" \
        "syntax-error"
    ((++count))

    diagnostic equality not_equal_missing_rhs \
        "1 !=" \
        "syntax-error"
    ((++count))

    diagnostic equality equal_missing_lhs \
        "== true" \
        "syntax-error"
    ((++count))

    diagnostic equality not_equal_missing_lhs \
        "!= false" \
        "syntax-error"
    ((++count))

    diagnostic equality quadruple_equal \
        "1 ==== 2" \
        "syntax-error"
    ((++count))

    diagnostic equality duplicated_not_equal \
        "1 != != 2" \
        "syntax-error"
    ((++count))

    printf "  ✓ Generated %d equality diagnostics.\n" "$count"

}

###############################################################################
# Logical diagnostics
###############################################################################

generate_logical_diagnostics() {

    header "Logical diagnostics"

    local count=0

    ###########################################################################
    # Missing operands
    ###########################################################################

    diagnostic logical and_missing_rhs \
        "true and" \
        "syntax-error"
    ((++count))

    diagnostic logical or_missing_rhs \
        "true or" \
        "syntax-error"
    ((++count))

    diagnostic logical and_missing_lhs \
        "and true" \
        "syntax-error"
    ((++count))

    diagnostic logical or_missing_lhs \
        "or false" \
        "syntax-error"
    ((++count))

    ###########################################################################
    # Duplicated operators
    ###########################################################################

    diagnostic logical duplicated_and \
        "true and and false" \
        "syntax-error"
    ((++count))

    diagnostic logical duplicated_or \
        "true or or false" \
        "syntax-error"
    ((++count))

    diagnostic logical mixed_operator \
        "true and or false" \
        "syntax-error"
    ((++count))

    diagnostic logical mixed_operator_reverse \
        "true or and false" \
        "syntax-error"
    ((++count))

    ###########################################################################
    # Dangling logical operators
    ###########################################################################

    diagnostic logical dangling_and \
        "and" \
        "syntax-error"
    ((++count))

    diagnostic logical dangling_or \
        "or" \
        "syntax-error"
    ((++count))

    printf "  ✓ Generated %d logical diagnostics.\n" "$count"

}

###############################################################################
# Grouping diagnostics
###############################################################################

generate_grouping_diagnostics() {

    header "Grouping diagnostics"

    local count=0

    ###########################################################################
    # Missing parenthesis
    ###########################################################################

    diagnostic grouping missing_right_parenthesis \
        "(1 + 2" \
        "syntax-error"
    ((++count))

    diagnostic grouping missing_left_parenthesis \
        "1 + 2)" \
        "syntax-error"
    ((++count))

    diagnostic grouping nested_missing_right \
        "((1 + 2)" \
        "syntax-error"
    ((++count))

    diagnostic grouping nested_missing_left \
        "(1 + 2))" \
        "syntax-error"
    ((++count))

    ###########################################################################
    # Empty grouping
    ###########################################################################

    diagnostic grouping empty_group \
        "()" \
        "syntax-error"
    ((++count))

    diagnostic grouping nested_empty_group \
        "(())" \
        "syntax-error"
    ((++count))

    ###########################################################################
    # Operator inside grouping
    ###########################################################################

    diagnostic grouping operator_only \
        "(+)" \
        "syntax-error"
    ((++count))

    diagnostic grouping unary_only \
        "(!)" \
        "syntax-error"
    ((++count))

    printf "  ✓ Generated %d grouping diagnostics.\n" "$count"

}

###############################################################################
# Layout diagnostics
###############################################################################

generate_layout_diagnostics() {

    header "Layout diagnostics"

    local count=0

    ###########################################################################
    # Missing newline
    ###########################################################################

    diagnostic layout declaration_without_newline \
        "create a = 1 create b = 2" \
        "syntax-error"
    ((++count))

    diagnostic layout assignment_without_newline \
        "a = 1 b = 2" \
        "syntax-error"
    ((++count))

    ###########################################################################
    # Consecutive expressions
    ###########################################################################

    diagnostic layout consecutive_literals \
        $'1\n2' \
        "syntax-error"
    ((++count))

    diagnostic layout consecutive_binary \
        $'1 + 2\n3 + 4' \
        "syntax-error"
    ((++count))

    ###########################################################################
    # Unexpected blank continuation
    ###########################################################################

    diagnostic layout split_expression \
        $'1 +\n2' \
        "syntax-error"
    ((++count))

    printf "  ✓ Generated %d layout diagnostics.\n" "$count"

}

###############################################################################
# EOF diagnostics
###############################################################################

generate_eof_diagnostics() {

    header "EOF diagnostics"

    local count=0

    diagnostic eof create \
        "create" \
        "syntax-error"
    ((++count))

    diagnostic eof mutable \
        "create mutable" \
        "syntax-error"
    ((++count))

    diagnostic eof identifier \
        "create value" \
        "syntax-error"
    ((++count))

    diagnostic eof assign \
        "create value =" \
        "syntax-error"
    ((++count))

    diagnostic eof unary_minus \
        "-" \
        "syntax-error"
    ((++count))

    diagnostic eof unary_not \
        "!" \
        "syntax-error"
    ((++count))

    diagnostic eof binary_plus \
        "1 +" \
        "syntax-error"
    ((++count))

    diagnostic eof binary_star \
        "1 *" \
        "syntax-error"
    ((++count))

    diagnostic eof comparison \
        "1 <" \
        "syntax-error"
    ((++count))

    diagnostic eof equality \
        "1 ==" \
        "syntax-error"
    ((++count))

    diagnostic eof logical \
        "true and" \
        "syntax-error"
    ((++count))

    diagnostic eof grouping \
        "(" \
        "syntax-error"
    ((++count))

    printf "  ✓ Generated %d EOF diagnostics.\n" "$count"

}

###############################################################################
# Unexpected token diagnostics
###############################################################################

generate_unexpected_token_diagnostics() {

    header "Unexpected token diagnostics"

    local count=0

    diagnostic unexpected at_sign \
        "@" \
        "syntax-error"
    ((++count))

    diagnostic unexpected dollar \
        "$" \
        "syntax-error"
    ((++count))

    diagnostic unexpected backslash \
        "\\" \
        "syntax-error"
    ((++count))

    diagnostic unexpected comma \
        "," \
        "syntax-error"
    ((++count))

    diagnostic unexpected colon \
        ":" \
        "syntax-error"
    ((++count))

    diagnostic unexpected semicolon \
        ";" \
        "syntax-error"
    ((++count))

    diagnostic unexpected right_bracket \
        "]" \
        "syntax-error"
    ((++count))

    diagnostic unexpected right_brace \
        "}" \
        "syntax-error"
    ((++count))

    printf "  ✓ Generated %d unexpected-token diagnostics.\n" "$count"

}

###############################################################################
# Diagnostic test suite
###############################################################################

generate_diagnostic_tests() {

    header "Generating parser diagnostic tests"

    generate_declaration_diagnostics
    generate_assignment_diagnostics

    generate_unary_diagnostics
    generate_binary_diagnostics
    generate_comparison_diagnostics
    generate_equality_diagnostics
    generate_logical_diagnostics

    generate_grouping_diagnostics
    generate_layout_diagnostics

    generate_eof_diagnostics
    generate_unexpected_token_diagnostics

}

###############################################################################
# Associativity regressions
###############################################################################

generate_associativity_regressions() {

    header "Associativity regressions"

    local count=0

    regression associativity left_addition \
        "1 + 2 + 3 + 4" \
        "Ensures addition remains left associative."
    ((++count))

    regression associativity left_subtraction \
        "10 - 5 - 2" \
        "Ensures subtraction remains left associative."
    ((++count))

    regression associativity left_factor \
        "8 / 2 / 2" \
        "Ensures multiplicative operators remain left associative."
    ((++count))

    regression associativity logical_and \
        "true and false and true" \
        "Ensures logical AND remains left associative."
    ((++count))

    regression associativity logical_or \
        "true or false or true" \
        "Ensures logical OR remains left associative."
    ((++count))

    printf "  ✓ Generated %d associativity regressions.\n" "$count"

}

###############################################################################
# Precedence regressions
###############################################################################

generate_precedence_regressions() {

    header "Precedence regressions"

    local count=0

    regression precedence arithmetic_before_comparison \
        "1 + 2 * 3 < 10" \
        "Multiplication must bind before addition."

    ((++count))

    regression precedence comparison_before_equality \
        "1 < 2 == true" \
        "Comparison must bind before equality."

    ((++count))

    regression precedence equality_before_and \
        "1 == 1 and true" \
        "Equality must bind before logical AND."

    ((++count))

    regression precedence and_before_or \
        "true or false and true" \
        "Logical AND must bind before logical OR."

    ((++count))

    regression precedence unary_before_factor \
        "-1 * 2" \
        "Unary operators must bind before multiplication."

    ((++count))

    printf "  ✓ Generated %d precedence regressions.\n" "$count"

}

###############################################################################
# Grouping regressions
###############################################################################

generate_grouping_regressions() {

    header "Grouping regressions"

    local count=0

    regression grouping deeply_nested_parentheses \
        "((((((((42))))))))" \
        "Parser must correctly handle deeply nested parentheses."

    ((++count))

    regression grouping mixed_grouping \
        "((1 + 2) * (3 + 4)) == 21" \
        "Grouping must override precedence."

    ((++count))

    regression grouping unary_grouping \
        "!((1 + 2) == 3)" \
        "Unary operators applied to grouped expressions."

    ((++count))

    printf "  ✓ Generated %d grouping regressions.\n" "$count"

}

###############################################################################
# Declaration regressions
###############################################################################

generate_declaration_regressions() {

    header "Declaration regressions"

    local count=0

    regression declarations immutable_without_initializer \
        "create value" \
        "Reserved for future semantic validation of immutable declarations."

    ((++count))

    regression declarations mutable_initializer \
        "create mutable value = 42" \
        "Mutable declarations continue parsing correctly."

    ((++count))

    regression declarations multiple_declarations \
$'create a = 1
create mutable b = 2
create c = 3' \
        "Multiple declarations separated by NEWLINE."

    ((++count))

    printf "  ✓ Generated %d declaration regressions.\n" "$count"

}

###############################################################################
# Expression regressions
###############################################################################

generate_expression_regressions() {

    header "Expression regressions"

    local count=0

    regression expressions very_long_expression \
"1 + 2 * 3 - 4 / 5 % 2 + 8 * 9 - 10 + 11 * 12" \
"Parser handles long expressions."

    ((++count))

    regression expressions nested_logical \
"(1 < 2 and 3 < 4) or (5 == 5 and !(6 < 7))" \
"Nested logical expressions."

    ((++count))

    regression expressions nested_unary \
"!(-(-(-1)) == -1)" \
"Nested unary operators."

    ((++count))

    printf "  ✓ Generated %d expression regressions.\n" "$count"

}

###############################################################################
# Regression suite
###############################################################################

generate_regression_tests() {

    header "Generating parser regression tests"

    generate_associativity_regressions

    generate_precedence_regressions

    generate_grouping_regressions

    generate_declaration_regressions

    generate_expression_regressions

}

