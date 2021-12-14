#' Decode a HTML image element to a plottable object
#'
#' @param image_data A HTML element which contains a PNG image
#' @return A plottable object
decode_base64_png_image <- function(image_data) {
  ## Based on
  ## https://stackoverflow.com/questions/58604195/how-to-convert-a-base64-string-to-a-png-file-with-r
  raw_data <- stringr::str_match(image_data, "data:image\\/[a-z]+;base64,(.*)")[1, 2]
  raw_image_data <- base64enc::base64decode(what = raw_data)
  filename <- tempfile()
  png::writePNG(png::readPNG(raw_image_data), filename)
  magick::image_read(filename)
}
