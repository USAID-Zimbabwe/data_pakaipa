## structure PSI HFR data

filepath <- "C:/Users/Josh/Documents/data/zim_hfr/psi/PSI Zimbabwe_HFR_04October2019.xlsx"
indc <- c("HTS_TST", "HTS_TST_POS", "VMMC_CIRC", "PrEP_NEW", "TX_NEW")
facilities <- c("Bambanani - 100039 - New Start Centre", "Gweru - 100571 - New Start Centre/New Life Centre",
           "New Africa House - 101234 - New Start Centre", "Masvingo - 101244 - New Start Centre",
           "Mutare - 101246 - New Start Centre")



df <- readxl::read_excel(filepath, col_types = "text", sheet = "WeekEnding_04_10_19")

df <- df %>% 
  dplyr::select(Province, District, Site, UID, `Mechanism ID`, Sex, Agecoarse, Indicator,
                `Partner Name2`, `WK Ending 6 Sept`:`WK Ending 27 Sept`) %>% 
  tidyr::gather(date, val, `WK Ending 6 Sept`:`WK Ending 27 Sept`) %>% 
  dplyr::filter(val != 0)

df <- df %>% 
  dplyr::mutate(date = dplyr::case_when(date == "WK Ending 6 Sept" ~ "2019-09-02",
                                        date == "WK Ending 13 Sept" ~ "2019-09-09",
                                        date == "WK Ending 20 Sept" ~ "2019-09-16",
                                        date == "WK Ending 27 Sept" ~ "2019-09-23"),
                community = ifelse(!Site %in% facilities, District, NA),
                Site = ifelse(Site %in% facilities, Site, District)) ## change to (Site %in% facilities, Site, NA) if community is diff from orgunit
                
  df <- df %>%               
  dplyr::mutate(Indicator = ifelse(Indicator == "Number of people newly initiated on ART", "TX_NEW", Indicator)) %>%
  dplyr::filter(Indicator %in% indc) %>% 
  dplyr::rename_all(tolower) %>% 
  dplyr::rename(snu1 = province,
                psnu = district,
                orgunit = site,
                orgunituid = uid,
                mechanismid = `mechanism id`) %>% 
  dplyr::mutate(operatingunit = "Zimbabwe",
                fundingagency = "USAID",
                fy = 2019,
                date = lubridate::as_date(date),
                val = as.numeric(val)) %>% 
  dplyr::select(-`partner name2`)
  
  readr::write_csv(df, "C:/Users/Josh/Documents/data/zim_hfr/psi/zim_hfr_psi_pd13.csv")