#Load up the packages

source(here::here("R/package-loading.R"))

#Briefly glimpse content of dataset

glimpse(NHANES)

#Select one column by its name
select(NHANES, Age)

#Select more columns
select(NHANES, Age, Weight, BMI)

#Exclude a column
select(NHANES, -HeadCirc)

# All columns starting with "BP"
select(NHANES, starts_with("BP"))

#All colums ending with "day"
select(NHANES, ends_with("Day"))

#All columns contaning age
select(NHANES, contains("Age"))

?select_helpers

#Save the selected columns as a new data frame
nhanes_small <- select(NHANES, Age, Gender, Height, Weight, BMI, Diabetes, DiabetesAge, PhysActiveDays, PhysActive, TotChol, BPSysAve, BPDiaAve, SmokeNow, Poverty)

#View the new data frame
nhanes_small

##Renaming
# Rename all columns to snake case
nhanes_small <- rename_with(nhanes_small, snakecase::to_snake_case)

nhanes_small

#Renaming specific columns
rename(nhanes_small, sex = gender)

#Putting it into the dataset so it is saved in the new dataset
nhanes_small <- rename(nhanes_small, sex = gender)

## The pipe operator

#without the pipe operator
colnames(nhanes_small)

# Pipe operator: Ctrl+Shift+M
nhanes_small %>% colnames()

#Using the pipe operator with more functions
nhanes_small %>%
    select(phys_active) %>%
    rename(physically_active = phys_active)

