import os
import sys
import pandas as pd

# Define the folder for calibration data, the data spreadsheet, and calibration spreadsheet
cal_folder = 'calibration'
excel_file = 'Lab3Data.xlsx'
cal_file = 'Lab3Cal.xlsx'

# Initialize an Excel writer
excel_writer = pd.ExcelWriter(cal_file, engine='xlsxwriter')

# Create a dictionary to store data for each pressure
pressure_data = {}

# Create a dictionary to store data for each velocity
velocity_data = {}

# Loop through each .txt file in the folder
for filename in os.listdir(cal_folder):
    if filename.endswith('.txt'):
        parts = filename.split(' ')  # Split the filename into parts
        if len(parts) == 3:  # Check if the filename has three parts (pitot measurement)
            pressure = parts[1]  # Extract the pressure from the filename
            pressure = pressure.replace(',', '.')
            trial_name = f'{pressure} q'
            txt_file_path = os.path.join(cal_folder, filename)  # Full path to the .txt file
            
            # Read the .txt file into a DataFrame
            data = pd.read_csv(txt_file_path, names=['q'], header=None)
            
            # Store the data in the pressure_data dictionary
            if pressure in pressure_data:
                pressure_data[pressure].append(data)
            else:
                pressure_data[pressure] = [data]
        elif len(parts) == 4:  # Check if the filename has four parts (velocity measurement)
            pressure = parts[2]  # Extract the pressure from the filename
            pressure = pressure.replace(',', '.')
            trial_name = f'{pressure} vel'
            txt_file_path = os.path.join(cal_folder, filename)  # Full path to the .txt file
            
            # Read the .txt file into a DataFrame
            data = pd.read_csv(txt_file_path, names=['voltage'], header=None, delimiter='\t', usecols=[1])
            
            # Store the data in the velocity_data dictionary
            if pressure in velocity_data:
                velocity_data[pressure].append(data)
            else:
                velocity_data[pressure] = [data]

# Write data to calibration Excel sheets
for pressure in pressure_data:   
    pressure_data[pressure][0].to_excel(excel_writer, sheet_name=f'{pressure}', index=False)

for pressure in velocity_data:   
    velocity_data[pressure][0].to_excel(excel_writer, sheet_name=f'{pressure} vel', index=False)

# Save the calibration Excel file
excel_writer.close()

print(f'Data has been saved to {cal_file}')

# Define the folder for experimental data
expr_folder = 'experiment'

# Initialize an Excel writer
excel_writer = pd.ExcelWriter(excel_file, engine='xlsxwriter')

# Create a dictionary to store data for each position
position_data = {}

# Loop through each .txt file in the folder
for filename in os.listdir(expr_folder):
    if filename.endswith('.txt'):
        parts = filename.split('_')  # Split the filename into parts
        if len(parts) == 3:  # Check if the filename has three parts
            position = parts[2]  # Extract the position from the filename
            position = position.split('.')[0]
            trial_name = f'{position}'
            txt_file_path = os.path.join(expr_folder, filename)  # Full path to the .txt file
            
            # Read the .txt file into a DataFrame
            data = pd.read_csv(txt_file_path, names=['voltage'], header=None, delimiter='\t', usecols=[1])
            
            # Store the data in the position_data dictionary
            if position in position_data:
                position_data[position].append(data)
            else:
                position_data[position] = [data]

# Write data to Excel sheets
for position in position_data:   
    position_data[position][0].to_excel(excel_writer, sheet_name=f'{position}', index=False)

# Save the Excel file
excel_writer.close()

print(f'Data has been saved to {excel_file}')