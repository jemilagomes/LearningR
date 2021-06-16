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


## Filtering
# filter for all females
nhanes_small %>%
    filter(sex == "female")

# Participants who are not female
nhanes_small %>%
    filter(sex != "female")

# Participants who have BMI equal to 25
nhanes_small %>%
    filter(bmi == 25)

# Participants who have BMI greater than or equal to 25
nhanes_small %>%
    filter(bmi >= 25)

# BMI is greater than 25 AND sex is female
nhanes_small %>%
    filter(bmi > 25 & sex == "female")

# BMI is grater than 25 or sex is female. fn+alt+ ´for |
nhanes_small %>%
    filter(bmi > 25 | sex == "female")

##Arranging data
# Arranging by age in ascending order
nhanes_small %>%
    arrange(age)

#Arrange by sex in ascending order
nhanes_small %>%
    arrange(sex)

#Arranging by age in descending order
nhanes_small %>%
    arrange(desc(age))

#Arranging by sex then age in ascending order
nhanes_small %>%
    arrange(sex, age)

##Arranging by sex then age in descending order
nhanes_small %>%
    arrange(desc(sex), age)

##Transform or add columns.
#Height in meter instead of cm
nhanes_small %>%
    mutate(height = height/100)

#Add a new column with logged height values
nhanes_small %>%
    mutate(logged_height = log(height))

# Transform height values to metres and add log column in one step.
nhanes_small %>%
    mutate(height = height / 100,
           logged_height = log(height))

#New column based on how active participants are
nhanes_small %>%
    mutate(highly_active = if_else(phys_active_days >= 5, "yes", "No"))


nhanes_update <- nhanes_small %>%
    mutate(height = height/100,
           logged_height = log(height),
           hightly_active = if_else(phys_active_days >= 5, "yes", "No"))

##Summary statistics by group. na.rm means remove NA.
nhanes_small %>%
    summarise(max_bmi = max(bmi))

nhanes_small %>%
    summarise(max_bmi = max(bmi, na.rm = TRUE))

#Find out how many missing values (NAs) are there?
nhanes_small %>%
    summarise(sum_na = sum(is.na(bmi)))

#Calculatiing 2 summary statistics
nhanes_small %>%
    summarise(max_bmi = max(bmi, na.rm = TRUE),
              min_bmi = min(bmi, na.rm = TRUE))

##Calculating summary statistics by group
nhanes_small %>%
    group_by(diabetes) %>%
    summarise (mean_age = mean(age, na.rm = TRUE),
               mean_bmi = mean(bmi, na.rm = TRUE))

#Filtering the NAs aways by using filter.
nhanes_small %>%
    filter(!is.na(diabetes)) %>%
    group_by(diabetes) %>%
    summarise (mean_age = mean(age, na.rm = TRUE),
               mean_bmi = mean(bmi, na.rm = TRUE)) %>%
    ungroup()

## Saving datasets as files

#Saving datasets as an .rda file in the data folder
usethis::use_data(nhanes_small, overwrite = TRUE)

