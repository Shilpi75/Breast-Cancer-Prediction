setwd("/media/shilpi/New Volume/ML/r/breast_cancer");
data=read.csv("breastcancer.csv")
data
str(data)
data.names();
summary(data)


#PRE PROCESSING
data$Clump_Thickness=as.numeric(data$Clump_Thickness)
data$Uniformity_CellSize=as.numeric(data$Uniformity_CellSize)
data$Uniformity_CellShape=as.numeric(data$Uniformity_CellShape)
data$Marginal_Adhesion=as.numeric(data$Marginal_Adhesion)
data$Single_Epithelial_cellSize=as.numeric(data$Single_Epithelial_cellSize)
data$BareNuclei=as.numeric(data$BareNuclei)
data$Bland_Chromatin=as.numeric(data$Bland_Chromatin)
data$Normal_Nucleoli=as.numeric(data$Normal_Nucleoli)
data$Mitoses=as.numeric(data$Mitoses)
data$Class=as.factor(data$Class)


data[is.na(data$Clump_Thickness)]<-mean(data$Clump_Thickness,na.rm=TRUE)
data[is.na(data$Uniformity_CellSize)]<-mean(data$Uniformity_CellSize,na.rm = TRUE)
data[is.na(data$Uniformity_CellShape)]<-mean(data$Uniformity_CellShape,na.rm = TRUE)
data[is.na(data$Marginal_Adhesion)]<-mean(data$Marginal_Adhesion,na.rm = TRUE)
data[is.na(data$Single_Epithelial_cellSize)]<-mean(data$Single_Epithelial_cellSize,na.rm = TRUE)
data[is.na(data$BareNuclei)]<-mean(data$BareNuclei,na.rm = TRUE)
data[is.na(data$Bland_Chromatin)]<-mean(data$Bland_Chromatin,na.rm = TRUE)
data[is.na(data$Normal_Nucleoli)]<-mean(data$Normal_Nucleoli,na.rm = TRUE)
data[is.na(data$Mitoses)]<-mean(data$Mitoses,na.rm = TRUE)

summary(data)

set.seed(100)

malignantdata=subset(data,Class==2)
benigndata=subset(data,Class==4)
str(malignantdata)

k=2;
KMC = kmeans(malignantdata[ ,3:11], centers = k, iter.max = 1000)
KMC$cluster

malignantdata$Class=KMC$cluster
benigndata$Class=3

data<-rbind(malignantdata,benigndata)
data
str(data)
#write.csv(data, file = "BreastCancer2.csv",row.names = TRUE)
data$Class=as.factor(data$Class)
str(data)


library(C50)
library(caTools)

treeModel<-C5.0(x=data[,3:11],y=data$Class)

summary(treeModel)
