# data-raw/data_processing.R

# This file documents the data processing steps for the F1Package

# Step 1: Data collection
# The raw data for this package was collected using a Python script: f1Data.py
# This script scraped F1 race data from the python plugin 'fastf1'. Then the
# data was collected and manipulated into csv files for cleaning and analysis.
#
# To run the Python script (not necessary for package use):
# python data-raw/f1Data.py
# You will have to uncomment everything and change some of the values to obtain
# the appropriate race statistics.

# Step 2: Data cleaning and preparation
# This can be found in th F1LapData.R file.

# Step 3: Saving the processed data
# The data was then saved in the F1LapData.R file and used
# usethis::use_data(LapData)
