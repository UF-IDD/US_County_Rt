
library(tidyverse); theme_set(theme_minimal())


# import raw intervention data
data_path = "data/intervention_googlesheet_raw_20200702.csv"

raw = read_csv(data_path)[ 1:51, ]  # exclude total, notes rows
fips = read_csv("data/FIPS.csv")

# parse date when data was pulled from the source
dataDate = as.Date(gsub('\\.csv$','', str_extract(data_path, "[0-9]{8}\\.csv")), format="%Y%m%d")


#' Scope down to only columns about policies that are directly
#' involved in limiting transmission.
#  : (1) enforce, (2) release column
int.full = list(
  "school_close" = c(
    "Date closed K-12 schools"
    , "")
  ,"daycare_close" = c(
    "Closed day cares"
    , "")
  ,"ban_nursing_home_visit" = c(
    "Date banned visitors to nursing homes"                                                                                    
    , "")
  ,"stay_home" = c(
    "Stay at home/ shelter in place"                                                                                           
    , "End/relax stay at home/shelter in place")
  ,"close_business" = c(
    "Closed non-essential businesses"
    , "Began to reopen businesses")
  ,"close_restaurant" = c(
    "Closed restaurants except take out"
    , "Reopen restaurants")
  ,"close_gym" = c(
    "Closed gyms"
    , "Reopened gyms")
  ,"close_movie" = c(
    "Closed movie theaters"
    , "Reopened movie theaters")
  ,"face_mask_public" = c(
    "Mandate face mask use by all individuals in public spaces"
    , "")
  ,"face_mask_business" = c(
    "Mandate face mask use by employees in public-facing businesses"
    , "")
  ,"state_of_emergency" = c(
    "State of emergency"
    , "")
  ,"suspend_medical" = c(
    "Suspended elective medical/dental procedures"
    , "Resumed elective medical procedures")
)
int.full.labels = c(
  "school_close" = "School closure"
  ,"daycare_close" = "Daycare closure"
  ,"ban_nursing_home_visit" = "Nursing home visit ban"
  ,"stay_home" = "Stay at home"
  ,"close_business" = "Close non-essential businesses"
  ,"close_restaurant" = "Close restaurants"
  ,"close_gym" = "Close gyms"
  ,"close_movie" = "Close movie theaters"
  ,"face_mask_public" = "Face mask mandated in public"
  ,"face_mask_business" = "Face mask mandated in businesses"
  ,"state_of_emergency" = "Declared state of emergency"
  ,"suspend_medical" = "Suspend non-essential medical services"
)



dat = lapply(names(int.full), function(int){
  x = int.full[[int]]
  
  dateStart = raw[[x[1]]] %>% 
    # fix 2-digit years
    gsub(pattern = "/20$", replacement = "/2020") %>%
    as.Date("%m/%d/%Y") %>% 
    as.character
  
  if(x[2]==""){
    dateEnd = ifelse(is.na(dateStart), NA, as.character(dataDate))
  } else {
    dateEnd = raw[[x[2]]] %>% 
      # fix 2-digit years
      gsub(pattern = "/20$", replacement = "/2020") %>%
      as.Date("%m/%d/%Y") %>% 
      as.character
    dateEnd = ifelse(is.na(dateEnd) & !is.na(dateStart), as.character(dataDate), dateEnd)
  }
  
  data.frame(
    state_name = raw$State
    , intervention = int
    , dateStart = dateStart
    , dateEnd = dateEnd
  )
}) %>%
  do.call(what = rbind) %>%
  mutate(
    dateStart = as.Date(dateStart)
    , dateEnd = as.Date(dateEnd)
  )



#' Filtering out interventions with start date later than data retrieval date.
dat = dat %>% filter(dateStart <= dateEnd, !is.na(dateStart))


#' # Cluster interventions based on co-occurrence
dat$dates = with(dat, 
                 mapply( function(tmin,tmax) {
                   if( is.na(tmin)|is.na(tmax) ){ return( character(0) ) }
                   seq(tmin, tmax, by = "day") %>% as.character
                 }
                 , tmin = dateStart
                 , tmax = dateEnd
                 ))

dat = dat %>%
  select(state_name, intervention, dates) %>%
  unnest(cols = dates) %>%
  mutate(on = 1) %>%
  spread(intervention, on, fill = 0) %>%
  mutate(dates = as.Date(dates))

dat.clust = dat %>%
  select(-state_name, -dates)
colnames(dat.clust) = int.full.labels[colnames(dat.clust)]

pdf("output/plot/fig_s2.pdf", height = 8, width = 9)
dat.clust[ , -which(colnames(dat.clust)=="Declared state of emergency")]  %>%
  as.matrix %>%
  t %>%
  dist %>%
  hclust %>%
  plot
dev.off()


#' # Group interventions
int.groups = list(
  "school_close" = "school_close"
  , "state_of_emergency" = "state_of_emergency"
  , "daycare_close" = "daycare_close"    
  , "face_mask" = c(
    "face_mask_public"
    , "face_mask_business"
  )
  , "lifestyle_close" = c(
    "close_restaurant"
    , "close_gym"
    , "close_movie"
  )
  , "lv3_stay_home" = c(
    "stay_home"
    , "close_business"
  )
  , "ban_nursing_home_visit" = "ban_nursing_home_visit"
  , "suspend_medical" = "suspend_medical"
)


# export start and end dates
x = data.frame(intgr = names(int.groups))
x$intervention = int.groups
x %>%
  unnest(col= intervention) %>%
  right_join(intStartEnd, by = "intervention") %>%
  select(-intervention) %>%
  rename(intervention = intgr) %>%
  group_by(state_name, intervention) %>%
  summarize(
    dateStart = min(dateStart)
    , dateEnd = max(dateEnd)
  ) %>%
  write_csv("data/intervention_googlesheet.csv")

