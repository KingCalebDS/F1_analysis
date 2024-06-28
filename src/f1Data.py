# Import necessary plugins
import pandas as pd
import seaborn as sns
import fastf1
import fastf1.plotting
import csv
from fastf1.ergast import Ergast
from matplotlib import pyplot as plt

# Set the path to a folder where cached data will be stored
#fastf1.Cache.enable_cache('')  

###############
# Season Data #
###############

# # Load the Ergast object containing f1 season results
# ergast = Ergast()
# races = ergast.get_race_schedule(2023) 
# results = []

# # Loop through each race
# for rnd, race in races['raceName'].items():
#     temp = ergast.get_race_results(season=2023, round=rnd + 1)
#     temp = temp.content[0]
#     temp['round'] = rnd + 1
#     temp['race'] = race.removesuffix(' Grand Prix')
#     results.append(temp)

# # Add results of race to df
# results_df = pd.concat(results)

# # Select columns to include in the CSV output
# selected_columns = ['round', 'race', 'driverCode', 'laps', 'grid', 'totalRaceTime', 'status']

# # Fill missing values with 'N/A'
# results_df[selected_columns] = results_df[selected_columns].fillna('0')

# # Save results to a CSV file with only selected columns
# results_df[selected_columns].to_csv('/Users/caleblking/Desktop/F1Project/Season23Results.csv', index=False)

############
# Lap Data #
############
# # Get the session data
# session_singapore = fastf1.get_session(2023, 15, 'R')
# session_singapore.load()

# # Get all lap data
# all_laps_data = session_singapore.laps

# # Define the CSV file name
# csv_file = '/Users/caleblking/Desktop/F1Project/Singapore_laps.csv'

# # Write lap data to CSV file
# with open(csv_file, mode='w', newline='') as file:
#     writer = csv.writer(file)
    
#     # Write header row
#     writer.writerow(all_laps_data.columns)
    
#     # Write lap data rows
#     for index, lap_data in all_laps_data.iterrows():
#         # Convert non-numeric data to string
#         lap_data = lap_data.apply(lambda x: str(x) if not isinstance(x, (int, float)) else x)
#         writer.writerow(lap_data)

##################
# Car Data #
##################

# # Set the path to a folder where cached data will be stored
# fastf1.Cache.enable_cache('/Users/caleblking/Desktop/F1Project/f1cache')  

# # Specify the session details
# year = 2023
# grand_prix = 15
# session_name = 'R'

# # Get the session data
# session = fastf1.get_session(year, grand_prix, session_name)
# session.load()

# # Get the car data for all drivers
# car_data = session.car_data

# # Define the CSV file name
# csv_file = '/Users/caleblking/Desktop/F1Project/Singapore_car_data.csv'

# # Write car data to CSV file
# with open(csv_file, mode='w', newline='') as file:
#     writer = csv.writer(file)
    
#     # Get the column names from the car data DataFrame
#     column_names = list(next(iter(car_data.values())).columns)
    
#     # Write header row
#     writer.writerow(['Driver'] + column_names)
    
#     # Write car data rows
#     for driver in car_data.keys():
#         driver_car_data = car_data[driver]
#         for index, data in driver_car_data.iterrows():
#             # Extract relevant data
#             driver_name = driver
#             row_data = [data[column] for column in column_names]
            
#             # Write data to CSV row
#             writer.writerow([driver_name] + row_data)


# Extra testing


# # Define telemetry channels for car data
# car_telemetry_channels = ['Speed', 'RPM', 'nGear', 'Throttle', 'Brake', 'DRS']

# # Define telemetry channels for position data
# position_telemetry_channels = ['X', 'Y', 'Z', 'Status']

# # Initialize lists to store telemetry data
# car_telemetry_data = []
# position_telemetry_data = []

# # Iterate over each lap
# for lap in session_singapore.laps:
#     # Get car data telemetry for the current lap
#     car_data = lap.car_data[car_telemetry_channels]
#     car_telemetry_data.append(car_data)
    
#     # Get position data telemetry for the current lap
#     pos_data = lap.pos_data[position_telemetry_channels]
#     position_telemetry_data.append(pos_data)

# # Create DataFrame for car telemetry data
# car_telemetry_df = pd.DataFrame(car_telemetry_data, columns=car_telemetry_channels)

# # Create DataFrame for position telemetry data
# position_telemetry_df = pd.DataFrame(position_telemetry_data, columns=position_telemetry_channels)

# # Merge car data and position data telemetry
# all_telemetry_data = pd.concat([car_telemetry_df, position_telemetry_df], axis=1)

# # Save all telemetry data to a CSV file
# all_telemetry_data.to_csv('/Users/caleblking/Desktop/F1Project/Singapore_all_telemetry.csv', index=False)





# histogram of verstapen lap times in Singapore Grand Prix


# scatter plot of lap times from Singapore Grand Prix
# top_finishers = session_singapore.drivers[:10]
# print(top_finishers)
# driver_laps = session_singapore.laps.pick_drivers(top_finishers).pick_quicklaps().reset_index()
# ver_laps = session_singapore.laps.pick_driver("VER").pick_quicklaps().reset_index()

# fig, ax = plt.subplots(figsize=(8, 8))

# sns.scatterplot(data=driver_laps,
#                 x="LapNumber",
#                 y="LapTime",
#                 ax=ax,
#                 hue="Driver",
#                 legend='auto')


# plt.suptitle("Lap times for Singapore Grand Prix")
# plt.show()


#sns.histplot(data=ver_laps, 
#             x="LapNumber",
#             y="LapTime" 
#             bins=20, 
#             kde=True, 
#             ax=ax)







# # Load the session data
# session = fastf1.get_session(2023, 'Singapore', 'R')
# session.load()

# # Load the lap data
# laps = session.laps

# # Create an empty DataFrame to store the telemetry data
# telemetry_df = pd.DataFrame()

# # Iterate over each driver
# for driver_name in session.drivers:
#     # Get the laps for the driver
#     driver_laps = laps.pick_driver(driver_name)
    
#     # Iterate over each lap of the driver
#     for lap_number, lap_data in driver_laps.iterlaps():
#         # Get the telemetry data for the lap
#         telemetry = lap_data.get_telemetry()
        
#         # Add the driver name to the telemetry data
#         telemetry['Driver'] = driver_name
        
#         # Merge the telemetry data with the main DataFrame
#         telemetry_df = pd.concat([telemetry_df, telemetry], ignore_index=True)


# # Save the telemetry data to a CSV file
# telemetry_df.to_csv('/Users/caleblking/Desktop/F1Project/singapore_telemetry_data.csv', index=False)