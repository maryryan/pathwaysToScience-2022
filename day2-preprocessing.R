library(readxl)
library(janitor)

# cancer #
cancer1014 <- read_excel("./PTS2022-data/cancer-incidence-ageAdjusted-CTtown-bySite-201014.xlsx", sheet = "All sites")

colnames(cancer1014) <- cancer1014[5,]

cancer1014 <- cancer1014[-c(1:5),]
cancer1014 <- cancer1014[,c(1,2,6,10)]

colnames(cancer1014)[2:4] <- c("Number\r\nof Cases, Total Pop",
                               "Number\r\nof Cases, Females",
                               "Number\r\nof Cases, Males")
write.csv(cancer1014, "CT_cancer_201014.csv")

# county membership #
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
                      "Portland")

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

county_membership <- c(fairfield_county,hartford_county,litchfield_county,
                           middlesex_county,newhaven_county,newlondon_county,
                           tolland_county,windham_county, "All Connecticut")

county_membership <- county_membership %>% 
  as.data.frame()
colnames(county_membership) <- "town"
county_membership <- county_membership %>% 
  mutate(town = toupper(town),
         county = case_when(town %in% toupper(fairfield_county) ~ "FAIRFIELD",
                            town %in% toupper(hartford_county) ~ "HARTFORD",
                            town %in% toupper(litchfield_county) ~ 'LITCHFIELD',
                            town %in% toupper(middlesex_county) ~ "MIDDESEX",
                            town %in% toupper(newhaven_county) ~ "NEW HAVEN",
                            town %in% toupper(newlondon_county) ~ "NEW LONDON",
                            town %in% toupper(tolland_county) ~ "TOLLAND",
                            town %in% toupper(windham_county) ~ "WINDHAM",
                            town == "ALL CONNECTICUT" ~ "STATE"))

write.csv(county_membership, "CT_county_membership.csv")

#### answer testing ####
# Q2 #
cancer1014 <- cancer1014 %>% 
  clean_names() %>% 
  pivot_longer(!town, names_to="population_type",values_to="number_of_cases")

# Q3 #
cancer1014 <- cancer1014 %>% 
  mutate(population_type = case_when(population_type == "number_of_cases_total_pop" ~ "total_pop",
                                     population_type == "number_of_cases_females" ~ "females",
                                     population_type == "number_of_cases_males" ~ "males"))

# Q4 #
cancer1014 <- cancer1014 %>% 
  mutate(number_of_cases = as.integer(number_of_cases))

# Q5 #
unique(cancer1014$town)