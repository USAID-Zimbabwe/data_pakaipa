## structure fhi data

filepath <- "C:/Users/Josh/Documents/data/zim_hfr/fhi/FHI360_ HFR_Weekly_4 October 2019 (1).xlsx"
this_period <- c("2019-09-02", "2019-09-09", "2019-09-16", "2019-09-23")

df <- readxl::read_excel(filepath, col_types = "text")

df <- df %>%
  tidyr::gather(period, val, `Week 1`:`Week 35`) %>%
  dplyr::mutate(val = as.numeric(val)) %>% 
  dplyr::filter(val !=0) %>% 
  add_hfr_date() %>%
  dplyr::filter(dplyr::between(date, as.Date("2019-09-02"), as.Date("2019-09-23"))) ## filter to just the dates needed, PITA, reconsider the dates as dates

df <- df %>% 
  dplyr::filter(Indicator %in% c("Number of non Index HTS_TST POS", "Number of non Index HTS_TST"))

readr::write_csv(df, "C:/Users/Josh/Documents/data/zim_hfr/fhi/pd13_data.csv")
  
