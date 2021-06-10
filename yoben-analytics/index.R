# install.packages("RPostgreSQL")
# install.packages("RPostgres")
require("RPostgreSQL")
library(data.table)
library(ggplot2)
library(dplyr)
library(ggthemes)
library(tidyr)
library(lubridate)
theme_set(theme_bw())

con <- dbConnect(RPostgres::Postgres())

db <- "postgres"  #provide the name of your db
host_db <- "yobenproduction.cyp1lrsms6em.ap-southeast-1.rds.amazonaws.com"
db_port <- "5432"  # or any other port specified by the DBA
db_user <- "yobenproduction"
db_password <- "yobenproduction"

con <- dbConnect(RPostgres::Postgres(), dbname = db, host=host_db, port=db_port, user=db_user, password=db_password) 

dbListTables(con)

todays_date <- Sys.Date()
first_day <- floor_date(todays_date, 'week') + 1
last_day <- ceiling_date(todays_date, 'week')

parent_code <- 'SC-KLB1QNE9.I4F'
query <- "SELECT * FROM orders WHERE parent_code = parent_code "
test <- cat('<set name=\"',parent_code)

# order_week <- dbReadTable(con, "orders")
orders <- dbGetQuery(con, "SELECT * FROM orders WHERE parent_code = parent_code ")
orders
# select * from orders
# 	where status = 'done' and work_time BETWEEN '2021-04-01 00:00:00' AND '2021-04-30 23:59:59' AND 
# 	service_code in (select code from services
# 	where parent_code = 'SC-KLB1QNE9.I4F');
typeof(order_db)

# dbDisconnect(con)