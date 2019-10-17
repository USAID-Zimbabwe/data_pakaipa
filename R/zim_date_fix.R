## convert iHTS "week ending X" to HFR calendar date

add_hfr_date <- function(file) {

hfr_date <- tibble::tribble(
                          ~ihts_date, ~period, ~hfr_date,
              "Week Ending March 15",   "Week 1",     43535,
              "Week Ending March 22",   "Week 2",     43542,
              "Week Ending March 29",   "Week 3",     43549,
               "Week Ending April 5",   "Week 4",     43556,
              "Week Ending April 12",   "Week 5",     43563,
              "Week Ending April 19",   "Week 6",     43570,
              "Week Ending April 26",   "Week 7",     43577,
                 "Week Ending May 3",   "Week 8",     43584,
                "Week Ending May 10",   "Week 9",     43591,
                "Week Ending May 17",  "Week 10",     43598,
                "Week Ending May 24",  "Week 11",     43605,
                "Week Ending May 31",  "Week 12",     43612,
                "Week Ending June 7",  "Week 13",     43619,
               "Week Ending June 14",  "Week 14",     43626,
               "Week Ending June 21",  "Week 15",     43633,
               "Week Ending June 28",  "Week 16",     43640,
                "Week Ending July 5",  "Week 17",     43647,
               "Week Ending July 12",  "Week 18",     43654,
               "Week Ending July 19",  "Week 19",     43661,
               "Week Ending July 26",  "Week 20",     43668,
                 "Week Ending Aug 2",  "Week 21",     43675,
                 "Week Ending Aug 9",  "Week 22",     43682,
                "Week Ending Aug 16",  "Week 23",     43689,
                "Week Ending Aug 23",  "Week 24",     43696,
                "Week Ending Aug 30",  "Week 25",     43703,
                "Week Ending Sept 6",  "Week 26",     43710,
               "Week Ending Sept 13",  "Week 27",     43717,
               "Week Ending Sept 20",  "Week 28",     43724,
               "Week Ending Sept 27",  "Week 29",     43731,
                "Week Ending Oct 4",  "Week 30",     43738,
               "Week Ending Oct 11",  "Week 31",     43745,
               "Week Ending Oct 18",  "Week 32",     43752,
               "Week Ending Oct 25",  "Week 33",     43759,
                "Week Ending Nov 1",  "Week 34",     43766,
                "Week Ending Nov 8",  "Week 35",     43773,
               "Week Ending Nov 15",  "Week 36",     43780,
               "Week Ending Nov 22",  "Week 37",     43787,
               "Week Ending Nov 29",  "Week 38",     43794,
                "Week Ending Dec 6",  "Week 39",     43801,
               "Week Ending Dec 13",  "Week 40",     43808,
               "Week Ending Dec 20",  "Week 41",     43815,
               "Week Ending Dec 27",  "Week 42",     43822,
                                  NA,  "Week 43",     43829,
                                  NA,  "Week 44",     43836,
                                  NA,  "Week 45",     43843,
                                  NA,  "Week 46",     43850,
                                  NA,  "Week 47",     43857,
                                  NA,  "Week 48",     43864,
                                  NA,  "Week 49",     43871,
                                  NA,  "Week 50",     43878
              )


hfr_date <- hfr_date %>% 
  dplyr::mutate(date = lubridate::as_date(hfr_date, origin = "1899-12-30")) %>% 
  dplyr::select(-hfr_date, -ihts_date)

dplyr::left_join(file, hfr_date, by = "period")

}
