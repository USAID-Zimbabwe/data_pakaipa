

psi <- "C:/Users/Josh/Documents/data/zim_hfr/psi/zim_hfr_psi_pd13.csv"
ophid <- "C:/Users/Josh/Documents/data/zim_hfr/ophid/zim_hfr_ophid_pd13.csv"

df_psi <- readr::read_csv(psi)
df_ophid <- readr::read_csv(ophid)

df <- dplyr::bind_rows(df_psi, df_ophid) %>% 
  readr::write_csv("C:/Users/Josh/Documents/data/zim_hfr/HFR_ZWE_20191017.csv")
