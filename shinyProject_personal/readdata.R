stores<- read.csv('./data/taipei_store.csv',header = TRUE)
names(stores) <- c("id","lng","lat","tag")

gdp <- read.csv("./data/Energy_Census_and_Economic_Data US_2010_2014.csv")


# Set up handles to database tables on app start
db <- src_sqlite("./data/movies.db")
omdb <- tbl(db, "omdb")
tomatoes <- tbl(db, "tomatoes")

# Join tables, filtering out those with <10 reviews, and select specified columns
all_movies <- inner_join(omdb, tomatoes, by = "ID") %>%
  filter(Reviews >= 10) %>%
  select(ID, imdbID, Title, Year, Rating_m = Rating.x, Runtime, Genre, Released,
         Director, Writer, imdbRating, imdbVotes, Language, Country, Oscars,
         Rating = Rating.y, Meter, Reviews, Fresh, Rotten, userMeter, userRating, userReviews,
         BoxOffice, Production)

# Variables that can be put on the x and y axes
axis_vars <- c(
  "Tomato Meter" = "Meter",
  "Numeric Rating" = "Rating",
  "Number of reviews" = "Reviews",
  "Dollars at box office" = "BoxOffice",
  "Year" = "Year",
  "Length (minutes)" = "Runtime"
)


houseprice <- read.csv("./data/kc_house_data.csv")
vars <- colnames(houseprice)
