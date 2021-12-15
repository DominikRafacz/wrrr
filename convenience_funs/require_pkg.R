is_pkg_installed <- function(pkg) {
  check_pkg <- try(find.package(pkg), silent = TRUE)
  !inherits(check_pkg, "try-error")
}

require_pkg <- function(pkg) {
  if (interactive()) {
    # TODO: set option name
    if (!is_pkg_installed(pkg) &&
        !getOption(paste0(pkg, "_suppress_prompt"), default = FALSE)) {
      response <- menu(
        c("yes", "no", "no and don't ask me anymore"),
        # TODO: change message if available through GitHub/Bioc only
        title = paste0("To access some functionalities, you should install '", pkg, "' available on CRAN. Install?")
      )
      switch(response,
             tryCatch(install.packages(pkg),
                      finally = {
                        if (!is_pkg_installed(pkg))
                          warning("There was an error during an attempt to install '", pkg, "'.", call. = FALSE)
                      }),
             # TODO: change message if available through GitHub/Bioc only
             message("You cannot access full functionality of this package without having installed '", pkg, "' first.",
                     "You can do it manually by calling install.packages('", pkg, "').",
                     call. = FALSE),
             {
               # TODO: if omitting pkg argument, can be replaced by:
               # options(pkg_suppress_prompt = TRUE)
               options(setNames(list(TRUE), paste0(pkg, "_suppress_prompt")))
               cat("Ok, but you cannot access full functionality of this package without having installed '", pkg, "' first.",
                   sep = "")
             },
             # TODO: change message if available through GitHub/Bioc only
             message("You cannot access full functionality of this package without having installed '", pkg, "' first.",
                     "You can do it manually by calling install.packages('", pkg, "').",
                     call. = FALSE))
    }
  } else {
    # TODO: change message if available through GitHub/Bioc only
    message("To access some functions, install '", pkg, "' with install.packages('", pkg, "').")
  }
}