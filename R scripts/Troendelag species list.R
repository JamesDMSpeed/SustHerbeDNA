#Sust Herb vegetation data

library(Taxonstand)
library(taxize)
#Read from box

sustherbveg_url<-'https://ntnu.box.com/shared/static/zrwchyp1sba9pqubbf47eyc3z2pvp3xg.txt'
download.file(sustherbveg_url,'VegetationData/SustHerbVegetation.txt')
sustherbveg<-read.table('VegetationData/SustHerbVegetation.txt',header=T,sep='\t')
str(sustherbveg)

#Find species list in Trøndelag
trondveg<-sustherbveg[grepl('Trøndelag',sustherbveg$locality),]
trondveg<-droplevels(trondveg)

levels(sustherbveg$scientificName)
levels(droplevels(trondveg$scientificName))

#Convert date to date format
trondveg$eventDate<-as.Date(as.character(trondveg$eventDate),tryFormats = c('%d.%m.%Y'))
range(trondveg$eventDate)

# Species list ------------------------------------------------------------
#List of Trøndelag species
splist<-levels(droplevels(trondveg$scientificName))


#Check these
splist_resolved<-gnr_resolve(splist,best_match_only = T)
splist_resolved
attributes(splist_resolved)$not_known#Species not found (not species)

#Get classes
spclasses<-tax_name(splist_resolved$matched_name,get=c("class"),db='ncbi')

write.csv(spclasses,'VegetationData/SpeciesfromTroendelag.csv')

