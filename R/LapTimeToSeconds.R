#' Convert lap time strings to seconds
#'
#' This function takes a vector of lap time strings and converts each element
#' to the total number of seconds. It handles special cases like "NaT" (Not a Time)
#' and lap times with a "0 days" prefix.
#'
#' The function supports lap time formats like "HH:MM:SS" or "0 days HH:MM:SS".
#' It returns a numeric vector of the same length as the input, where each element
#' represents the total seconds for the corresponding lap time.
#'
#' @param lap_time_vector A character vector of lap time strings
#' @return A numeric vector of lap times converted to total seconds
#' @examples
#' lap_times <- c("01:23:45", "00:59:59", "NaT", "0 days 02:30:00")
#' lap_time_to_seconds(lap_times)
#' @export
lap_time_to_seconds <- function(lap_time_vector) {
  # Initialize an empty vector to store the total lap times
  total_seconds_vector <- numeric(length(lap_time_vector))

  # Iterate over each lap time string
  for (i in seq_along(lap_time_vector)) {
    # Check if the lap time is "NaT"
    if (lap_time_vector[i] == "NaT") {
      # Assign NA if lap time is "NaT"
      total_seconds_vector[i] <- NA
    } else {
      # Remove the "0 days" prefix from the lap time string
      lap_time <- gsub("0 days ", "", lap_time_vector[i])

      # Split the lap time string by ":"
      time_components <- strsplit(lap_time, ":")[[1]]

      # Extract hours, minutes, and seconds
      hours <- as.numeric(time_components[1])
      minutes <- as.numeric(time_components[2])
      seconds <- as.numeric(time_components[3])

      # Calculate total seconds
      total_seconds <- (hours * 3600) + (minutes * 60) + seconds

      # Store the total seconds in the vector
      total_seconds_vector[i] <- total_seconds
    }
  }

  return(total_seconds_vector)
}
