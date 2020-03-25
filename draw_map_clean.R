# Loading required packages
library(ggplot2)
library(sf)
library(viridis)
library(grid)
library(gridExtra)
library(RColorBrewer)
library(rstudioapi)
library(stringi)

#set path to current folder
current_path = rstudioapi::getActiveDocumentContext()$path 
setwd(dirname(current_path ))

#Population_data_rosstat
#Initial data on 2019 demographics by region was obtained from Rosstat
#https://gks.ru/bgd/regl/b19_111/Main.htm
#and then combined with python script.
#The final table is provided with the repository
###
age_data<-read.csv("rosstat_combined.tsv",
                   stringsAsFactors = FALSE, sep = "\t", header = T)

#IMV data
#Invasive mechanical ventilation (IMV) data was obtained from meduza.io:
#https://meduza.io/feature/2020/03/20/v-italii-iz-za-koronavirusa-katastroficheski-ne-hvataet-apparatov-ivl-v-rossii-ih-gorazdo-bolshe-no-eto-ne-znachit-chto-my-luchshe-gotovy-k-epidemii
#We utilized only data on IMV and ignored ECMO
#As well the data was added from: https://www.hwcompany.ru/blog/expert/nali4ie_apparatov_ivl_na_22_03_2020
#The data is provided in the repository
###
IMV_data<-read.csv("IMV_meduza_impr.csv",
                   stringsAsFactors = FALSE, sep = ",", header = TRUE)

#Mortality rates and hospitalisation
#Data on mortality and hospitalization rates was obtained from Verity et al., 2020, medarxiv
#We modified the rate for the age group 0-9 from 0.0 to 0.001, expecting that there have to be some cases in this age group
#Data on cases requiring critical care obtained from Imperial College COVID-19 Report 9:
#https://www.imperial.ac.uk/media/imperial-college/medicine/sph/ide/gida-fellowships/Imperial-College-COVID19-NPI-modelling-16-03-2020.pdf
Mort.Hosp<-read.csv("mortality_hosp_ICU.tsv",
                    stringsAsFactors = FALSE, sep = "\t", header = TRUE)
##transform from percents and rename rows
Mort.Hosp.tr<-Mort.Hosp[,c(2:10)]*0.01
rownames(Mort.Hosp.tr)<-Mort.Hosp$X

######
#Map of Russian Federation was obtained from GADM:
#https://gadm.org/download_country_v3.html
rus.map <- readRDS("gadm36_RUS_1_sf.rds")
##correcting wrong names in the map
rus.map$NL_NAME_1[rus.map$NL_NAME_1 == "Пермская край"] <- "Пермский край"
rus.map$NL_NAME_1[rus.map$NL_NAME_1 == "Камчатская край"] <- "Камчатский край"
rus.map$NL_NAME_1[rus.map$NL_NAME_1 == "Республика Чечено-Ингушская"] <- "Чеченская республика"
rus.map$NL_NAME_1[rus.map$NL_NAME_1 == "Респу́блика Ингуше́тия"] <- "Республика Ингушетия"
rus.map$NL_NAME_1[rus.map$NL_NAME_1 == "Санкт-Петербург (горсовет)"] <-"г. Санкт-Петербург"
rus.map$NL_NAME_1[is.na(rus.map$NL_NAME_1)] <-"г. Москва"

##
#Transform IMV data
IMV_only_map<-IMV_data[IMV_data$region %in% rus.map$NL_NAME_1,]
IMV_missing_rows<-rus.map$NL_NAME_1[!(rus.map$NL_NAME_1 %in% IMV_data$region)]
rus.map.sub.df<-data.frame(IMV_missing_rows, 
                           rep(NA,length(IMV_missing_rows)), 
                           rep(NA,length(IMV_missing_rows)))
names(rus.map.sub.df)<-c("region","IMV_per1000", "IMVnum")
IMV_data_merged<-rbind(IMV_only_map,rus.map.sub.df)
final_IMV<-IMV_data_merged[match(rus.map$NL_NAME_1, IMV_data_merged$region),]

##############
#From demographics data subset only age infromation (no gender)
age_data_all<-subset(age_data, age_data$gender == "all")
age_data_all_sorted<-age_data_all[match(rus.map$NL_NAME_1, age_data_all$region),]
#Subset only over 80 and calculate portion
age_data_all_o80<-age_data_all_sorted[,c("region","X80.и.старше","sum")]
age_data_all_o80$part<-age_data_all_o80$X80.и.старше*100/age_data_all_o80$sum
#Oldest and highest 
age_over80_top<-age_data_all_o80[order(-age_data_all_o80$part),][c(1:10),c(1,4)]
age_over80_bottom<-age_data_all_o80[order(age_data_all_o80$part),][c(1:10),c(1,4)]
#####Create bins
#Create binned data
age.bins<-c("sum09","sum1019","sum2029","sum3039","sum4049","sum5059","sum6069","sum7079", "sum80")
age.columns<-list(c(3,12),c(13,22),c(23,32),c(33,42),c(43,52),c(53,62),c(63,72),c(73,82))
bins<-c()
for (i in age.columns) 
{
  col<-rowSums(age_data_all_sorted[,c(i[1]:i[2])])
  bins<-cbind(bins,col)
}
bins<-cbind(bins,age_data_all_sorted$X80.и.старше)
colnames(bins)<-age.bins
bins.df<-as.data.frame(bins)

##############
#Calculate mortality
Est.p=0.6 #estimate of affected population
bins.df.mort<-as.data.frame(mapply('*', bins.df, Mort.Hosp.tr[1,]*Est.p))
bins.df.mort$sum<-as.integer(rowSums(bins.df.mort))
bins.df.mort$region<-age_data_all_sorted$region
#
sum(bins.df.mort$sum)
#regions with highest mortality rate
#######
#Calculate hospitalized
bins.df.hosp<-as.data.frame(mapply('*', bins.df, Mort.Hosp.tr[2,]*Est.p))
bins.df.hosp$sum<-as.integer(rowSums(bins.df.hosp))
bins.df.hosp$region<-age_data_all_sorted$region
#Calculate critical
bins.df.critical<-as.data.frame(mapply('*', bins.df.hosp[,c(0:9)], Mort.Hosp.tr[3,]))
bins.df.critical$sum<-as.integer(rowSums(bins.df.critical))
bins.df.critical$region<-age_data_all_sorted$region
bins.df.critical$region_tr<-stri_trans_general(bins.df.critical$region, "russian-latin/bgn")
#percents
bins.df.hosp$percent<-round(bins.df.hosp$sum*100/age_data_all_sorted$sum, digits = 2)
bins.df.critical$percent<-round(bins.df.critical$sum*100/age_data_all_sorted$sum, digits = 2)
bins.df.mort$percent<-round(bins.df.mort$sum*100/age_data_all_sorted$sum, digits = 2)
###
#CalculateIMV
#IMV per 100000 people
final_IMV$IMVper<-final_IMV$IMVnum*100000/age_data_all_sorted$sum
#Critical cases per IMV
final_IMV$PerPerIMV<-round(bins.df.critical$sum/final_IMV$IMVnum, digits =1)

##################
#Final table with data
output_table<-as.data.frame(cbind(region=bins.df.critical$region,region_tr=bins.df.critical$region_tr))
output_table$population.total<-age_data_all_sorted$sum
output_table$over80.perc<-age_data_all_o80$part
output_table$hospitalized.total<-bins.df.hosp$sum
output_table$hospitalized.perc<-bins.df.hosp$percent
output_table$critical.total<-bins.df.critical$sum
output_table$critical.perc<-bins.df.critical$percent
output_table$lethality.total<-bins.df.mort$sum
output_table$lethality.perc<-bins.df.mort$percent
output_table$critical.per.IMV<-final_IMV$PerPerIMV

write.csv(output_table, file = "results.csv", sep = ',')

#################
#Visualisation
#################
lwdp = 0.05
projection =3576 #EPSG code
common = theme_classic()+
  theme(axis.line = element_blank(), 
        axis.text.x = element_blank(), 
        axis.text.y = element_blank(),
        axis.ticks = element_blank(), 
        axis.title.x = element_blank(), 
        axis.title.y = element_blank(),
        legend.position="top",
        legend.text = element_text(size =6),
        legend.title = element_text(size =12),
        legend.key.size = unit(0.4, "cm"))
####
#Plot population by region
pop<-ggplot(data = rus.map) +
  geom_sf(aes(fill=log10(age_data_all_sorted$sum)), lwd = lwdp) + 
  scale_fill_gradient(low="#e5f5f9", high="#006d2c")+#colours=brewer.pal(9,"BuGn"))+
  coord_sf(crs=projection)+ 
  labs(fill = "log10 population") +
  common
###
#Plot percent over 80
perc80<-ggplot(data = rus.map) + 
  geom_sf(aes(fill=age_data_all_o80$part), lwd = lwdp) + 
  scale_fill_viridis(option="B",direction =-1, begin = 0.3) +
  coord_sf(crs=projection)+
  labs(fill = "% of population over 80 y.o.")+
  common
###
#Plot mortality
mort<-ggplot(data = rus.map) + 
  geom_sf(aes(fill=bins.df.mort$sum), lwd = lwdp) + 
  scale_fill_viridis(option="B",direction =-1, begin = 0.3) +
  coord_sf(crs=projection)+
  labs(fill = "Estimated deaths")+
  common +
  theme(legend.position="right")
###
#Plot hospitalisation
hospperc<-ggplot(data = rus.map) + 
  geom_sf(aes(fill=bins.df.hosp$percent), lwd = lwdp) + 
  scale_fill_viridis(option="B",direction =-1, begin = 0.4) +
  coord_sf(crs=projection)+ 
  labs(fill = "Estimated hospitalized cases (%)")+
  common
###
#Plot critical
criticalperc<-ggplot(data = rus.map) + 
  geom_sf(aes(fill=bins.df.critical$percent), lwd = lwdp) + 
  scale_fill_viridis(option="B",direction =-1, begin = 0.6) +
  coord_sf(crs=projection)+ 
  labs(fill = "Estimated critical cases (%)")+
  common
###
#Plot IMV per 100000 people
IMVperp<-ggplot(data = rus.map) + 
  geom_sf(aes(fill=final_IMV$IMVper), lwd = lwdp) + 
  scale_fill_viridis(option="B", direction = -1,begin = 0.3) +
  coord_sf(crs=projection)+
  labs(fill = "IMV per 100000 people")+
  common

###
#Plot critical cases per IMV
PerPerIMV<-ggplot(data = rus.map) + 
  geom_sf(aes(fill=final_IMV$PerPerIMV), lwd = lwdp) + 
  scale_fill_viridis(option="B", direction = -1,begin = 0.3) +
  coord_sf(crs=projection)+
  labs(fill = "Critical cases per one IMV")+
  common
#############################################
#Save plots
dimh<-12
dimw<-20
path<-"Figures"
ggsave("Fig0population.png",plot= pop, path=path, width = dimw, height = dimh, units = "cm")
ggsave("Fig1perc80.png",plot= perc80, path=path, width = dimw, height = dimh, units = "cm")
ggsave("Fig2mortality.png",plot= mort, path=path, width = dimw, height = dimh, units = "cm")
ggsave("Fig3hospitalized.png",plot= hospperc, path=path, width = dimw, height = dimh, units = "cm")
ggsave("Fig4critical.png",plot= criticalperc, path=path, width = dimw, height = dimh, units = "cm")
ggsave("Fig5IMVper100000.png",plot= IMVperp, path=path, width = dimw, height = dimh, units = "cm")
ggsave("Fig6CasesperIMV.png",plot= PerPerIMV, path=path, width = dimw, height = dimh, units = "cm")



















