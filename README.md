# Getting-and-Cleaning-Data-Course-Project

This repo contains the different files produced as part of the course project for the "Getting and Cleaning Data" course. The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. The different files included in the repo are described below.

## README.md

This file, which presents an overview of the project and its files.

## run_analysis.R

An R file containing the script which produces the goal of the project, *i.e.* a tidy dataset. The script begins by downloading the data files from the url given in the assignment. Multiple transformations and analyses are then performed to ultimately obtain the tidy dataset required by the assignment.

The script is self-sufficient and only needs to be executed in order to produce the end result, *i.e.* the tidy dataset in the form of a text file **tidydata.txt**.

## CodeBook.md

The codebook describes the variables, the data, and any transformations or work that has been performed to clean up the original data.

## tidydata.txt

The end result of the project, obtained by executing the **run_analysis.r** script. This file can be read into R using the following code:

```R
read.table("tidydata.txt", header = TRUE)
```
