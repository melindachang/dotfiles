; Types

(type_identifier) @type
(predefined_type) @type.builtin

((identifier) @type
 (#match? @type "^[A-Z]"))

(type_arguments
  "<" @punctuation.bracket
  ">" @punctuation.bracket)

; Variables

(required_parameter (identifier) @variable.parameter)
(optional_parameter (identifier) @variable.parameter)

; Keywords

[ "abstract"
  "declare"
  "enum"
  "implements"
  "interface"
  "namespace"
  "private"
  "protected"
  "public"
  "is"
  "type"
  "readonly"
  "override"
] @keyword

[ "import"
  "export"
] @keyword.module

(import_statement
  "from" @keyword.module)

[ "keyof"
  "satisfies"
  "in"
  "typeof"
  "delete"
] @keyword.operator

(as_expression
  "as" @keyword.operator)

(mapped_type_clause
  "as" @keyword.operator)

