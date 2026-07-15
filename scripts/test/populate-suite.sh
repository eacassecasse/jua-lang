#!/usr/bin/env bash

set -euo pipefail

ROOT="tests/lexer"

write() {
    local file="$1"
    shift

    cat > "$file" <<EOF
$*
EOF
}

############################################################
# LITERALS
############################################################

write "$ROOT/literals/zero.jua" \
'0'

write "$ROOT/literals/zero.tokens" \
'INTEGER_LITERAL:0
EOF:'

write "$ROOT/literals/positive.jua" \
'42'

write "$ROOT/literals/positive.tokens" \
'INTEGER_LITERAL:42
EOF:'

write "$ROOT/literals/large_integer.jua" \
'999999999'

write "$ROOT/literals/large_integer.tokens" \
'INTEGER_LITERAL:999999999
EOF:'

write "$ROOT/literals/leading_zero.jua" \
'00042'

write "$ROOT/literals/leading_zero.tokens" \
'INTEGER_LITERAL:00042
EOF:'

write "$ROOT/literals/integer_followed_by_identifier.jua" \
'123abc'

write "$ROOT/literals/integer_followed_by_identifier.tokens" \
'INTEGER_LITERAL:123
IDENTIFIER:abc
EOF:'

write "$ROOT/literals/empty_double.jua" \
'""'

write "$ROOT/literals/empty_double.tokens" \
'STRING_LITERAL:""
EOF:'

write "$ROOT/literals/empty_single.jua" \
"''"

write "$ROOT/literals/empty_single.tokens" \
"STRING_LITERAL:''
EOF:"

write "$ROOT/literals/simple_string.jua" \
'"hello"'

write "$ROOT/literals/simple_string.tokens" \
'STRING_LITERAL:"hello"
EOF:'

write "$ROOT/literals/string_with_spaces.jua" \
'"hello world"'

write "$ROOT/literals/string_with_spaces.tokens" \
'STRING_LITERAL:"hello world"
EOF:'

write "$ROOT/literals/escaped_quote.jua" \
'"hello \"world\""'

write "$ROOT/literals/escaped_quote.tokens" \
'STRING_LITERAL:"hello \"world\""
EOF:'

write "$ROOT/literals/escaped_backslash.jua" \
'"\\\\"'

write "$ROOT/literals/escaped_backslash.tokens" \
'STRING_LITERAL:"\\\\"
EOF:'

write "$ROOT/literals/escaped_newline.jua" \
'"\n"'

write "$ROOT/literals/escaped_newline.tokens" \
'STRING_LITERAL:"\n"
EOF:'

write "$ROOT/literals/unicode_string.jua" \
'"Olá Moçambique"'

write "$ROOT/literals/unicode_string.tokens" \
'STRING_LITERAL:"Olá Moçambique"
EOF:'

############################################################
# OPERATORS
############################################################

declare -A OPERATORS=(
    [plus]="+:PLUS"
    [minus]="-:MINUS"
    [star]="*:STAR"
    [slash]="/:SLASH"
    [percent]="%:PERCENT"
    [assign]="=:ASSIGN"
    [equal_equal]="==:EQUAL_EQUAL"
    [bang_equal]="!=:BANG_EQUAL"
    [less]="<:LESS"
    [less_equal]="<=:LESS_EQUAL"
    [greater]=">:GREATER"
    [greater_equal]=">=:GREATER_EQUAL"
)

for test in "${!OPERATORS[@]}"
do
    symbol="${OPERATORS[$test]%%:*}"
    token="${OPERATORS[$test]##*:}"

    write "$ROOT/operators/$test.jua" \
"$symbol"

    write "$ROOT/operators/$test.tokens" \
"$token:$symbol
EOF:"
done

write "$ROOT/operators/longest_match_equal.jua" \
'=='

write "$ROOT/operators/longest_match_equal.tokens" \
'EQUAL_EQUAL:==
EOF:'

write "$ROOT/operators/longest_match_less_equal.jua" \
'<='

write "$ROOT/operators/longest_match_less_equal.tokens" \
'LESS_EQUAL:<=
EOF:'

write "$ROOT/operators/longest_match_greater_equal.jua" \
'>='

write "$ROOT/operators/longest_match_greater_equal.tokens" \
'GREATER_EQUAL:>=
EOF:'

############################################################
# DELIMITERS
############################################################

declare -A DELIMS=(
[left_paren]="(:LEFT_PAREN"
[right_paren]="):RIGHT_PAREN"
[left_bracket]="[:LEFT_BRACKET"
[right_bracket]="]:RIGHT_BRACKET"
[comma]=",:COMMA"
[colon]="::COLON"
[dot]=".:DOT"
)

for test in "${!DELIMS[@]}"
do
    symbol="${DELIMS[$test]%%:*}"
    token="${DELIMS[$test]##*:}"

    write "$ROOT/delimiters/$test.jua" \
"$symbol"

    write "$ROOT/delimiters/$test.tokens" \
"$token:$symbol
EOF:"
done

write "$ROOT/delimiters/delimiter_sequence.jua" \
'(a,b)'

write "$ROOT/delimiters/delimiter_sequence.tokens" \
'LEFT_PAREN:(
IDENTIFIER:a
COMMA:,
IDENTIFIER:b
RIGHT_PAREN:)
EOF:'

############################################################
# COMMENTS
############################################################

write "$ROOT/comments/single_line_comment.jua" \
'# comment
create age = 20'

write "$ROOT/comments/single_line_comment.tokens" \
'CREATE:create
IDENTIFIER:age
ASSIGN:=
INTEGER_LITERAL:20
EOF:'

write "$ROOT/comments/empty_comment.jua" \
'#'

write "$ROOT/comments/empty_comment.tokens" \
'EOF:'

write "$ROOT/comments/multiline_comment.jua" \
'#*
comment
*#

create age = 20'

write "$ROOT/comments/multiline_comment.tokens" \
'CREATE:create
IDENTIFIER:age
ASSIGN:=
INTEGER_LITERAL:20
EOF:'

############################################################
# WHITESPACE
############################################################

write "$ROOT/whitespace/spaces.jua" \
'a     b'

write "$ROOT/whitespace/spaces.tokens" \
'IDENTIFIER:a
IDENTIFIER:b
EOF:'

write "$ROOT/whitespace/tabs.jua" \
$'a\tb'

write "$ROOT/whitespace/tabs.tokens" \
'IDENTIFIER:a
IDENTIFIER:b
EOF:'

write "$ROOT/whitespace/leading_spaces.jua" \
'      a'

write "$ROOT/whitespace/leading_spaces.tokens" \
'IDENTIFIER:a
EOF:'

write "$ROOT/whitespace/trailing_spaces.jua" \
'a      '

write "$ROOT/whitespace/trailing_spaces.tokens" \
'IDENTIFIER:a
EOF:'

############################################################
# NEWLINES
############################################################

write "$ROOT/newlines/single_newline.jua" \
'a
b'

write "$ROOT/newlines/single_newline.tokens" \
'IDENTIFIER:a
NEWLINE:
IDENTIFIER:b
EOF:'

write "$ROOT/newlines/multiple_newlines.jua" \
'a

b'

write "$ROOT/newlines/multiple_newlines.tokens" \
'IDENTIFIER:a
NEWLINE:
NEWLINE:
IDENTIFIER:b
EOF:'

############################################################
# EOF
############################################################

: > "$ROOT/eof/empty_file.jua"

write "$ROOT/eof/empty_file.tokens" \
'EOF:'

############################################################
# DIAGNOSTICS
############################################################

write "$ROOT/diagnostics/invalid_character.jua" \
'@'

write "$ROOT/diagnostics/invalid_character.error" \
'Unexpected character'

write "$ROOT/diagnostics/euro_character.jua" \
'€'

write "$ROOT/diagnostics/euro_character.error" \
'Unexpected character'

write "$ROOT/diagnostics/unterminated_double_string.jua" \
'"hello'

write "$ROOT/diagnostics/unterminated_double_string.error" \
'Unterminated string literal'

write "$ROOT/diagnostics/unterminated_single_string.jua" \
"'hello"

write "$ROOT/diagnostics/unterminated_single_string.error" \
'Unterminated string literal'

write "$ROOT/diagnostics/unterminated_comment.jua" \
'#*
hello'

write "$ROOT/diagnostics/unterminated_comment.error" \
'Unterminated comment'

echo "Lexer test suite populated successfully."
