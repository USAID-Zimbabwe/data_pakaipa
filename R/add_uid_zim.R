## merge orgunit ids


add_uid_zim <- function(file) { 
 
  orgunits <- "C:/Users/Josh/Documents/data/zim_hfr/FY19_OrgUnits_Zimbabwe.csv"
  
  df <- readr::read_csv(orgunits) %>% 
    dplyr::select(-operatingunit, -snu1, -psnu, -community)
  
  dplyr::left_join(file, df, by = "orgunit")  
  
}