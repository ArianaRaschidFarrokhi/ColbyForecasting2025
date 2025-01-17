brickman_variables("all")
buoys=gom_buoys()
coast=read_coastline()
db=brickman_database()
buoys=buoys|>filter(id=="M01")
db = db |> filter(scenario == "PRESENT", interval == "mon")
covars=read_brickman(db)
x = extract_brickman(covars, buoys, form = "wide")
x= x |>mutate(month = factor(month, levels = month.abb))
ggplot(data = x,
       mapping = aes(x = month, y = SST)) +
  geom_point() + 
  labs(title = "RCP4.5 2055 SST at buoy M01", y= "SST (C)")

