## How to run

To generate the 'run_analysis.txt' file from scratch, simply run `write_average_dataset(run_analysis())`. Note that this does take a few seconds to run.

## Files provided
'README.md'

'run_analysis.R': Contains the R scripts used in the analysis.

'CodeBook.md': Describes the data, variables, and transformations for the analysis.

'run_analysis.txt': Contains the final results of the analysis.

For this project it is assumed that the "UCI HAR Dataset" folder is in your R working directory. You can set your working directory with the `setwd()` function.

## Functions
#### run_analysis
This function takes no parameters. It uses the data in the "UCI HAR Dataset" folder and runs the analysis on it. 

**NOTE: This function assumes that the "UCI HAR Dataset" folder is in your R working directory. See above for how to set it if you haven't.**

This function returns a data frame which can be used in further analysis (the columns are explained in CodeBook.md). The data returned from this function is used in the `write_average_dataset` function.

#### calculate_means
This function takes a subset of the data frame returned by `run_analysis` as a parameter and returns a data frame containing the means of each of the columns.

#### write_average_dataset
This function takes the data returned by `run_analysis` as a parameter. It then uses `calculate_means` to get the means of each of the columns for each Test Subject. Those means are then combined into a single dataset and written to a `run_analysis.txt` file.