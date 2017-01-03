houseprice <- read.csv("./data/kc_house_data.csv")
gdp <- read.csv("./data/Energy_Census_and_Economic_Data US_2010_2014.csv")

# Variables that can be put on the x and y axes
axis_vars <- c(
  "Tomato Meter" = "Meter",
  "Numeric Rating" = "Rating",
  "Number of reviews" = "Reviews",
  "Dollars at box office" = "BoxOffice",
  "Year" = "Year",
  "Length (minutes)" = "Runtime"
)
