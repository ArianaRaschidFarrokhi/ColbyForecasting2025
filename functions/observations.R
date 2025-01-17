
read_observations = function(scientificname = "Fratercula arctica",
                             minimum_year = 1970, 
                             ...){
  
  #' Read raw OBIS data and then filter it
  #' 
  #' @param scientificname chr, the name of the species to read
  #' @param minimum_year num, the earliest year of observation to accept or 
  #'   set to NULL to skip
  #' @param ... other arguments passed to `read_obis()`
  #' @return a filtered table of observations
  
  # Happy coding!
  fetch_obis(scientificname="Fratercula arctica")
  SPECIES="Fratercula arctica"
  summary(SPECIES)
  obs= read_obis(SPECIES)
  dim_start=dim(obs)
  dim_start
  summary(obs)
  plot(obs)
  obs |>
    filter(is.na(eventDate)) |>
    slice(1) |>
    browse_obis()
  ggplot(data = obs,
         mapping = aes(x = year)) + 
    geom_bar() + 
    geom_vline(xintercept = c(1970, 2022), linetype = "dashed") + 
    labs(title = "Counts per year")
  # read in the raw data
  x = read_obis(scientificname="Fratercula arctica")
  
  # if the user provided a non-NULL filter by year
  if (!is.null(minimum_year)){
    x = x |>
      filter(year >= minimum_year)
  }
  
  return(x)
}
