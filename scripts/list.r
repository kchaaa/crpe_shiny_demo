# Manually Written Lists for The Dropdown Menus

library(DBI)
library(RPostgreSQL)


## Lists ------------------------------------------------------------------
# Define which fields are mandatory
fieldsMandatory <- "dataset"

# Names for the Options OF Dropdown Menu: Dataset

# Names for the Options OF Dropdown Menu: State
STATE <- c('AL', 'AK', 'AZ', 'AR', 'CA', 'CO',
           'CT', 'DE', 'DC', 'FL', 'GA', 'HI',
           'ID', 'IL', 'IN', 'IA', 'KS', 'KY',
           'LA', 'ME', 'MD', 'MA', 'MI', 'MN',
           'MS', 'MO', 'MT', 'NE', 'NV', 'NH',
           'NJ', 'NM', 'NY', 'NC', 'ND', 'OH',
           'OK', 'OR', 'PA', 'RI', 'SC', 'SD',
           'TN', 'TX', 'UT', 'VT', 'VA', 'WA',
           'WV', 'WI', 'WY')

# Names for the Options OF Dropdown Menu: City
CITY <- c('Atlanta', 'Baltimore', 'Boston', 'Camden',
          'Denver', 'Detroit', 'Houston', 'Indianapolis', 
          'Kansas City', 'Little Rock', 'Los Angeles', 'Memphis', 
          'New Orleans', 'New York City', 'Newark', 'Oakland', 
          'Philadelphia', 'San Antonio', 'Tulsa', 'Washington DC' )

# Names for the Options OF Dropdown Menu: District
DISTRICT <- c('APS', 'BCPS', 'BPS', 'CSD', 
              'DPS', 'DPSCD', 'HISD', 'IPS',
              'KCPS', 'LRSD', 'LAUSD', 'SCS',
              'OPBD', 'NYC', 'NPS', 'OUSD',
              'PSD', 'SAISD', 'TPS', 'DCPS')

# Connects to the server
conn <- 
  dbConnect(
    drv = dbDriver("PostgreSQL"), 
    dbname = "Education",
    host = 'education.csj8biafq77k.us-west-2.rds.amazonaws.com',
    port = '5432',
    user = "crpe",
    password = "!crpecrpe1") 


# Names for the Options OF Dropdown Menu: Year
YEAR <- c('1980', '1981', '1982', '1983', '1984', '1985',
          '1986', '1987', '1988', '1989', '1990', '1991',
          '1992', '1993', '1994', '1995', '1996', '1997',
          '1998', '1999', '2000', '2001', '2002', '2003',
          '2004', '2005', '2006', '2007', '2008', '2009',
          '2010', '2011', '2012', '2013', '2014', '2015',
          '2016'
          )