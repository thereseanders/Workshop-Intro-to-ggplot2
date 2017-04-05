###################################################
# SPEC Workshop: Data Visualization in `R` (Part I)
# Therese Anders
# Cleaning WDI data
# 17/04/07
###################################################

rm(list = ls())

library(dplyr)
library(foreign)

setwd("/Users/thereseanders/Documents/UNI/USC/Spring_2017/SPECRTraining/Part1/data")
wdi <- read.csv("wdi_raw.csv",
                stringsAsFactors = F,
                na.strings = c("..", ""))
names(wdi)


table(wdi$Time)

cleaned <- wdi %>%
  select(year = Time,
         country = Country.Name,
         electricity_pop = `Access.to.electricity....of.population...EG.ELC.ACCS.ZS.`,
         gdppc = `GDP.per.capita..PPP..constant.2011.international.....NY.GDP.PCAP.PP.KD.`,
         energyuse_pop = `Energy.use..kg.of.oil.equivalent.per.capita...EG.USE.PCAP.KG.OE.`,
         energyuse_gdp = `Energy.use..kg.of.oil.equivalent..per..1.000.GDP..constant.2011.PPP...EG.USE.COMM.GD.PP.KD.`,
         renewable_energyuse = `Renewable.energy.consumption....of.total.final.energy.consumption...EG.FEC.RNEW.ZS.`,
         time_electricity = `Time.required.to.get.electricity..days...IC.ELC.TIME.`,
         rights_index = `Strength.of.legal.rights.index..0.weak.to.12.strong...IC.LGL.CRED.XQ.`) %>%
  filter(!(year %in% c("Data from database: World Development Indicators", #Removing additional lines
                       "Last Updated: 03/23/2017"))) %>%
  filter(!is.na(year))

tail(cleaned)

write.csv(cleaned, "wdi_cleaned.csv", row.names = F)

cleaned_part1 <- cleaned %>%
  select(country,
         year, 
         electricity_pop,
         energyuse_pop,
         renewable_energyuse)

write.csv(cleaned_part1, "wdi_cleaned_part1.csv", row.names = F)
