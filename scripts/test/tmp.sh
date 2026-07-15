#!/usr/bin/bash

files=(single_letter underscore snake_case camel_case leading_underscore trailing_digits keyword_prefix keyword_suffix long_identifier identifier_sequence)
path="./tests/lexer/identifiers"

for filename in "${files[@]}"; do
	# kw_up=$(echo "$kw" | tr '[:lower:]' '[:upper:]')

	# echo -n "$kw" > "${path}/${kw}.jua"

	# printf "%s:%s\nEOF:" "$kw_up" "$kw" > "${path}/${kw}.tokens"
	touch "${path}/${filename}".{jua,tokens}
	printf "IDENTIFIER:\nEOF:" > "${path}/${filename}.tokens"
done
