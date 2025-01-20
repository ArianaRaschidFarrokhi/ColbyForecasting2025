
SPECIES="Fratercula arctica"
summary(SPECIES)
obs= read_obis(SPECIES)
dim_start=dim(obs)
dim_start
summary(obs)
plot(obs)
obs=obs |>
  filter(!is.na(eventDate))
summary(obs)
obs |>
  filter(is.na(individualCount)) |>
  slice(1) |> plot()
obs = obs |>
  filter(year >= 1969)
dim(obs)
ggplot(data = obs,
       mapping = aes(x = year)) + 
  geom_bar() + 
  geom_vline(xintercept = c(1969, 2022), linetype = "dashed") + 
  labs(title = "Counts per year") + xlim(1969,2022)
ggplot(data = obs,
       mapping = aes(x = month)) + 
  geom_bar() + 
  labs(title = "Counts per month")
obs = obs |>
  mutate(month = factor(month, levels = month.abb))

ggplot(data = obs,
       mapping = aes(x = month)) + 
  geom_bar() + 
  labs(title = "Counts per month")
db = brickman_database() |>
  filter(scenario == "STATIC", var == "mask")
mask = read_brickman(db, add_depth = FALSE)
mask
plot(mask, breaks = "equal", axes = TRUE, reset = FALSE)
plot(st_geometry(obs), pch = ".", add = TRUE)
hitOrMiss = extract_brickman(mask, obs)
hitOrMiss
count(hitOrMiss, value)
obs = obs |>
  filter(!is.na(hitOrMiss$value))
dim_end = dim(obs)

dropped_records = dim_start[1] - dim_end[1]
dropped_records

#Spatial Plotting
#all data
coast = read_coastline()
ggplot(data = obs) +       # create a plot object
  geom_sf(alpha = 0.1,      # add the points with some tweaking of appearance
          size = 0.7) +  
  geom_sf(data = coast,     # add the coastline
          col = "orange")
#monthly
coast = read_coastline()
ggplot(data = obs) +                  # create the plot
  geom_sf(alpha = 0.1, size = 0.7) +   # add the points
  geom_sf(data = coast,                # add the coast
          col = "orange") +
  facet_wrap(~month) 
