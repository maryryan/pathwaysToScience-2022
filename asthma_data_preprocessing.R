library(readxl)
#### county membership #####
fairfield_county <- c("Bethel",	"Bridgeport",	"Brookfield",	"Danbury",	"Darien",
                      "Easton",	"Fairfield",	"Greenwich", "Monroe",	"New Canaan",
                      "New Fairfield",	"Newtown",	"Norwalk",	"Redding",
                      "Ridgefield", "Shelton",	"Sherman",	"Stamford",
                      "Stratford",	"Trumbull", "Weston",	"Westport",	"Wilton")
hartford_county <- c("Avon",	"Berlin",	"Bloomfield",	"Bristol",	"Burlington",
                     "Canton",	"East Granby",	"East Hartford",	"East Windsor",
                     "Enfield", "Farmington",	"Glastonbury",	"Granby",
                     "Hartford",	"Hartland", "Manchester",	"Marlborough",
                     "New Britain", "Newington",	"Plainville", "Rocky Hill",
                     "Simsbury",	"Southington",	"South Windsor",	"Suffield",
                     "West Hartford",	"Wethersfield",	"Windsor",	"Windsor Locks")

litchfield_county <- c("Barkhamsted",	"Bethlehem",	"Bridgewater",	"Canaan",
                       "Colebrook", "Cornwall",	"Goshen",	"Harwinton",	"Kent",
                       "Litchfield", "Morris",	"New Hartford",	"New Milford",
                       "Norfolk",	"North Canaan", "Plymouth",	"Roxbury",
                       "Salisbury",	"Sharon",	"Thomaston", "Torrington",
                       "Warren",	"Washington",	"Watertown",	"Winchester",
                       "Woodbury", "CORNWALL & WARREN")

middlesex_county <- c("Chester",	"Clinton",	"Cromwell",	"Deep River",	"Durham",
                      "East Haddam",	"East Hampton",	"Essex",	"Haddam",
                      "Killingworth", "Middlefield",	"Middletown",	"Old Saybrook",
                      "Portland","Westbrook")

newhaven_county <- c("Ansonia",	"Beacon Falls",	"Bethany",	"Branford",	"Cheshire",
                     "Derby",	"East Haven",	"Guilford",	"Hamden",	"Madison",
                     "Meriden",	"Middlebury",	"Milford",	"Naugatuck",	"New Haven",
                     "North Branford",	"North Haven",	"Orange",	"Oxford",
                     "Prospect", "Seymour",	"Southbury",	"Wallingford",
                     "Waterbury",	"West Haven", "Wolcott",	"Woodbridge")

newlondon_county <- c("Bozrah",	"Colchester",	"East Lyme",	"Franklin",	"Griswold",
                      "Groton",	"Lebanon",	"Ledyard",	"Lisbon",	"Lyme",
                      "Montville",	"New London",	"North Stonington",	"Norwich",
                      "Old Lyme", "Preston",	"Salem",	"Sprague",	"Stonington",
                      "Voluntown", "Waterford",
                      "GRISWOLD & LISBON")

tolland_county <- c("Andover",	"Bolton",	"Columbia",	"Coventry",	"Ellington",
                    "Hebron",	"Mansfield",	"Somers",	"Stafford",	"Tolland",
                    "Union",	"Vernon", "Willington",
                    "STAFFORD & UNION")

windham_county <- c("Ashford",	"Brooklyn",	"Canterbury",	"Chaplin",	"Eastford",
                    "Hampton",	"Killingly",	"Plainfield",	"Pomfret",	"Putnam",
                    "Scotland",	"Sterling",	"Thompson",	"Windham",	"Woodstock")

#### asthma ####
# 2019 #
asthma1019 <- read_excel("./PTS2022-data/asthma-CTtown-EDRates-201019.xlsx", sheet=2)

colnames(asthma1019) <- asthma1019[3,]

asthma1019 <- asthma1019 %>% 
  clean_names() %>% 
  dplyr::select(c("town","town_n"))

asthma1019 <- asthma1019[-c(1:3),]

asthma1019 <- asthma1019 %>% 
  mutate(town_n = as.integer(town_n),
         town = toupper(town),
         year=2019) %>% 
  dplyr::rename(er_visits = town_n)

asthma1019 <- asthma1019 %>% 
  mutate(county = case_when(town %in% toupper(fairfield_county) ~ "FAIRFIELD",
                            town %in% toupper(hartford_county) ~ "HARTFORD",
                            town %in% toupper(litchfield_county) ~ 'LITCHFIELD',
                            town %in% toupper(middlesex_county) ~ "MIDDLESEX",
                            town %in% toupper(newhaven_county) ~ "NEW HAVEN",
                            town %in% toupper(newlondon_county) ~ "NEW LONDON",
                            town %in% toupper(tolland_county) ~ "TOLLAND",
                            town %in% toupper(windham_county) ~ "WINDHAM",
                            town == "ALL CONNECTICUT" ~ "STATE"))

# get rid of footnotes #
asthma1019 <- asthma1019 %>% 
  dplyr::filter(town %in% unique(asthma1019$town)[1:167])
# get rid of NA rows #
asthma1019 <- asthma1019[which(!(is.na(asthma1019$town))),]

# 2018 #
asthma18 <- read_excel("./PTS2022-data/asthma-CTtown-EDRates-201019.xlsx", sheet="2018")

colnames(asthma18) <- asthma18[3,]

asthma18 <- asthma18 %>% 
  clean_names() %>% 
  dplyr::select(c("town","town_n"))

asthma18 <- asthma18[-c(1:3),]

asthma18 <- asthma18 %>% 
  mutate(town_n = as.integer(town_n),
         town = toupper(town),
         year=2018) %>% 
  dplyr::rename(er_visits = town_n)

asthma18 <- asthma18 %>% 
  mutate(county = case_when(town %in% toupper(fairfield_county) ~ "FAIRFIELD",
                            town %in% toupper(hartford_county) ~ "HARTFORD",
                            town %in% toupper(litchfield_county) ~ 'LITCHFIELD',
                            town %in% toupper(middlesex_county) ~ "MIDDLESEX",
                            town %in% toupper(newhaven_county) ~ "NEW HAVEN",
                            town %in% toupper(newlondon_county) ~ "NEW LONDON",
                            town %in% toupper(tolland_county) ~ "TOLLAND",
                            town %in% toupper(windham_county) ~ "WINDHAM",
                            town == "ALL CONNECTICUT" ~ "STATE"))

# get rid of footnotes #
asthma18 <- asthma18 %>% 
  dplyr::filter(town %in% unique(asthma18$town)[1:167])
# get rid of NA rows #
asthma18 <- asthma18[which(!(is.na(asthma18$town))),]

asthma1019 <- asthma1019 %>% 
  full_join(asthma18)

# 2017 #
asthma17 <- read_excel("./PTS2022-data/asthma-CTtown-EDRates-201019.xlsx", sheet="2017")

colnames(asthma17) <- asthma17[3,]

asthma17 <- asthma17 %>% 
  clean_names() %>% 
  dplyr::select(c("town","town_n"))

asthma17 <- asthma17[-c(1:3),]

asthma17 <- asthma17 %>% 
  mutate(town_n = as.integer(town_n),
         town = toupper(town),
         year=2017) %>% 
  dplyr::rename(er_visits = town_n)

asthma17 <- asthma17 %>% 
  mutate(county = case_when(town %in% toupper(fairfield_county) ~ "FAIRFIELD",
                            town %in% toupper(hartford_county) ~ "HARTFORD",
                            town %in% toupper(litchfield_county) ~ 'LITCHFIELD',
                            town %in% toupper(middlesex_county) ~ "MIDDLESEX",
                            town %in% toupper(newhaven_county) ~ "NEW HAVEN",
                            town %in% toupper(newlondon_county) ~ "NEW LONDON",
                            town %in% toupper(tolland_county) ~ "TOLLAND",
                            town %in% toupper(windham_county) ~ "WINDHAM",
                            town == "ALL CONNECTICUT" ~ "STATE"))

# get rid of footnotes #
asthma17 <- asthma17 %>% 
  dplyr::filter(town %in% unique(asthma17$town)[1:167])
# get rid of NA rows #
asthma17 <- asthma17[which(!(is.na(asthma17$town))),]

asthma1019 <- asthma1019 %>% 
  full_join(asthma17)

# 2016 #
asthma16 <- read_excel("./PTS2022-data/asthma-CTtown-EDRates-201019.xlsx", sheet="2016")

colnames(asthma16) <- asthma16[3,]

asthma16 <- asthma16 %>% 
  clean_names() %>% 
  dplyr::select(c("town","town_n"))

asthma16 <- asthma16[-c(1:3),]

asthma16 <- asthma16 %>% 
  mutate(town_n = as.integer(town_n),
         town = toupper(town),
         year=2016) %>% 
  dplyr::rename(er_visits = town_n)

asthma16 <- asthma16 %>% 
  mutate(county = case_when(town %in% toupper(fairfield_county) ~ "FAIRFIELD",
                            town %in% toupper(hartford_county) ~ "HARTFORD",
                            town %in% toupper(litchfield_county) ~ 'LITCHFIELD',
                            town %in% toupper(middlesex_county) ~ "MIDDLESEX",
                            town %in% toupper(newhaven_county) ~ "NEW HAVEN",
                            town %in% toupper(newlondon_county) ~ "NEW LONDON",
                            town %in% toupper(tolland_county) ~ "TOLLAND",
                            town %in% toupper(windham_county) ~ "WINDHAM",
                            town == "ALL CONNECTICUT" ~ "STATE"))

# get rid of footnotes #
asthma16 <- asthma16 %>% 
  dplyr::filter(town %in% unique(asthma16$town)[1:167])
# get rid of NA rows #
asthma16 <- asthma16[which(!(is.na(asthma16$town))),]

asthma1019 <- asthma1019 %>% 
  full_join(asthma16)

# 2015 #
asthma15 <- read_excel("./PTS2022-data/asthma-CTtown-EDRates-201019.xlsx", sheet="2015")

colnames(asthma15) <- asthma15[3,]

asthma15 <- asthma15 %>% 
  clean_names() %>% 
  dplyr::select(c("town","town_n"))

asthma15 <- asthma15[-c(1:3),]

asthma15 <- asthma15 %>% 
  mutate(town_n = as.integer(town_n),
         town = toupper(town),
         year=2015) %>% 
  dplyr::rename(er_visits = town_n)

asthma15 <- asthma15 %>% 
  mutate(county = case_when(town %in% toupper(fairfield_county) ~ "FAIRFIELD",
                            town %in% toupper(hartford_county) ~ "HARTFORD",
                            town %in% toupper(litchfield_county) ~ 'LITCHFIELD',
                            town %in% toupper(middlesex_county) ~ "MIDDLESEX",
                            town %in% toupper(newhaven_county) ~ "NEW HAVEN",
                            town %in% toupper(newlondon_county) ~ "NEW LONDON",
                            town %in% toupper(tolland_county) ~ "TOLLAND",
                            town %in% toupper(windham_county) ~ "WINDHAM",
                            town == "ALL CONNECTICUT" ~ "STATE"))

# get rid of footnotes #
asthma15 <- asthma15 %>% 
  dplyr::filter(town %in% unique(asthma15$town)[1:167])
# get rid of NA rows #
asthma15 <- asthma15[which(!(is.na(asthma15$town))),]

asthma1019 <- asthma1019 %>% 
  full_join(asthma15)

# 2014 #
asthma14 <- read_excel("./PTS2022-data/asthma-CTtown-EDRates-201019.xlsx", sheet="2014")

colnames(asthma14) <- asthma14[3,]

asthma14 <- asthma14 %>% 
  clean_names() %>% 
  dplyr::select(c("town","town_n"))

asthma14 <- asthma14[-c(1:3),]

asthma14 <- asthma14 %>% 
  mutate(town_n = as.integer(town_n),
         town = toupper(town),
         year=2014) %>% 
  dplyr::rename(er_visits = town_n)

asthma14 <- asthma14 %>% 
  mutate(county = case_when(town %in% toupper(fairfield_county) ~ "FAIRFIELD",
                            town %in% toupper(hartford_county) ~ "HARTFORD",
                            town %in% toupper(litchfield_county) ~ 'LITCHFIELD',
                            town %in% toupper(middlesex_county) ~ "MIDDLESEX",
                            town %in% toupper(newhaven_county) ~ "NEW HAVEN",
                            town %in% toupper(newlondon_county) ~ "NEW LONDON",
                            town %in% toupper(tolland_county) ~ "TOLLAND",
                            town %in% toupper(windham_county) ~ "WINDHAM",
                            town == "ALL CONNECTICUT" ~ "STATE"))

# get rid of footnotes #
asthma14 <- asthma14 %>% 
  dplyr::filter(town %in% unique(asthma14$town)[1:167])
# get rid of NA rows #
asthma14 <- asthma14[which(!(is.na(asthma14$town))),]

asthma1019 <- asthma1019 %>% 
  full_join(asthma14)

# 2013 #
asthma13 <- read_excel("./PTS2022-data/asthma-CTtown-EDRates-201019.xlsx", sheet="2013")

colnames(asthma13) <- asthma13[3,]

asthma13 <- asthma13 %>% 
  clean_names() %>% 
  dplyr::select(c("town","town_n"))

asthma13 <- asthma13[-c(1:3),]

asthma13 <- asthma13 %>% 
  mutate(town_n = as.integer(town_n),
         town = toupper(town),
         year=2013) %>% 
  dplyr::rename(er_visits = town_n)

asthma13 <- asthma13 %>% 
  mutate(county = case_when(town %in% toupper(fairfield_county) ~ "FAIRFIELD",
                            town %in% toupper(hartford_county) ~ "HARTFORD",
                            town %in% toupper(litchfield_county) ~ 'LITCHFIELD',
                            town %in% toupper(middlesex_county) ~ "MIDDLESEX",
                            town %in% toupper(newhaven_county) ~ "NEW HAVEN",
                            town %in% toupper(newlondon_county) ~ "NEW LONDON",
                            town %in% toupper(tolland_county) ~ "TOLLAND",
                            town %in% toupper(windham_county) ~ "WINDHAM",
                            town == "ALL CONNECTICUT" ~ "STATE"))

# get rid of footnotes #
asthma13 <- asthma13 %>% 
  dplyr::filter(town %in% unique(asthma13$town)[1:167])
# get rid of NA rows #
asthma13 <- asthma13[which(!(is.na(asthma13$town))),]

asthma1019 <- asthma1019 %>% 
  full_join(asthma13)

# 2012 #
asthma12 <- read_excel("./PTS2022-data/asthma-CTtown-EDRates-201019.xlsx", sheet="2012")

colnames(asthma12) <- asthma12[3,]

asthma12 <- asthma12 %>% 
  clean_names() %>% 
  dplyr::select(c("town","town_n"))

asthma12 <- asthma12[-c(1:3),]

asthma12 <- asthma12 %>% 
  mutate(town_n = as.integer(town_n),
         town = toupper(town),
         year=2012) %>% 
  dplyr::rename(er_visits = town_n)

asthma12 <- asthma12 %>% 
  mutate(county = case_when(town %in% toupper(fairfield_county) ~ "FAIRFIELD",
                            town %in% toupper(hartford_county) ~ "HARTFORD",
                            town %in% toupper(litchfield_county) ~ 'LITCHFIELD',
                            town %in% toupper(middlesex_county) ~ "MIDDLESEX",
                            town %in% toupper(newhaven_county) ~ "NEW HAVEN",
                            town %in% toupper(newlondon_county) ~ "NEW LONDON",
                            town %in% toupper(tolland_county) ~ "TOLLAND",
                            town %in% toupper(windham_county) ~ "WINDHAM",
                            town == "ALL CONNECTICUT" ~ "STATE"))

# get rid of footnotes #
asthma12 <- asthma12 %>% 
  dplyr::filter(town %in% unique(asthma12$town)[1:167])
# get rid of NA rows #
asthma12 <- asthma12[which(!(is.na(asthma12$town))),]

asthma1019 <- asthma1019 %>% 
  full_join(asthma12)

# 2011 #
asthma11 <- read_excel("./PTS2022-data/asthma-CTtown-EDRates-201019.xlsx", sheet="2011")

colnames(asthma11) <- asthma11[3,]

asthma11 <- asthma11 %>% 
  clean_names() %>% 
  dplyr::select(c("town","town_n"))

asthma11 <- asthma11[-c(1:3),]

asthma11 <- asthma11 %>% 
  mutate(town_n = as.integer(town_n),
         town = toupper(town),
         year=2011) %>% 
  dplyr::rename(er_visits = town_n)

asthma11 <- asthma11 %>% 
  mutate(county = case_when(town %in% toupper(fairfield_county) ~ "FAIRFIELD",
                            town %in% toupper(hartford_county) ~ "HARTFORD",
                            town %in% toupper(litchfield_county) ~ 'LITCHFIELD',
                            town %in% toupper(middlesex_county) ~ "MIDDLESEX",
                            town %in% toupper(newhaven_county) ~ "NEW HAVEN",
                            town %in% toupper(newlondon_county) ~ "NEW LONDON",
                            town %in% toupper(tolland_county) ~ "TOLLAND",
                            town %in% toupper(windham_county) ~ "WINDHAM",
                            town == "ALL CONNECTICUT" ~ "STATE"))

# get rid of footnotes #
asthma11 <- asthma11 %>% 
  dplyr::filter(town %in% unique(asthma11$town)[1:167])
# get rid of NA rows #
asthma11 <- asthma11[which(!(is.na(asthma11$town))),]

asthma1019 <- asthma1019 %>% 
  full_join(asthma11)

# 2010 #
asthma10 <- read_excel("./PTS2022-data/asthma-CTtown-EDRates-201019.xlsx", sheet="2010")

colnames(asthma10) <- asthma10[3,]

asthma10 <- asthma10 %>% 
  clean_names() %>% 
  dplyr::select(c("town","town_n"))

asthma10 <- asthma10[-c(1:3),]

asthma10 <- asthma10 %>% 
  mutate(town_n = as.integer(town_n),
         town = toupper(town),
         year=2010) %>% 
  dplyr::rename(er_visits = town_n)

asthma10 <- asthma10 %>% 
  mutate(county = case_when(town %in% toupper(fairfield_county) ~ "FAIRFIELD",
                            town %in% toupper(hartford_county) ~ "HARTFORD",
                            town %in% toupper(litchfield_county) ~ 'LITCHFIELD',
                            town %in% toupper(middlesex_county) ~ "MIDDLESEX",
                            town %in% toupper(newhaven_county) ~ "NEW HAVEN",
                            town %in% toupper(newlondon_county) ~ "NEW LONDON",
                            town %in% toupper(tolland_county) ~ "TOLLAND",
                            town %in% toupper(windham_county) ~ "WINDHAM",
                            town == "ALL CONNECTICUT" ~ "STATE"))

# get rid of footnotes #
asthma10 <- asthma10 %>% 
  dplyr::filter(town %in% unique(asthma10$town)[1:167])
# get rid of NA rows #
asthma10 <- asthma10[which(!(is.na(asthma10$town))),]

asthma1019 <- asthma1019 %>% 
  full_join(asthma10) %>% 
  dplyr::filter(town != "ALL CONNECTICUT",
                is.na(town) == FALSE)

#### population 2010 - 2019 ####
pop10 <- read_excel("./PTS2022-data/2010_County-level_ASRH.xlsx")
# grab the county name and the total pop #
pop10 <- pop10[,c(1,22)]
colnames(pop10) <- c("county","total_pop_count_10")
pop10 <- pop10 %>%
  na.omit() %>% 
  mutate(county=toupper(county))

pop11 <- read_excel("./PTS2022-data/2011_County-level_ASRH.xlsx")
# grab the county name and the total pop #
pop11 <- pop11[,c(1,22)]
colnames(pop11) <- c("county","total_pop_count_11")
pop11 <- pop11 %>%
  na.omit() %>% 
  mutate(county=toupper(county))

pop12 <- read_excel("./PTS2022-data/2012_County-level_ASRH.xlsx")
# grab the county name and the total pop #
pop12 <- pop12[,c(1,22)]
colnames(pop12) <- c("county","total_pop_count_12")
pop12 <- pop12 %>%
  na.omit() %>% 
  mutate(county=toupper(county))

pop13 <- read_excel("./PTS2022-data/2013_County-level_ASRH.xlsx")
# grab the county name and the total pop #
pop13 <- pop13[,c(1,22)]
colnames(pop13) <- c("county","total_pop_count_13")
pop13 <- pop13 %>%
  na.omit() %>% 
  mutate(county=toupper(county))

pop14 <- read_excel("./PTS2022-data/2014_County-level_ASRH.xlsx")
# grab the county name and the total pop #
pop14 <- pop14[,c(1,22)]
colnames(pop14) <- c("county","total_pop_count_14")
pop14 <- pop14 %>%
  na.omit() %>% 
  mutate(county=toupper(county))

pop15 <- read_excel("./PTS2022-data/2015_County-level_ASRH.xlsx")
# grab the county name and the total pop #
pop15 <- pop15[,c(1,22)]
colnames(pop15) <- c("county","total_pop_count_15")
pop15 <- pop15 %>%
  na.omit() %>% 
  mutate(county=toupper(county))

pop16 <- read_excel("./PTS2022-data/2016_County-level_ASRH.xlsx")
# grab the county name and the total pop #
pop16 <- pop16[,c(1,22)]
colnames(pop16) <- c("county","total_pop_count_16")
pop16 <- pop16 %>%
  na.omit() %>% 
  mutate(county=toupper(county))

pop17 <- read_excel("./PTS2022-data/2017_County-level_ASRH.xlsx")
# grab the county name and the total pop #
pop17 <- pop17[,c(1,22)]
colnames(pop17) <- c("county","total_pop_count_17")
pop17 <- pop17 %>%
  na.omit() %>% 
  mutate(county=toupper(county))

pop18 <- read_excel("./PTS2022-data/2018_County-level_ASRH.xlsx")
# grab the county name and the total pop #
pop18 <- pop18[,c(1,22)]
colnames(pop18) <- c("county","total_pop_count_18")
pop18 <- pop18 %>%
  na.omit() %>% 
  mutate(county=toupper(county))

pop19 <- read_excel("./PTS2022-data/2019_County-level_ASRH.xlsx")
# grab the county name and the total pop #
pop19 <- pop19[,c(1,22)]
colnames(pop19) <- c("county","total_pop_count_19")
pop19 <- pop19 %>%
  na.omit() %>% 
  mutate(county=toupper(county))

pop1019 <- pop10 %>% 
  left_join(pop11) %>% 
  left_join(pop12) %>% 
  left_join(pop13) %>% 
  left_join(pop14) %>% 
  left_join(pop15) %>% 
  left_join(pop16) %>%   
  left_join(pop17) %>%   
  left_join(pop18) %>%   
  left_join(pop19) %>% 
  pivot_longer(!county,names_to="year",
               values_to="total_pop_count") %>% 
  mutate(year=case_when(year == "total_pop_count_10" ~ 2010,
                        year == "total_pop_count_11" ~ 2011,
                        year == "total_pop_count_12" ~ 2012,
                        year == "total_pop_count_13" ~ 2013,
                        year == "total_pop_count_14" ~ 2014,
                        year == "total_pop_count_15" ~ 2015,
                        year == "total_pop_count_16" ~ 2016,
                        year == "total_pop_count_17" ~ 2017,
                        year == "total_pop_count_18" ~ 2018,
                        year == "total_pop_count_19" ~ 2019))

## combine with asthma ##
asthma1019<- asthma1019 %>% 
  group_by(county,year) %>% 
  summarize(county_er_visits=sum(er_visits,na.rm=T)) %>%
  ungroup() %>% 
  left_join(pop1019) %>% 
  mutate(percentage_visits_in_pop = (county_er_visits/total_pop_count)*100)

write.csv(asthma1019, "CT_asthma_201019.csv",row.names = F)
