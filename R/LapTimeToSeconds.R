#lap time to seconds function
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
