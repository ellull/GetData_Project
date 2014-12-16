Getting and Cleaning Data project
=================================

Project from the Coursera 'Getting and Cleaning Data' course 

The project includes:
* This [README](README.md) file that describes the project
* The [codebook](CodeBook.md) that documents the variables and the summaryzation process
* The [run_analysis.R](run_analysis.R) script that performs the analysis.

The analysis scripts will download the raw dataset, unzip it and process it as described in the [codebook](CodeBook.md) generating the file tidy.txt in the directory where the script is located with the resulting tidy data set.

The [run_analysis.R](run_analysis.R) script depends on the library "reshape2" that can be installed using `install.packages("reshape2")`

The generated file can be loaded into R using `x <- read.table("tidy.txt", header=TRUE)`


Thanks and happy coding
