#Exploring Species Data sets
#tried exploring petrels, seemed to have issues looking at data
#> "LSP"=fetch_obis(scientificname="Hydrobates leucorhous")|>print()
#Error in `x[coords]`:
#  ! Can't subset columns that don't exist.
#✖ Columns `decimalLongitude` and `decimalLatitude` don't exist.
#Run `rlang::last_trace()` to see where the error occurred.
#> rlang::last_trace()
#<error/vctrs_error_subscript_oob>
#Error in `x[coords]`:
#! Can't subset columns that don't exist.
#✖ Columns `decimalLongitude` and `decimalLatitude` don't exist.
#---
#  Backtrace:
#  ▆
#1. ├─base::print(fetch_obis(scientificname = "Hydrobates leucorhous"))
#2. └─global fetch_obis(scientificname = "Hydrobates leucorhous")
#3.   ├─dplyr::bind_rows(...) at functions/obis.R:72:3
##4.   │ └─rlang::list2(...)
#5.   └─base::lapply(...)
#6.     └─FUN(X[[i]], ...)
#7.       └─global tidy_obis(...) at functions/obis.R:74:17
#8.         ├─sf::st_as_sf(...) at functions/obis.R:33:3
#9.         └─sf:::st_as_sf.data.frame(...)
#10.           ├─base::as.data.frame(lapply(x[coords], as.numeric))
#11.           ├─base::lapply(x[coords], as.numeric)
#12.           ├─x[coords]
#13.           └─tibble:::`[.tbl_df`(x, coords)
#Run rlang::last_trace(drop = FALSE) to see 8 hidden frames.
#> rlang::last_trace(drop = FALSE)
#<error/vctrs_error_subscript_oob>
#  Error in `x[coords]`:
#  ! Can't subset columns that don't exist.
#✖ Columns `decimalLongitude` and `decimalLatitude` don't exist.
#---
#Backtrace:
#     ▆
##  1. ├─base::print(fetch_obis(scientificname = "Hydrobates leucorhous"))
#  2. ├─global fetch_obis(scientificname = "Hydrobates leucorhous")
#  3. │ ├─dplyr::bind_rows(...) at functions/obis.R:72:3
#  4. │ │ └─rlang::list2(...)
#  5. │ └─base::lapply(...)
#  6. │   └─FUN(X[[i]], ...)
#  7. │     └─global tidy_obis(...) at functions/obis.R:74:17
#  8. │       ├─sf::st_as_sf(...) at functions/obis.R:33:3
#  9. │       └─sf:::st_as_sf.data.frame(...)
# 10. │         ├─base::as.data.frame(lapply(x[coords], as.numeric))
# 11. │         ├─base::lapply(x[coords], as.numeric)
# 12. │         ├─x[coords]
# 13. │         └─tibble:::`[.tbl_df`(x, coords)
# 14. │           └─tibble:::vectbl_as_col_location(...)
# 15. │             ├─tibble:::subclass_col_index_errors(...)
# 16. │             │ └─base::withCallingHandlers(...)
# 17. │             └─vctrs::vec_as_location(j, n, names, missing = "error", call = call)
# 18. └─vctrs (local) `<fn>`()
# 19.   └─vctrs:::stop_subscript_oob(...)
# 20.     └─vctrs:::stop_subscript(...)
# 21.       └─rlang::abort(...)

# decided to look at greater shearwaters instead for ease of data access and because their
#predation events depend on the SST of the ocean. (my thinking was whether or not Maine would
#become a suitable habitat for them)

#shearwaters is the shorthening I gave their name
shearwaters="Puffinus_gravis"

#to bring up observations
shearwaters

#summary of obs
summary(shearwaters)

#data ranging from 1904 to 2023
#at least 8341 dates are missing
#3238 observations are missing
#minimum amount seen is 1, max is 30,240!! individuals, median is 2, mean is 10.71??
count(shearwaters, basisOfRecord)
#38434 human observations 71 machine observations 1 nomenclature checklist preserved specimen 3
count(shearwaters, month)
#most months other than Jan-Apr are the times to see these birds

#plotting for analysis
#all plots saved as images under ColbyForecasting2025
#Monthly observations
ggplot(data = shearwaters,                                # create the object
       mapping = aes(x = month)) +                 # specify month along x-axis
  geom_bar() +                                     # request a barplot
  labs(title = "Monthly Greater Shearwater observations")   # add a title
#Yearly Observations
ggplot(data = shearwaters,                                # create the object
      mapping = aes(x = year)) +                  # specify year along x-axis
  geom_bar() +                                     # request a barplot
  labs(title = "Yearly Greater Shearwater observations")    # add a title

#note: recieved this warning message for second plot : Warning message:
#Removed 8341 rows containing non-finite outside the scale range (`stat_count()`).

#Spatial Plotting
#all data
coast = read_coastline()
ggplot(data = shearwaters) +       # create a plot object
  geom_sf(alpha = 0.1,      # add the points with some tweaking of appearance
          size = 0.7) +  
  geom_sf(data = coast,     # add the coastline
          col = "orange")
#monthly
coast = read_coastline()
ggplot(data = shearwaters) +                  # create the plot
  geom_sf(alpha = 0.1, size = 0.7) +   # add the points
  geom_sf(data = coast,                # add the coast
          col = "orange") +
  facet_wrap(~month)                   # make a montage by month
#note: weird stuff happening. NA made into its own map. seems to have a lot of data points

#Filtering missing data
shearwaters = shearwaters |>
  filter(!is.na(eventDate))
summary(shearwaters)
obs |>
  filter(is.na(individualCount)) |>
  slice(1) |>
#note: seemed to only sort out 2 NA's. reran montly and it got rid of the NA's in the plots. Still weird that there are absolutely no obs Jan-Apr.

#puffin data exploration
fetch_obis(scientificname="Fratercula arctica")
SPECIES="Fratercula arctica"
summary
obs= read_obis(SPECIES)
dim_start=dim(obs)
dim_start