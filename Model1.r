getwd()
data=read.csv("breastcancer.csv")
data
str(data)
data.names();
summary(data)
fix(data)
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

library(C50)
library(caTools)
split=sample.split(data$Class,SplitRatio = 0.75)
train=subset(data,split==TRUE)
test=subset(data,split==FALSE)
summary(train)
summary(test)

nrow(train)
nrow(test)
str(train)
treeModel<-C5.0(x=train[,3:11],y=train$Class)
summary(treeModel)


test.class=predict(treeModel,test[,3:11])
table(test$Class,test.class)

