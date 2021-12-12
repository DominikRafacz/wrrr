.onLoad <- function(libname, pkgname) {
  # Set package-specific options
  options(
    some_option_name = value
  )
}

# alternatively -- do not override previously set options
.onLoad <- function(libname, pkgname) {
  prev_options <- options()
  
  new_options <- list(
    some_option_name = value
  )
  
  unset_inds <- !(names(new_options) %in% names(prev_options))
  if (any(unset_inds)) {
    options(new_options[unset_inds])
  }
  
  invisible()
}

.onUnload <- function(libpath) {
  # Unset package-specific options
  options(
    some_option_name = NULL
  )
}