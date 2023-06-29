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
                       "Woodbury")

middlesex_county <- c("Chester",	"Clinton",	"Cromwell",	"Deep River",	"Durham",
                      "East Haddam",	"East Hampton",	"Essex",	"Haddam",
                      "Killingworth", "Middlefield",	"Middletown",	"Old Saybrook",
                      "Portland", "Westbrook")

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
                      "Voluntown", "Waterford")

tolland_county <- c("Andover",	"Bolton",	"Columbia",	"Coventry",	"Ellington",
                    "Hebron",	"Mansfield",	"Somers",	"Stafford",	"Tolland",
                    "Union",	"Vernon", "Willington")

windham_county <- c("Ashford",	"Brooklyn",	"Canterbury",	"Chaplin",	"Eastford",
                    "Hampton",	"Killingly",	"Plainfield",	"Pomfret",	"Putnam",
                    "Scotland",	"Sterling",	"Thompson",	"Windham",	"Woodstock")
#### 2008-2012 cancer ####
# all sites #
cancer0812 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-200812.xlsx", sheet = "All sites")

colnames(cancer0812) <- cancer0812[5,]

cancer0812 <- cancer0812 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

cancer0812 <- cancer0812[-c(1:5),]

cancer0812 <- cancer0812 %>% 
  pivot_longer(!town, names_to="population_type",values_to="all_cancers") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         all_cancers = as.integer(all_cancers))

cancer0812 <- cancer0812 %>% 
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
cancer0812 <- cancer0812 %>% 
  dplyr::filter(town %in% unique(cancer0812$town)[1:170])
# get rid of NA rows #
cancer0812 <- cancer0812[which(!(is.na(cancer0812$town))),]

# breast #
breast0812 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-200812.xlsx", sheet = "Breast")

colnames(breast0812) <- breast0812[5,]

breast0812 <- breast0812 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

breast0812 <- breast0812[-c(1:5),]

breast0812 <- breast0812 %>% 
  pivot_longer(!town, names_to="population_type",values_to="breast") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         breast = as.integer(breast))

cancer0812 <- cancer0812 %>% 
  left_join(breast0812)

# get rid of footnotes #
cancer0812 <- cancer0812 %>% 
  dplyr::filter(town %in% unique(cancer0812$town)[1:170])
# get rid of NA rows #
cancer0812 <- cancer0812[which(!(is.na(cancer0812$town))),]

# colorectal #
colorectal0812 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-200812.xlsx", sheet = "Colorectal")

colnames(colorectal0812) <- colorectal0812[5,]

colorectal0812 <- colorectal0812 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

colorectal0812 <- colorectal0812[-c(1:5),]

colorectal0812 <- colorectal0812 %>% 
  pivot_longer(!town, names_to="population_type",values_to="colorectal") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         colorectal = as.integer(colorectal))

cancer0812 <- cancer0812 %>% 
  left_join(colorectal0812)

# get rid of footnotes #
cancer0812 <- cancer0812 %>% 
  dplyr::filter(town %in% unique(cancer0812$town)[1:170])
# get rid of NA rows #
cancer0812 <- cancer0812[which(!(is.na(cancer0812$town))),]

# kidney and renal pelvis #
kidney0812 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-200812.xlsx", sheet = "Kidney and Renal Pelvis")

colnames(kidney0812) <- kidney0812[5,]

kidney0812 <- kidney0812 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

kidney0812 <- kidney0812[-c(1:5),]

kidney0812 <- kidney0812 %>% 
  pivot_longer(!town, names_to="population_type",values_to="kidney_renal_pelvis") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         kidney_renal_pelvis = as.integer(kidney_renal_pelvis))

cancer0812 <- cancer0812 %>% 
  left_join(kidney0812)

# get rid of footnotes #
cancer0812 <- cancer0812 %>% 
  dplyr::filter(town %in% unique(cancer0812$town)[1:170])
# get rid of NA rows #
cancer0812 <- cancer0812[which(!(is.na(cancer0812$town))),]

# leukemia #
leukemia0812 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-200812.xlsx", sheet = "Leukemia")

colnames(leukemia0812) <- leukemia0812[5,]

leukemia0812 <- leukemia0812 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

leukemia0812 <- leukemia0812[-c(1:5),]

leukemia0812 <- leukemia0812 %>% 
  pivot_longer(!town, names_to="population_type",values_to="leukemia") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         leukemia = as.integer(leukemia))

cancer0812 <- cancer0812 %>% 
  left_join(leukemia0812)

# get rid of footnotes #
cancer0812 <- cancer0812 %>% 
  dplyr::filter(town %in% unique(cancer0812$town)[1:170])
# get rid of NA rows #
cancer0812 <- cancer0812[which(!(is.na(cancer0812$town))),]

# lung and Bronchus #
lung0812 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-200812.xlsx", sheet = "Lung and Bronchus")

colnames(lung0812) <- lung0812[5,]

lung0812 <- lung0812 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

lung0812 <- lung0812[-c(1:5),]

lung0812 <- lung0812 %>% 
  pivot_longer(!town, names_to="population_type",values_to="lung_bronchus") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         lung_bronchus = as.integer(lung_bronchus))

cancer0812 <- cancer0812 %>% 
  left_join(lung0812)

# get rid of footnotes #
cancer0812 <- cancer0812 %>% 
  dplyr::filter(town %in% unique(cancer0812$town)[1:170])
# get rid of NA rows #
cancer0812 <- cancer0812[which(!(is.na(cancer0812$town))),]

# melanoma #
melanoma0812 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-200812.xlsx", sheet = "Melanoma of the Skin")

colnames(melanoma0812) <- melanoma0812[5,]

melanoma0812 <- melanoma0812 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

melanoma0812 <- melanoma0812[-c(1:5),]

melanoma0812 <- melanoma0812 %>% 
  pivot_longer(!town, names_to="population_type",values_to="melanoma") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         melanoma = as.integer(melanoma))

cancer0812 <- cancer0812 %>% 
  left_join(melanoma0812)

# get rid of footnotes #
cancer0812 <- cancer0812 %>% 
  dplyr::filter(town %in% unique(cancer0812$town)[1:170])
# get rid of NA rows #
cancer0812 <- cancer0812[which(!(is.na(cancer0812$town))),]

# lymphoma #
lymphoma0812 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-200812.xlsx", sheet = "Non-Hodgkin Lymphoma")

colnames(lymphoma0812) <- lymphoma0812[5,]

lymphoma0812 <- lymphoma0812 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

lymphoma0812 <- lymphoma0812[-c(1:5),]

lymphoma0812 <- lymphoma0812 %>% 
  pivot_longer(!town, names_to="population_type",values_to="lymphoma") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         lymphoma = as.integer(lymphoma))

cancer0812 <- cancer0812 %>% 
  left_join(lymphoma0812)

# get rid of footnotes #
cancer0812 <- cancer0812 %>% 
  dplyr::filter(town %in% unique(cancer0812$town)[1:170])
# get rid of NA rows #
cancer0812 <- cancer0812[which(!(is.na(cancer0812$town))),]

# oral #
oral0812 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-200812.xlsx", sheet = "Oral Cavity and Pharynx")

colnames(oral0812) <- oral0812[5,]

oral0812 <- oral0812 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

oral0812 <- oral0812[-c(1:5),]

oral0812 <- oral0812 %>% 
  pivot_longer(!town, names_to="population_type",values_to="oral") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         oral = as.integer(oral))

cancer0812 <- cancer0812 %>% 
  left_join(oral0812)

# get rid of footnotes #
cancer0812 <- cancer0812 %>% 
  dplyr::filter(town %in% unique(cancer0812$town)[1:170])
# get rid of NA rows #
cancer0812 <- cancer0812[which(!(is.na(cancer0812$town))),]

# ovary #
ovary0812 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-200812.xlsx", sheet = "Ovary")

colnames(ovary0812) <- ovary0812[5,]

ovary0812 <- ovary0812 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases"))

ovary0812 <- ovary0812[-c(1:5),]

ovary0812 <- ovary0812 %>% 
  pivot_longer(!town, names_to="population_type",values_to="ovary") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "female"),
         ovary = as.integer(ovary))

cancer0812 <- cancer0812 %>% 
  left_join(ovary0812)

# get rid of footnotes #
cancer0812 <- cancer0812 %>% 
  dplyr::filter(town %in% unique(cancer0812$town)[1:170])
# get rid of NA rows #
cancer0812 <- cancer0812[which(!(is.na(cancer0812$town))),]

# pancreas #
pancreas0812 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-200812.xlsx", sheet = "Pancreas")

colnames(pancreas0812) <- pancreas0812[5,]

pancreas0812 <- pancreas0812 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

pancreas0812 <- pancreas0812[-c(1:5),]

pancreas0812 <- pancreas0812 %>% 
  pivot_longer(!town, names_to="population_type",values_to="pancreas") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         pancreas = as.integer(pancreas))

cancer0812 <- cancer0812 %>% 
  left_join(pancreas0812)

# get rid of footnotes #
cancer0812 <- cancer0812 %>% 
  dplyr::filter(town %in% unique(cancer0812$town)[1:170])
# get rid of NA rows #
cancer0812 <- cancer0812[which(!(is.na(cancer0812$town))),]

# prostate #
prostate0812 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-200812.xlsx", sheet = "Prostate")

colnames(prostate0812) <- prostate0812[5,]

prostate0812 <- prostate0812 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases"))

prostate0812 <- prostate0812[-c(1:5),]

prostate0812 <- prostate0812 %>% 
  pivot_longer(!town, names_to="population_type",values_to="prostate") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "male"),
         prostate = as.integer(prostate))

cancer0812 <- cancer0812 %>% 
  left_join(prostate0812)

# get rid of footnotes #
cancer0812 <- cancer0812 %>% 
  dplyr::filter(town %in% unique(cancer0812$town)[1:170])
# get rid of NA rows #
cancer0812 <- cancer0812[which(!(is.na(cancer0812$town))),]

# thyroid #
thyroid0812 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-200812.xlsx", sheet = "Thyroid")

colnames(thyroid0812) <- thyroid0812[5,]

thyroid0812 <- thyroid0812 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

thyroid0812 <- thyroid0812[-c(1:5),]

thyroid0812 <- thyroid0812 %>% 
  pivot_longer(!town, names_to="population_type",values_to="thyroid") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         thyroid = as.integer(thyroid))

cancer0812 <- cancer0812 %>% 
  left_join(thyroid0812)

# get rid of footnotes #
cancer0812 <- cancer0812 %>% 
  dplyr::filter(town %in% unique(cancer0812$town)[1:170])
# get rid of NA rows #
cancer0812 <- cancer0812[which(!(is.na(cancer0812$town))),]

# bladder #
bladder0812 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-200812.xlsx", sheet = "Urinary Bladder")

colnames(bladder0812) <- bladder0812[5,]

bladder0812 <- bladder0812 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

bladder0812 <- bladder0812[-c(1:5),]

bladder0812 <- bladder0812 %>% 
  pivot_longer(!town, names_to="population_type",values_to="bladder") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         bladder = as.integer(bladder))

cancer0812 <- cancer0812 %>% 
  left_join(bladder0812)

# get rid of footnotes #
cancer0812 <- cancer0812 %>% 
  dplyr::filter(town %in% unique(cancer0812$town)[1:170])
# get rid of NA rows #
cancer0812 <- cancer0812[which(!(is.na(cancer0812$town))),]

# get rid of ovary and prostate cancer, and the ALL CONNECTICUT rows #
cancer0812 <- cancer0812 %>% 
  dplyr::select(-c("ovary","prostate")) %>% 
  dplyr::filter(town!="ALL CONNECTICUT",
                population_type == "total_pop") %>% 
  pivot_longer(!c("town","county","population_type"),
             names_to="cancer_type",
             values_to="number_of_cases") %>% 
  mutate(county=ifelse(town == "CANAAN and No. CANAAN", "LITCHFIELD",county))

#### 2010-2012 population ####
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


pop1012 <- pop10 %>% 
  left_join(pop11)
pop1012 <- pop1012 %>% 
  left_join(pop12)

# get mean pop #
pop1012_mean <- pop1012 %>% 
  pivot_longer(!county,names_to="year",
               values_to="total_pop_count") %>% 
  group_by(county) %>% 
  summarize(mean_pop=mean(total_pop_count))

#### pop adjust 2008-2012 cancer ####
cancer0812 <- cancer0812 %>% 
  dplyr::select(-population_type) %>%
  group_by(county, cancer_type) %>% 
  summarize(county_cases=sum(number_of_cases)) %>%
  ungroup() %>% 
  left_join(pop1012_mean) %>% 
  mutate(percentage_cases_in_pop = (county_cases/mean_pop)*100,
         year_range="2008-2012")



#### 2010-2014 cancer ####
# all sites #
cancer1014 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-201014.xlsx", sheet = "All sites")

colnames(cancer1014) <- cancer1014[5,]

cancer1014 <- cancer1014 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

cancer1014 <- cancer1014[-c(1:5),]

cancer1014 <- cancer1014 %>% 
  pivot_longer(!town, names_to="population_type",values_to="all_cancers") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         all_cancers = as.integer(all_cancers))

cancer1014 <- cancer1014 %>% 
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
cancer1014 <- cancer1014 %>% 
  dplyr::filter(town %in% unique(cancer1014$town)[1:170])
# get rid of NA rows #
cancer1014 <- cancer1014[which(!(is.na(cancer1014$town))),]

# breast #
breast1014 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-201014.xlsx", sheet = "Breast")

colnames(breast1014) <- breast1014[5,]

breast1014 <- breast1014 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

breast1014 <- breast1014[-c(1:5),]

breast1014 <- breast1014 %>% 
  pivot_longer(!town, names_to="population_type",values_to="breast") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         breast = as.integer(breast))

cancer1014 <- cancer1014 %>% 
  left_join(breast1014)


# get rid of footnotes #
cancer1014 <- cancer1014 %>% 
  dplyr::filter(town %in% unique(cancer1014$town)[1:170])
# get rid of NA rows #
cancer1014 <- cancer1014[which(!(is.na(cancer1014$town))),]

# colorectal #
colorectal1014 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-201014.xlsx", sheet = "Colorectal")

colnames(colorectal1014) <- colorectal1014[5,]

colorectal1014 <- colorectal1014 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

colorectal1014 <- colorectal1014[-c(1:5),]

colorectal1014 <- colorectal1014 %>% 
  pivot_longer(!town, names_to="population_type",values_to="colorectal") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         colorectal = as.integer(colorectal))

cancer1014 <- cancer1014 %>% 
  left_join(colorectal1014)


# get rid of footnotes #
cancer1014 <- cancer1014 %>% 
  dplyr::filter(town %in% unique(cancer1014$town)[1:170])
# get rid of NA rows #
cancer1014 <- cancer1014[which(!(is.na(cancer1014$town))),]

# kidney and renal pelvis #
kidney1014 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-201014.xlsx", sheet = "Kidney and Renal Pelvis")

colnames(kidney1014) <- kidney1014[5,]

kidney1014 <- kidney1014 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

kidney1014 <- kidney1014[-c(1:5),]

kidney1014 <- kidney1014 %>% 
  pivot_longer(!town, names_to="population_type",values_to="kidney_renal_pelvis") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         kidney_renal_pelvis = as.integer(kidney_renal_pelvis))

cancer1014 <- cancer1014 %>% 
  left_join(kidney1014)


# get rid of footnotes #
cancer1014 <- cancer1014 %>% 
  dplyr::filter(town %in% unique(cancer1014$town)[1:170])
# get rid of NA rows #
cancer1014 <- cancer1014[which(!(is.na(cancer1014$town))),]

# leukemia #
leukemia1014 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-201014.xlsx", sheet = "Leukemia")

colnames(leukemia1014) <- leukemia1014[5,]

leukemia1014 <- leukemia1014 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

leukemia1014 <- leukemia1014[-c(1:5),]

leukemia1014 <- leukemia1014 %>% 
  pivot_longer(!town, names_to="population_type",values_to="leukemia") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         leukemia = as.integer(leukemia))

cancer1014 <- cancer1014 %>% 
  left_join(leukemia1014)


# get rid of footnotes #
cancer1014 <- cancer1014 %>% 
  dplyr::filter(town %in% unique(cancer1014$town)[1:170])
# get rid of NA rows #
cancer1014 <- cancer1014[which(!(is.na(cancer1014$town))),]

# lung and Bronchus #
lung1014 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-201014.xlsx", sheet = "Lung and Bronchus")

colnames(lung1014) <- lung1014[5,]

lung1014 <- lung1014 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

lung1014 <- lung1014[-c(1:5),]

lung1014 <- lung1014 %>% 
  pivot_longer(!town, names_to="population_type",values_to="lung_bronchus") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         lung_bronchus = as.integer(lung_bronchus))

cancer1014 <- cancer1014 %>% 
  left_join(lung1014)


# get rid of footnotes #
cancer1014 <- cancer1014 %>% 
  dplyr::filter(town %in% unique(cancer1014$town)[1:170])
# get rid of NA rows #
cancer1014 <- cancer1014[which(!(is.na(cancer1014$town))),]

# melanoma #
melanoma1014 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-201014.xlsx", sheet = "Melanoma of the Skin")

colnames(melanoma1014) <- melanoma1014[5,]

melanoma1014 <- melanoma1014 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

melanoma1014 <- melanoma1014[-c(1:5),]

melanoma1014 <- melanoma1014 %>% 
  pivot_longer(!town, names_to="population_type",values_to="melanoma") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         melanoma = as.integer(melanoma))

cancer1014 <- cancer1014 %>% 
  left_join(melanoma1014)


# get rid of footnotes #
cancer1014 <- cancer1014 %>% 
  dplyr::filter(town %in% unique(cancer1014$town)[1:170])
# get rid of NA rows #
cancer1014 <- cancer1014[which(!(is.na(cancer1014$town))),]

# lymphoma #
lymphoma1014 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-201014.xlsx", sheet = "Non-Hodgkin Lymphoma")

colnames(lymphoma1014) <- lymphoma1014[5,]

lymphoma1014 <- lymphoma1014 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

lymphoma1014 <- lymphoma1014[-c(1:5),]

lymphoma1014 <- lymphoma1014 %>% 
  pivot_longer(!town, names_to="population_type",values_to="lymphoma") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         lymphoma = as.integer(lymphoma))

cancer1014 <- cancer1014 %>% 
  left_join(lymphoma1014)


# get rid of footnotes #
cancer1014 <- cancer1014 %>% 
  dplyr::filter(town %in% unique(cancer1014$town)[1:170])
# get rid of NA rows #
cancer1014 <- cancer1014[which(!(is.na(cancer1014$town))),]

# oral #
oral1014 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-201014.xlsx", sheet = "Oral Cavity and Pharynx")

colnames(oral1014) <- oral1014[5,]

oral1014 <- oral1014 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

oral1014 <- oral1014[-c(1:5),]

oral1014 <- oral1014 %>% 
  pivot_longer(!town, names_to="population_type",values_to="oral") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         oral = as.integer(oral))

cancer1014 <- cancer1014 %>% 
  left_join(oral1014)


# get rid of footnotes #
cancer1014 <- cancer1014 %>% 
  dplyr::filter(town %in% unique(cancer1014$town)[1:170])
# get rid of NA rows #
cancer1014 <- cancer1014[which(!(is.na(cancer1014$town))),]

# ovary #
ovary1014 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-201014.xlsx", sheet = "Ovary")

colnames(ovary1014) <- ovary1014[5,]

ovary1014 <- ovary1014 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases"))

ovary1014 <- ovary1014[-c(1:5),]

ovary1014 <- ovary1014 %>% 
  pivot_longer(!town, names_to="population_type",values_to="ovary") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~"female"),
         ovary = as.integer(ovary))

cancer1014 <- cancer1014 %>% 
  left_join(ovary1014)


# get rid of footnotes #
cancer1014 <- cancer1014 %>% 
  dplyr::filter(town %in% unique(cancer1014$town)[1:170])
# get rid of NA rows #
cancer1014 <- cancer1014[which(!(is.na(cancer1014$town))),]

# pancreas #
pancreas1014 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-201014.xlsx", sheet = "Pancreas")

colnames(pancreas1014) <- pancreas1014[5,]

pancreas1014 <- pancreas1014 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

pancreas1014 <- pancreas1014[-c(1:5),]

pancreas1014 <- pancreas1014 %>% 
  pivot_longer(!town, names_to="population_type",values_to="pancreas") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         pancreas = as.integer(pancreas))

cancer1014 <- cancer1014 %>% 
  left_join(pancreas1014)


# get rid of footnotes #
cancer1014 <- cancer1014 %>% 
  dplyr::filter(town %in% unique(cancer1014$town)[1:170])
# get rid of NA rows #
cancer1014 <- cancer1014[which(!(is.na(cancer1014$town))),]

# prostate #
prostate1014 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-201014.xlsx", sheet = "Prostate")

colnames(prostate1014) <- prostate1014[5,]

prostate1014 <- prostate1014 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases"))

prostate1014 <- prostate1014[-c(1:5),]

prostate1014 <- prostate1014 %>% 
  pivot_longer(!town, names_to="population_type",values_to="prostate") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "male"),
         prostate = as.integer(prostate))

cancer1014 <- cancer1014 %>% 
  left_join(prostate1014)


# get rid of footnotes #
cancer1014 <- cancer1014 %>% 
  dplyr::filter(town %in% unique(cancer1014$town)[1:170])
# get rid of NA rows #
cancer1014 <- cancer1014[which(!(is.na(cancer1014$town))),]

# thyroid #
thyroid1014 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-201014.xlsx", sheet = "Thyroid")

colnames(thyroid1014) <- thyroid1014[5,]

thyroid1014 <- thyroid1014 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

thyroid1014 <- thyroid1014[-c(1:5),]

thyroid1014 <- thyroid1014 %>% 
  pivot_longer(!town, names_to="population_type",values_to="thyroid") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         thyroid = as.integer(thyroid))

cancer1014 <- cancer1014 %>% 
  left_join(thyroid1014)


# get rid of footnotes #
cancer1014 <- cancer1014 %>% 
  dplyr::filter(town %in% unique(cancer1014$town)[1:170])
# get rid of NA rows #
cancer1014 <- cancer1014[which(!(is.na(cancer1014$town))),]

# bladder #
bladder1014 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-201014.xlsx", sheet = "Urinary Bladder")

colnames(bladder1014) <- bladder1014[5,]

bladder1014 <- bladder1014 %>% 
  clean_names() %>% 
  dplyr::select(c("town","number_of_cases",
                  "number_of_cases_2","number_of_cases_3"))

bladder1014 <- bladder1014[-c(1:5),]

bladder1014 <- bladder1014 %>% 
  pivot_longer(!town, names_to="population_type",values_to="bladder") %>% 
  mutate(population_type = case_when(population_type == "number_of_cases" ~ "total_pop",
                                     population_type == "number_of_cases_2" ~ "female",
                                     population_type == "number_of_cases_3" ~ "male"),
         bladder = as.integer(bladder))

cancer1014 <- cancer1014 %>% 
  left_join(bladder1014)


# get rid of footnotes #
cancer1014 <- cancer1014 %>% 
  dplyr::filter(town %in% unique(cancer1014$town)[1:170])
# get rid of NA rows #
cancer1014 <- cancer1014[which(!(is.na(cancer1014$town))),]

# get rid of ovary and prostate cancer, and the ALL CONNECTICUT rows #
cancer1014 <- cancer1014 %>% 
  dplyr::select(-c("ovary","prostate")) %>% 
  dplyr::filter(town!="ALL CONNECTICUT",
                population_type == "total_pop")
cancer1014 <- cancer1014 %>% 
  pivot_longer(!c("town","county","population_type"),
               names_to="cancer_type",
               values_to="number_of_cases") %>% 
  mutate(county=ifelse(town == "CANAAN and No. CANAAN", "LITCHFIELD",county))


#### 2010-2014 population ####
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

pop1014 <- pop10 %>% 
  left_join(pop11)
pop1014 <- pop1014 %>% 
  left_join(pop12)
pop1014 <- pop1014 %>% 
  left_join(pop13)
pop1014 <- pop1014 %>% 
  left_join(pop14)

# get mean pop #
pop1014_mean <- pop1014 %>% 
  pivot_longer(!county,names_to="year",
               values_to="total_pop_count") %>% 
  group_by(county) %>% 
  summarize(mean_pop=mean(total_pop_count))

#### pop adjust 2010-2014 cancer ####
cancer1014 <- cancer1014 %>% 
  dplyr::select(-population_type) %>%
  group_by(county, cancer_type) %>% 
  summarize(county_cases=sum(number_of_cases)) %>%
  ungroup() %>% 
  left_join(pop1014_mean) %>%
  mutate(percentage_cases_in_pop = (county_cases/mean_pop)*100,
         year_range="2010-2014")


#### combine 2008-2012 and 2010-2014 ####
cancer0814 <- cancer0812 %>% 
  full_join(cancer1014)

write.csv(cancer0814, "CT_cancer_200814.csv",row.names = F)
