#Sust Herb vegetation data

library(Taxonstand)
library(taxize)
#Read from box

sustherbveg_url<-'https://ntnu.box.com/shared/static/zrwchyp1sba9pqubbf47eyc3z2pvp3xg.txt'
download.file(sustherbveg_url,'VegetationData/SustHerbVegetation.txt')
sustherbveg<-read.table('VegetationData/SustHerbVegetation.txt',header=T,sep='\t')


str(sustherbveg)
#Find species list in Trøndelag
pmatfun<-function(x, table) pmatch(x, table, nomatch = 0) >0
trondveg<-sustherbveg[grepl('Trøndelag',sustherbveg$locality),]
trondveg

levels(sustherbveg$scientificName)
levels(droplevels(trondveg$scientificName))

#List of Trøndelag species
splist<-levels(droplevels(trondveg$scientificName))

#Check these
splist_resolved<-gnr_resolve(splist,best_match_only = T)
splist_checked<-splist

#Get classes
tax_name(splist_resolved$matched_name,get=c("class"),db='ncbi')

