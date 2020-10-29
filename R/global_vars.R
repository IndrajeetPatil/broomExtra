# defining global variables and functions to appease R CMD Check

utils::globalVariables(
  names = c("."),
  package = "broomExtra",
  add = FALSE
)
