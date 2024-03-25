Eelgrass Surveys and Statistical Analysis
This repository contains CSV data sheets from eelgrass surveys, along with R scripts for statistical analysis, map of survey locations, and graphs depicting seagrass wasting disease severity, seagrass wasting disease infection intensity, and environmental data analysis.

Data Sheets
The data folder contains the following CSV data sheets:

CBSurveySWD2021Master.csv: Raw data from eelgrass surveys, including various parameters such as site, transect, and quadrat of collected samples, eelgrass blade area, seagrass wasting disease lesion area, and seagrass wasting disease severity.
CB2021_qPCR.csv: Raw data from eelgrass surveys of seagrass wasting disease infection intensity in eelgrass tissue using quantitative PCR assay.
LabyTemp.csv: Environmental data collected during the surveys for seasurface temperature 
LabySalinity.csv: Environmental data collected during the surveys for salinity

Statistical Analysis
The analysis folder contains R scripts for statistical analysis:

data_cleaning.R: Script for cleaning and preprocessing the raw survey data.
statistical_analysis.R: Script for conducting statistical analysis on the cleaned data, including hypothesis testing, correlations, and regression analysis.
environmental_correlations.R: Script for exploring correlations between environmental factors and seagrass health metrics.
Maps
The maps folder contains maps of where the data was collected:

survey_locations_map.html: Interactive map displaying the locations of eelgrass surveys.
Graphs
The graphs folder contains graphs illustrating various aspects of the data:

seagrass_wasting_severity.png: Graph showing the severity of seagrass wasting disease across different survey sites.
seagrass_infection_intensity.png: Graph depicting the infection intensity of seagrass wasting disease.
environmental_analysis_plots.png: Collection of graphs illustrating the relationship between environmental factors and seagrass health.
How to Use
Clone the Repository:

Copy code
git clone https://github.com/your_username/your_repository.git
Navigate to the Repository:

bash
Copy code
cd your_repository
Explore the Data:

Open survey_data.csv and environmental_data.csv to examine the raw data.
Run the Scripts:

Execute data_cleaning.R to clean and preprocess the survey data.
Run statistical_analysis.R to perform statistical tests and analyses.
Execute environmental_correlations.R to explore relationships between environmental factors and seagrass health.
View Maps and Graphs:

Open maps/survey_locations_map.html to interact with the map of survey locations.
Check the graphs folder to view the generated graphs.
Requirements
RStudio
Required R packages:
plyr
Rmisc
ggplot2 (for plotting)

Contributors
Colleen Burge (@)

License
This project is licensed under
