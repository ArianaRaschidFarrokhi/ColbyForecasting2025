#' Reads a model input file given species, month, approach and path
#' 
#' @param scientificname chr, the species name
#' @param mon chr month abbreviation
#' @param approach chr, one of "greedy" or "conservative"
#' @param path chr the path to the data directory
read_model_input = function(scientificname = "Fratercula arctica",
                            mon = "Mar",
                            approach = "greedy",
                            path = data_path("model_input")){
  # your part goes in here
  species=scientificname
  
  if( approach == "greedy"){
  filename = sprintf("%s-%s-greedy_input.gpkg", 
                     gsub(" ", "_", species),
                     mon)}
  
  if( approach == "conservative"){
  filename = sprintf("%s-%s-conservative_input.gpkg", 
                     gsub(" ", "_", species),
                     mon)}
  x=file.path(path,filename)
  model_input= read_sf(x) 
    
  return(model_input)
  
}
