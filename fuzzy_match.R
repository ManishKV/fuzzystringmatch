setwd("YOUR FILES LOCATION")

# Using the native R adist
dataset1<-read.csv('dataset1.csv')
dataset2<-read.csv('dataset2.csv')

# To make sure we are dealing with charts
dataset1$Name_String1<-as.character(dataset1$Name_String1)
dataset2$Name_String2<-as.character(dataset2$Name_String2)

dataset1<- dataset1[order(dataset1$Name_String1),]

# It creates a matrix with the Standard Levenshtein distance between the name fields of both sources
dist_string_mat<-adist(dataset1$Name_String1,dataset2$Name_String2, partial = TRUE, ignore.case = TRUE)

# We now take the pairs with the minimum distance
min_dist_name<-apply(dist_string_mat, 1, min)

fuzzy_string_match<-NULL  
for(i in 1:nrow(dist_string_mat))
{
  dataset2_i<-match(min_dist_name[i],dist_string_mat[i,])
  dataset1_i<-i
  fuzzy_string_match<-rbind(data.frame(dataset1_i=dataset1_i, Name_String1=dataset1[dataset1_i,]$Name_String1, dataset2_i=dataset2_i, Name_String2=dataset2[dataset2_i,]$Name_String2),fuzzy_string_match)
}

fuzzy_string_match<- fuzzy_string_match[order(fuzzy_string_match$dataset1_i),]

# and we then can have a look at the results
View(fuzzy_string_match)

write.csv(dist_string_mat,file="dist_string_mat.csv",row.names = FALSE,na="")