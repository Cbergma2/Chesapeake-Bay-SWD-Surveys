# R code for: Detection of seagrass wasting disease and the causative agent,
# Labyrinthula zosterae, in the Chesapeake Bay region

# Chelsea N. Bergman*, Harold J. Schreier, Christopher J. Patrick, Colleen A. Burge
#
# Field Survey


############################### Intro ###############################
# Clear the environment
remove(list = ls())
# clear console
cat("\014")

# # Load packages
library(plyr)
library(Rmisc)
library(ggplot2)

# Load the data, rename
CBSIntensityMaster <- read.csv("~/Downloads/GradSchool/Thesis Research/CB Surveys/Calculations/CB2021_qPCR.csv")
CBSqPCRMaster <- CBSIntensityMaster[!is.na(CBSIntensityMaster$Site),] #get rid of NAs
CBSqPCRMaster <- CBSIntensityMaster[!is.na(CBSIntensityMaster$Transect),] #get rid of NAs
CBSMasterScansMeasurments <- read.csv("~/Downloads/GradSchool/Thesis Research/CB Surveys/Calculations/CBSurveySWD2021Master.csv")
CBSMasterScans <- CBSMasterScansMeasurments[!is.na(CBSMasterScansMeasurments$Transect),] #get rid of NAs


# Change fixed effects (LabyConc and OysterDensity) from discrete(as.factor) to continuous (as.numeric)
# Set everything as factors that needs to be
CBSqPCRMaster$Site <- as.factor(CBSqPCRMaster$Site)
CBSqPCRMaster$Transect <- as.numeric(CBSqPCRMaster$Transect)
CBSqPCRMaster$Quadrat <- as.numeric(CBSqPCRMaster$Quadrat)
CBSqPCRMaster$Classification <- as.factor(CBSqPCRMaster$Classification)
CBSqPCRMaster$Copies.mg <- as.numeric(CBSqPCRMaster$Copies.mg)
CBSqPCRMaster$Logdata <- log10(CBSqPCRMaster$Copies.mg + 1) #create new column with log transformed qPCR data for plots

CBSMasterScans$Site <- as.factor(CBSMasterScans$Site)
CBSMasterScans$Transect <- as.factor(CBSMasterScans$Transect)
CBSMasterScans$Quadrat <- as.numeric(CBSMasterScans$Quadrat)
CBSMasterScans$Health <- as.factor(CBSMasterScans$Health)
CBSMasterScans$Leaf <- as.numeric(CBSMasterScans$Leaf)
CBSMasterScans$Severity <- as.numeric(CBSMasterScans$Severity)
CBSMasterScans$SeverityPercent <- (CBSMasterScans$Severity) * 100
CBSMasterScans$SeverityPercent <- as.numeric(CBSMasterScans$SeverityPercent)
CBSMasterScans$Prevalence <- as.factor(CBSMasterScans$Prevalence)
CBSqPCRMaster2 <- CBSqPCRMaster[CBSqPCRMaster$Site != "S", ]


# 1. Plots -------------
## 1.1 Intensity -------------
SurveyIntensity <- summarySE(data = CBSqPCRMaster2, measurevar = "Logdata", groupvars = c("Site", "Classification"))
plot1.1 <- ggplot() +
    geom_bar(data = SurveyIntensity,
             aes(x = Site,
                 y = Logdata),
             stat = "identity",
             position = position_dodge(0.9)) +
    geom_errorbar(data = SurveyIntensity,
                  aes(x = Site,
                      ymin = Logdata - se,
                      ymax = Logdata + se),
                  width = 0.2,
                  position = position_dodge(0.9)) +
    geom_point(data = CBSqPCRMaster2,
               aes(x = Site,
                   y = Logdata),
               position = position_dodge(0.9)) +
        scale_y_continuous() +
    labs(x = "Site",
         y = "Copies of Lz DNA/mg of eelgrass tissue (log10(x+1))") +
    theme_classic(base_size = 15) +
    theme(strip.background = element_blank(),
          strip.placement = "outside",
          axis.text = element_text(color = "black"),
          legend.position = "top")
plot1.1

head(SurveyIntensity)

SurveyIntensityBySite <- summarySE(data = CBSqPCRMaster2, measurevar = "Copies.mg", groupvars = c("Site"))

plot1.2 <- ggplot() +
    geom_bar(data = SurveyIntensity,
             aes(x = Site,
                 y = Logdata,
                 fill = Classification),
             stat = "identity",
             position = position_dodge(0.9)) +
    geom_errorbar(data = SurveyIntensity,
                  aes(x = Site,
                      ymin = Logdata - se,
                      ymax = Logdata + se,
                      group = Classification),
                  width = 0.2,
                  position = position_dodge(0.9)) +
    geom_point(data = CBSqPCRMaster2,
               aes(x = Site,
                   y = Logdata,
                   fill = Classification),
               position = position_dodge(0.9)) +
    scale_fill_grey(start = 0.3,
                    end = 0.8,
                    labels = c("Healthy", "Lesioned"),
                    name = "Classification") +
    scale_x_discrete(labels = c("Guinea Marsh", "Hungars Creek North", "Hungars Creek South", "Horn Harbor", "Poquoson", "Severn"))+
    scale_y_continuous() +
    labs(x = "Site",
         y = expression(atop("Copies of Lz DNA/mg", paste("of eelgrass tissue (log10(x+1))")))) +
    theme_classic(base_size = 25) +
    theme(strip.background = element_blank(),
          strip.placement = "outside",
          axis.text = element_text(color = "black"),
          legend.position = "top")
plot1.2



## 1.2 Severity -------------
SevPer <- summarySE(data = CBSMasterScans, measurevar = "SeverityPercent", groupvars = c("Site"))
BarplotSevbySite <- ggplot() +
    geom_bar(data = SevPer,
             aes(x = Site,
                 y = SeverityPercent),
             stat = "identity",
             position = position_dodge(0.9)) +
    geom_errorbar(data = SevPer,
                  aes(x = Site,
                      ymin = SeverityPercent - se,
                      ymax = SeverityPercent + se),
                  width = 0.2,
                  position = position_dodge(0.9)) +
    geom_point(data = CBSMasterScans,
               aes(x = Site,
                   y = SeverityPercent),
               position = position_dodge(0.9)) +
    scale_fill_grey(start = 0.3,
                    end = 0.8,
                    labels = c("1", "2"),
                    name = "Transect") +
    scale_x_discrete(labels = c("Guinea Marsh", "Hungars Creek North", "Hungars Creek South", "Horn Harbor", "Poquoson")) +
    scale_y_continuous(limits = c(0, 100)) +
    labs(x = "Site",
         y = "Severity (%)") +
    ggtitle("Severity of SWD at different sites in the Chesapeake Bay") +
    theme_classic(base_size = 15) +
    theme(strip.background = element_blank(),
          strip.placement = "outside",
          axis.text = element_text(color = "black"),
          legend.position = "top")
BarplotSevbySite

SevPer <- summarySE(data = CBSMasterScans, measurevar = "SeverityPercent", groupvars = c("Site", "Transect"))
BarplotSevbySiteandTranscect <- ggplot() +
    geom_bar(data = SevPer,
             aes(x = Site,
                 y = SeverityPercent,
                 fill = Transect),
             stat = "identity",
             position = position_dodge(0.9)) +
    geom_errorbar(data = SevPer,
                  aes(x = Site,
                      ymin = SeverityPercent - se,
                      ymax = SeverityPercent + se,
                      group = Transect),
                  width = 0.2,
                  position = position_dodge(0.9)) +
    geom_point(data = CBSMasterScans,
               aes(x = Site,
                   y = SeverityPercent,
                   group = Transect),
               position = position_dodge(0.9)) +
    scale_fill_grey(start = 0.3,
                    end = 0.8,
                    labels = c("1", "2"),
                    name = "Transect") +
    scale_x_discrete(labels = c("GM", "HCN", "HCS", "HH", "P")) +
    scale_y_continuous(limits = c(0, 100)) +
    labs(x = "Site",
         y = "Severity (%)") +
    theme_classic(base_size = 15) +
    theme(strip.background = element_blank(),
          strip.placement = "outside",
          axis.text = element_text(color = "black"),
          legend.position = "top")
BarplotSevbySiteandTranscect


## 1.3 Prevalence -------------
CBSPrev <- summarySE(data = CBSMasterScans, measurevar = "Prevalence", groupvars = c("Site"))
BarplotSevbySite <- ggplot() +
    geom_bar(data = CBSPrev,
             aes(x = Site,
                 y = Prevalence),
             stat = "identity",
             position = position_dodge(0.9)) +
    geom_errorbar(data = CBSPrev,
                  aes(x = Site,
                      ymin = Prevalence - se,
                      ymax = Prevalence + se),
                  width = 0.2,
                  position = position_dodge(0.9)) +
    geom_point(data = CBSMasterScans,
               aes(x = Site,
                   y = Prevalence),
               position = position_dodge(0.9)) +
       scale_x_discrete(labels = c("Guinea Marsh", "Hungars Creek South", "Hungars Creek North", "Poquoson")) +
    scale_y_continuous(limits = c(0, 100)) +
    labs(x = "Site",
         y = "Prevalence of SWD Lesions") +
    ggtitle("Prevalence of SWD at different sites in the Chesapeake Bay") +
    theme_classic(base_size = 15) +
    theme(strip.background = element_blank(),
          strip.placement = "outside",
          axis.text = element_text(color = "black"),
          legend.position = "top")
BarplotSevbySite

# 2. Stats -------------
## 2.1 Intensity -------------

#Normality?
hist(CBSqPCRMaster$Copies.mg)
qqnorm(CBSqPCRMaster$Copies.mg)
qqline(CBSqPCRMaster$Copies.mg)
shapiro.test(CBSqPCRMaster$Copies.mg) #Bad
kruskal.test(Copies.mg ~ Site, data = CBSqPCRMaster)
# (p<0.001) Infection intensity by site is significantly different
source("http://www.statmethods.net/RiA/wmc.txt")

WMCIntensity <- wmc(Copies.mg ~Site, data=CBSqPCRMaster, method="holm")

# Without Severn
CBSqPCRMaster2 <- CBSqPCRMaster[CBSqPCRMaster$Site != "S", ]
hist(CBSqPCRMaster2$Copies.mg)
qqnorm(CBSqPCRMaster2$Copies.mg)
qqline(CBSqPCRMaster2$Copies.mg)
shapiro.test(CBSqPCRMaster2$Copies.mg)
kruskal.test(Copies.mg ~ Site, data = CBSqPCRMaster2)
# (p<0.05) Infection intensity by site is significantly different

# fitIntensity <- aov (Logdata ~Site, data = CBSqPCRMaster2)
# summary(fitIntensity)
# TukeyHSD(fitIntensity)

WMCIntensity <- wmc(Logdata ~Site, data=CBSqPCRMaster2, method="holm")
#By quadrat
Test <- ggplot(CBSqPCRMaster2, aes(x = Site, y = Quadrat, fill = Logdata)) +
    geom_tile(color = "white",
              lwd = 1.5,
              linetype = 1) +
    scale_fill_gradient(low = "#80CAAC",
                        high = "#7E1F14",
                        guide = "colorbar") +
    coord_fixed() +
    guides(fill = guide_colourbar(title = "Lz Infection Intensity"))
Test

WMCIntensity <- wmc(Copies.mg ~Quadrat, data=CBSqPCRMaster2, method="holm")
#Seems off
sumInt <- summarySE(data = CBSqPCRMaster2, measurevar = "Logdata", groupvars = c("Site"))
sumIntMean <- summarySE(data = CBSqPCRMaster2, measurevar = "Copies.mg", groupvars = c("Site"))
## 2.2 Severity -------------

hist(CBSMasterScans$Severity)
qqnorm(CBSMasterScans$Severity)
qqline(CBSMasterScans$Severity)
shapiro.test(CBSMasterScans$Severity)
kruskal.test(Severity ~ Site, data = CBSMasterScans)
# (p<0.0001) Infection intensity by site is significantly different

# Without Severn
CBSMasterScans2 <- CBSMasterScans[CBSMasterScans$Site != "S", ]
hist(CBSMasterScans2$Severity)
qqnorm(CBSMasterScans2$Severity)
qqline(CBSMasterScans2$Severity)
shapiro.test(CBSMasterScans2$Severity)
kruskal.test(Severity ~ Site, data = CBSMasterScans2)
# (p<0.0001) Infection intensity by site is significantly different

sumSev <- summarySE(data = CBSMasterScans2, measurevar = "Severity", groupvars = c("Site"))
# fitSeverity <- aov (Severity ~Site, data = CBSMasterScans2)
# summary(fitSeverity)
# TukeyHSD(fitSeverity)
sumSevQuad <- summarySE(data = CBSMasterScans2, measurevar = "Severity", groupvars = c("Site", "Quadrat"))
WMCSeverity <- wmc(Severity ~Site, data=CBSMasterScans2, method="holm")


#By quadrat
Test2 <- ggplot(CBSMasterScans2, aes(x = Site, y = Quadrat, fill = Severity)) +
    geom_tile(color = "white",
              lwd = 1.5,
              linetype = 1) +
    scale_fill_gradient(low = "#80CAAC",
                       high = "#7E1F14",
                        guide = "colorbar") +
    coord_fixed() +
    guides(fill = guide_colourbar(title = "SWD Lesion Severity"))
Test2

# 3. Environmental Data -------------
LabyTemp <- read.csv("~/Downloads/GradSchool/Thesis Research/CB Surveys/Stats/LabyTemp.csv")
LabyTemp <- LabyTemp[!is.na(LabyTemp$Year),] #get rid of NAs

LabySalinity <- read.csv("~/Downloads/GradSchool/Thesis Research/CB Surveys/Stats/LabySalinity.csv")
LabySalinity <- LabySalinity[!is.na(LabySalinity$Year),] #get rid of NAs

LabyTemp$Site <- as.character(LabyTemp$Site)
LabyTemp$Site[LabyTemp$Site == "Brown's Bay"] <- "Guinea Marsh"
LabyTemp$Site[LabyTemp$Site == "Hungars Creek"] <- "Hungars Creek (North and South)"
LabyTemp$Site <- as.factor(LabyTemp$Site)
LabyTemp$Year <- as.factor(LabyTemp$Year)
LabyTemp$Month <- as.factor(LabyTemp$Month)
LabyTemp$Avg_Temp_C <- as.numeric(LabyTemp$Avg_Temp_C)
LabyTemp$SD_Temp_C <- as.numeric(LabyTemp$SD_Temp_C)
LabyTemp$SE_Temp_C <- as.numeric(LabyTemp$SE_Temp_C)
LabyTemp$Date <- paste(LabyTemp$Year, LabyTemp$Month, sep = "-" )
LabyTemp$Lower <- paste(LabyTemp$Avg_Temp_C - LabyTemp$SD_Temp_C)
LabyTemp$Upper <- paste(LabyTemp$Avg_Temp_C + LabyTemp$SD_Temp_C)

LabySalinity$CBPStation <- as.character(LabySalinity$CBPStation)
LabySalinity$CBPStation[LabySalinity$CBPStation == "WE4.1"] <- "Guinea Marsh and Horn Harbor"
LabySalinity$CBPStation[LabySalinity$CBPStation == "WE4.3"] <- "Poquoson Flats"
LabySalinity$CBPStation[LabySalinity$CBPStation == "CB7.2E"] <- "Hungars Creek (North and South)"
LabySalinity$CBPStation <- as.factor(LabySalinity$CBPStation)
LabySalinity$Year <- as.factor(LabySalinity$Year)
LabySalinity$Month <- as.factor(LabySalinity$Month)
LabySalinity$Salinity <- as.numeric(LabySalinity$Salinity)
LabySalinity$Date <- paste(LabySalinity$Year, LabySalinity$Month, sep = "-" )


## 3.1 Temp -------------

plot3.1.1 <- ggplot() +
    geom_line(data = LabyTemp,
              aes(x = Date,
                  y = Avg_Temp_C,
                  group = Site),
              position = position_dodge(0.9)) +
    geom_ribbon(data = LabyTemp,
                  aes(x = Date,
                      ymin = Avg_Temp_C - SD_Temp_C,
                      ymax = Avg_Temp_C + SD_Temp_C,
                      group = Site),
                  position = position_dodge(0.9),
                alpha = 0.3) +
    geom_point(data = LabyTemp,
               aes(x = Date,
                   y = Avg_Temp_C,
                   color = Site),
               position = position_dodge(0.9)) +
    labs(x = "Date",
         y = "SST (Degrees C)") +
    scale_x_discrete(breaks=c("2016-1","2017-1","2018-1","2019-1","2020-1","2021-1"),
                     labels=c("2016","2017","2018","2019","2020","2021")) +
    theme_classic(base_size = 15)
plot3.1.1

## 3.2 Salinity -------------

plot3.1.2 <- ggplot() +
    geom_line(data = LabySalinity,
              aes(x = Date,
                  y = Salinity,
                  group = CBPStation),
              position = position_dodge(0.9)) +
    geom_point(data = LabySalinity,
               aes(x = Date,
                   y = Salinity,
                   color = CBPStation),
               position = position_dodge(0.9)) +
    labs(x = "Date",
         y = "Salinity (PPT)") +
    scale_x_discrete(breaks=c("2016-1","2017-1","2018-1","2019-1","2020-1","2021-1"),
                     labels=c("2016","2017","2018","2019","2020","2021")) +
    theme_classic(base_size = 15) +
    theme(strip.background = element_blank(),
          strip.placement = "outside",
          axis.text = element_text(color = "black"),
          legend.position = "right")
plot3.1.2











