# load necesssary libraries
library(tidyverse)

# import lap data
Singapore_laps <- read_csv("C:/Users/caleb/Desktop/F1Package/data-raw/Singapore_laps.csv", show_col_types = FALSE)

# create new variable for clean data
Singapore_laps_clean <- Singapore_laps

# create new variable for lap time in seconds
Singapore_laps_clean$LapTimeInSeconds <- lap_time_to_seconds(Singapore_laps_clean$LapTime)

Singapore_laps_clean$Sector1TimeInSeconds <- lap_time_to_seconds(Singapore_laps_clean$Sector1Time)

Singapore_laps_clean$Sector2TimeInSeconds <- lap_time_to_seconds(Singapore_laps_clean$Sector2Time)

Singapore_laps_clean$Sector3TimeInSeconds <- lap_time_to_seconds(Singapore_laps_clean$Sector3Time)


# Singapore_laps_clean$TotalSeconds <- lap_time_to_seconds(Singapore_laps_clean$LapTime)

# Remove rows with missing LapTimeInSeconds
Singapore_laps_clean <- Singapore_laps_clean %>%
  filter(!is.na(LapTimeInSeconds)) %>%
  filter(!is.na(Sector1TimeInSeconds)) %>%
  filter(!is.na(Sector2TimeInSeconds)) %>%
  filter(!is.na(Sector3TimeInSeconds))

# Remove columns not needed
Singapore_laps_clean <- subset(Singapore_laps_clean, select = -c(Time,DriverNumber,PitOutTime,PitInTime,Sector1Time,Sector2Time,Sector3Time,Sector1SessionTime, Sector2SessionTime,Sector3SessionTime,SpeedI1,SpeedI2,SpeedST,TyreLife,FreshTyre,LapStartTime,LapStartDate,TrackStatus,Deleted,DeletedReason,FastF1Generated,IsAccurate,LapTime,SpeedFL))

# Calculate the interquartile range (IQR) for LapTimeInSeconds
lap_time_iqr <- quantile(Singapore_laps_clean$LapTimeInSeconds, c(0, 0.75), na.rm = TRUE)
iqr <- lap_time_iqr[2] - lap_time_iqr[1]

# Define the lower and upper bounds for outliers
lower_bound <- lap_time_iqr[1] - 0.5 * iqr  # Adjust the multiplier to retain faster lap times
upper_bound <- lap_time_iqr[2] + 0.5 * iqr

# Filter out lap times that are outliers
Singapore_laps_clean <- Singapore_laps_clean %>%
  filter(LapTimeInSeconds >= lower_bound & LapTimeInSeconds <= upper_bound)

# Filter data to include only the top 10 drivers based on their position in the last lap
last_lap_positions <- Singapore_laps_clean %>%
  filter(LapNumber == max(LapNumber)) %>%
  arrange(Position) %>%
  slice(1:10) %>%
  pull(Driver)

LapData <- Singapore_laps_clean %>%
  filter(Driver %in% last_lap_positions)

# Save the data frame tp the data/ directory as rda
usethis::use_data(LapData)
