# Clustering example
library(MASS)
library(ggplot2)
library(cluster)

wages<-read.csv('http://inta.gatech.s3.amazonaws.com/wage2.csv')
subwages <-wages[,c("wage","IQ","KWW","educ","age","married")]
################ Modify ###########################################
#using 3 cluster and Nstart 5 we get 79.1% accurecy
cluster_model <- kmeans(subwages,3,nstart=5)
print(cluster_model)

#using 5 cluster and Nstart 20 we get 91.5% accurecy
cluster_model <- kmeans(subwages,5,nstart=20)
print(cluster_model)

cluster_model$centers # For mean of cluster for each colomn
cluster_model$cluster # which row falls in which cluster

#using cluster 3 it exexplain 57.84% variability
clusplot(subwages,cluster_model$cluster,color = TRUE,labels = 2,lines = 0)
subwages$cluster<-as.factor(cluster_model$cluster)

ggplot(data=subwages, aes(x=educ, y=wage)) + geom_point(aes(colour=cluster))  + 
  geom_point(data=data.frame(cluster_model$centers), colour='red', size=7)
ggplot(data=subwages, aes(x=educ, y=IQ)) + geom_point(aes(colour=cluster)) + 
  geom_point(data=data.frame(cluster_model$centers), colour='red', size=7)

# If you want to see these plots with the data points less on top of each other,
# 'geom_jitter' adds soem noise to each point to move them off of each other:
ggplot(data=subwages, aes(x=educ, y=wage)) + geom_jitter(aes(colour=cluster)) + 
  geom_point(data=data.frame(cluster_model$centers), colour='red', size=7)
