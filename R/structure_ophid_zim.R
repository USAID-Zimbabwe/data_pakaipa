## ophid data

filepath <- "C:/Users/Josh/Documents/data/zim_hfr/ophid/OPHID HFR Data.xlsx"

df <- readxl::read_excel(filepath, col_types = "text", skip = 1)

df <- df %>% 
  tidyr::gather(period, val, `Week 1`:`Week 30`) %>%
  dplyr::mutate(val = as.numeric(val)) %>% 
  dplyr::filter(val != 0) %>% 
  add_hfr_date() %>%
  dplyr::filter(dplyr::between(date, as.Date("2019-09-02"), as.Date("2019-09-23"))) %>%  ## filter to just the dates needed, PITA, reconsider the dates as dates
  dplyr::rename_all(tolower) %>% 
  dplyr::rename(snu1 = province,
              psnu = district,
              orgunit = site)

df <- df %>% 
  dplyr::filter(indicator %in% c("Number of non Index HTS_TST", "Number of non Index HTS_TST POS", "Number of people newly initiated on ART")) %>%
  dplyr::mutate(indicator = dplyr::case_when(indicator == "Number of non Index HTS_TST" ~ "HTS_TST",
                                             indicator == "Number of non Index HTS_TST POS" ~ "HTS_TST_POS",
                                             indicator == "Number of people newly initiated on ART" ~ "TX_NEW")) %>%
  dplyr::rename(agecoarse = age,
                fundingagency = agency) %>% 
  dplyr::select(-period) %>% 
  glimpse()

df <- df %>% 
  add_uid_zim()

readr::write_csv(df, "C:/Users/Josh/Documents/data/zim_hfr/ophid/zim_hfr_ophid_pd13.csv")

## end here


readr::write_csv(df, "C:/Users/Josh/Documents/data/zim_hfr/psi/zim_hfr_psi_pd13.csv")




orgunitdisparity <- filter(df, is.na(orgunituid)) %>%
  distinct(orgunituid, orgunit) %>%
  arrange(orgunit) %>%
  print(n=Inf) %>% 
  readr::write_csv("C:/Users/Josh/Documents/data/zim_hfr/ophid/zim_org_hierachy_nomatch.csv")
