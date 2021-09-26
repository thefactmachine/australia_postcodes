#' Save a reactable table as an image or .html file
#'
#' The `save_reactable()` function converts either a reactable table, .html file, or .Rmd file to an image or .html file
#'     and saves it in the user's working directory.
#'     Table can be saved as either a .png file or .html file. Other file types are not currently supported.
#'     If the reactable table is located within an .Rmd file and has additional CSS styles provided,
#'     specify the name of the .Rmd file as the input.
#'     Alternatively, if the reactable table exists in an .html file, specify the name of the .html file as the input.
#'     `save_reactable()` depends on the `{webshot2}` package which can be downloaded from https://github.com/rstudio/webshot2.
#'     Additional parameters available within webshot2::webshot such as vwidth, vheight, and cliprect can be passed through `save_reactable()`.
#'     The zoom value within webshot2::webshot has already been set to 2 which uses a higher pixel rate.
#'
#' @param input A reactable table, .html file, or .Rmd file
#'
#' @param output A .png or .html file name for the saved image
#'
#' @param ... Optional additional parameters passed from webshot2::webshot
#'
#' @importFrom htmlwidgets saveWidget
#' @importFrom tools file_ext
#' @importFrom tools file_path_sans_ext
#' @import reactable
#'
#' @return a function that converts a reactable table, .html file, or .Rmd file to an .png file or .html file
#'     and saves it in the user's working directory.
#'
#' @examples
#' \dontrun{
#' ## Save reactable table as a png file:
#' iris_table <- reactable(data)
#' save_reactable(iris_table, "iris_table.png")
#'
#' ## Also works with a pipe
#' iris_table %>%
#' save_reactable("iris_table.png")
#'
#' ## Or save as an html file:
#' save_reactable(iris_table, "iris_table.html")
#'
#' ## If the reactable table was built in R Markdown with CSS styles applied,
#' ## specify .Rmd file as input and save_reactable will run the file
#' ## and save the output as an image
#' save_reactable("iris_table.Rmd", "iris_table.png")
#'
#' ## Alternatively, can do the same with an .html file
#' save_reactable("iris_table.html", "iris_table.png")
#' }
#' @export

save_reactable <- function(input,
                           output,
                           ...) {
  
  if (typeof(input) != "character" && attr(input, "class")[1] != "reactable" || typeof(input) != "character" && is.null(attr(input, "class")[1])) {
    
    stop("input must be either a reactable table, .html file, or .Rmd file")
  }
  
  '%notin%' <- Negate('%in%')
  
  if (typeof(input) == "character" && tools::file_ext(input) %notin% c("html", "Rmd") == TRUE) {
    
    stop("input must be either a reactable table, .html file, or .Rmd file")
  }
  
  if (tools::file_ext(output) %notin% c("png", "html") == TRUE) {
    
    stop("output must be either a .png or .html file")
  }
  
  if (tools::file_ext(output) == "html") {
    
    htmlwidgets::saveWidget(widget = input, file = output, selfcontained = TRUE)
    
    message("html file saved to ", getwd(), "/", output)
    
  } else if (tools::file_ext(output) == "png" && tools::file_ext(input) != "Rmd" && tools::file_ext(input) != "html") {
    
    temp_html <- tempfile(
      pattern = tools::file_path_sans_ext(basename(output)),
      fileext = ".html")
    
    htmlwidgets::saveWidget(widget = input, file = temp_html, selfcontained = TRUE)
    
    if (!requireNamespace("webshot2", quietly = TRUE)) {
      
      stop("The `webshot2` package is required to use `save_reactable()`.",
           call. = FALSE)
      
    } else {
      
      webshot2::webshot(url = temp_html,
                        file = output,
                        zoom = 2,
                        delay = 1,
                        ...)
      
      invisible(file.remove(temp_html))
      
      message("image saved to ", getwd(), "/", output)
      
    }
    
  } else if (tools::file_ext(input) == "Rmd") {
    
    message("Knitting R Markdown document...")
    
    if (!requireNamespace("webshot2", quietly = TRUE)) {
      
      stop("The `webshot2` package is required to use `save_reactable()`.",
           call. = FALSE)
      
    } else {
      
      webshot2::rmdshot(doc = input,
                        file = output,
                        zoom = 2,
                        delay = 1,
                        ...)
      
      message("image saved to ", getwd(), "/", output)
      
    }
    
  } else if (tools::file_ext(input) == "html" && tools::file_ext(output) == "png") {
    
    if (!requireNamespace("webshot2", quietly = TRUE)) {
      
      stop("The `webshot2` package is required to use `save_reactable()`.",
           call. = FALSE)
      
    } else {
      
      webshot2::webshot(url = input,
                        file = output,
                        zoom = 2,
                        delay = 1,
                        ...)
      
      message("image saved to ", getwd(), "/", output)
      
    }
    
  } else stop("please make sure input is either a reactable table, .html file, or .Rmd file,
              and output is either a .png or .html file")
  
}