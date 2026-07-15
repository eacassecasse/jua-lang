#!/usr/bin/env bash

set -euo pipefail

ROOT="tests/lexer"

create_test() {
    local dir="$1"
    local name="$2"
    local extension="$3"

    mkdir -p "${ROOT}/${dir}"

    touch "${ROOT}/${dir}/${name}.jua"

    if [[ "$extension" == "tokens" ]]; then
        touch "${ROOT}/${dir}/${name}.tokens"
    else
        touch "${ROOT}/${dir}/${name}.error"
    fi
}

echo "Creating lexer test suite..."

###########################################################
# Literals
###########################################################

for test in \
    zero \
    positive \
    large_integer \
    leading_zero \
    integer_followed_by_identifier \
    empty_double \
    empty_single \
    simple_string \
    string_with_spaces \
    escaped_quote \
    escaped_backslash \
    escaped_newline \
    unicode_string
do
    create_test literals "$test" tokens
done

###########################################################
# Operators
###########################################################

for test in \
    plus \
    minus \
    star \
    slash \
    percent \
    assign \
    equal_equal \
    bang_equal \
    less \
    less_equal \
    greater \
    greater_equal \
    longest_match_equal \
    longest_match_less_equal \
    longest_match_greater_equal
do
    create_test operators "$test" tokens
done

###########################################################
# Delimiters
###########################################################

for test in \
    left_paren \
    right_paren \
    left_bracket \
    right_bracket \
    comma \
    colon \
    dot \
    delimiter_sequence
do
    create_test delimiters "$test" tokens
done

###########################################################
# Comments
###########################################################

for test in \
    single_line_comment \
    empty_comment \
    multiline_comment \
    multiline_with_symbols \
    comment_between_tokens \
    nested_marker_text
do
    create_test comments "$test" tokens
done

###########################################################
# Whitespace
###########################################################

for test in \
    spaces \
    tabs \
    leading_spaces \
    trailing_spaces \
    mixed_whitespace
do
    create_test whitespace "$test" tokens
done

###########################################################
# Newlines
###########################################################

for test in \
    single_newline \
    multiple_newlines \
    leading_newline \
    trailing_newline
do
    create_test newlines "$test" tokens
done

###########################################################
# EOF
###########################################################

for test in \
    empty_file \
    spaces_only \
    comments_only \
    multiline_comment_only
do
    create_test eof "$test" tokens
done

###########################################################
# Diagnostics
###########################################################

for test in \
    invalid_character \
    euro_character \
    unterminated_double_string \
    unterminated_single_string \
    unterminated_comment
do
    create_test diagnostics "$test" error
done

echo
echo "Done."
echo
find tests/lexer -type f | sort
