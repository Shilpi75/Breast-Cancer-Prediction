import numpy as np
import pandas as pd
import sklearn.cross_validation
import sklearn.grid_search
import sklearn.metrics
import sklearn.neighbors
import sklearn.decomposition
import sklearn
import sklearn.datasets
import random 
from sklearn.metrics import confusion_matrix

df = pd.read_csv("/media/shilpi/New Volume/ML/r/breast_cancer/BreastCancer4.csv")


print df.describe()

X = df.iloc[0:699,3:12]
print X
Y = df.iloc[0:699,-1:]
print X.describe()
print Y.describe()



X_train, X_test, Y_train, Y_test = sklearn.cross_validation.train_test_split(X,Y,test_size=0.25,random_state=90)

print X_train


print Y_train.shape

print Y_train

fuzzy = True
m = 7
num_train = len(X_train)
num_test  = len(X_test)

print num_test
print num_train

temp = np.zeros((len(Y_train),3))

for i in range(0,len(X_train)):
    if Y_train.iloc[i,0]==1:
        temp[i,0] = 1
        temp[i,1] = 0
        temp[i,2] = 0
    elif Y_train.iloc[i,0]==2:
        temp[i,0] = 0
        temp[i,1] = 1
        temp[i,2] = 0
    else:
        temp[i,0] = 0
        temp[i,1] = 0
        temp[i,2] = 1
        
labels = temp

predicted = np.ones((num_test, 1));
print predicted.shape

membership = np.zeros((num_test,3))

X_train = X_train.values
X_test = X_test.values
Y_train = Y_train.values
Y_test = Y_test.values

print X_train.shape

k = 10



X_train = X_train.astype(int)
X_test = X_test.astype(int)
Y_train = Y_train.astype(int)
Y_test = Y_test.astype(int)


print X_test
print Y_test

for i in range(0,num_test):
    #Calculating distance of each training point from test point test[i,:]
    distances = (np.tile(X_test[i,:], (num_train,1))-X_train)
    #Calculating Square of the distances
    squares = np.power(distances,2)
    #Taking Sum of the squares row wise
    sum_array = np.sum(squares,axis = 1)
    #Convert sum_array to float for power function in upcoming steps
    sum_array = sum_array.astype(float)
    #Sorting the sum_array. This returns the array indices in the sorted sum_array
    indices = np.argsort(sum_array)
    #Taking 1st k indices for knn
    neighbor_index = indices[ 0:k , ]
    #Allocate space for weight matrix
    weight = np.ones(len(neighbor_index));
    #Calculate weight of each k nearest neighbor
    #Weight is actually the inverse of the distance value. Higher the distance,Lower the weight
    #Here m is taken to be 2
    #Since sum instances are repeating, their distance from the test input will be zero, And hence sum would be zero
    #Taking inverse of it will return infinite weight
    #Therefore we assign their weight to be 1
    for x in range(0,len(neighbor_index)):
        if sum_array[neighbor_index[x]]== 0 :
             weight[x]=1   
        else: 
            weight[x] = np.power(sum_array[neighbor_index[x]], -1/(m-1))
            
    #bening and malignant memberships    
    benign_mem = 0.0;
    malig1_mem = 0.0;
    malig2_mem = 0.0; 
      
    for y in range(0,len(neighbor_index)):
        benign_mem = benign_mem + weight[y]*temp[neighbor_index[y],2]
        malig1_mem = malig1_mem + weight[y]*temp[neighbor_index[y],0]
        malig2_mem = malig2_mem + weight[y]*temp[neighbor_index[y],1]

        
        
    benign_mem = benign_mem/(np.sum(weight))    
    malig1_mem = malig1_mem/np.sum(weight)
    malig2_mem = malig2_mem/np.sum(weight)
    
    if benign_mem >= malig1_mem and benign_mem >= malig2_mem:
        predicted[i,0] = 3
    elif (malig1_mem >= benign_mem and malig1_mem >= malig2_mem):
        predicted[i,0] = 1
    elif malig2_mem >= benign_mem and malig2_mem >= malig1_mem :
		predicted[i,0] = 2

		
    membership[i,0] = malig1_mem
    membership[i,1] = malig2_mem
    membership[i,2] = benign_mem
    
    print membership[i, : ]
    
    
print predicted	
predicted = predicted.astype(int)



accuracy = predicted == Y_test

count = 0.0
for i in range(0,len(accuracy)):
    if accuracy[i] :
        count = count + 1;
print count/num_test  

r= confusion_matrix(Y_test, predicted)
print r

print "REDUCED CONFUSION MATRIX: "
#m = [[0 for x in range(2)] for y in range(2)]
m = np.zeros((2,2))
m[0][0]=r[0][0]+r[0][1]+r[1][0]+r[1][1]
m[0][1]=r[0][2]+r[1][2]
m[1][0]=r[2][0]+r[2][1]
m[1][1]=r[2][2]
print m
print "Accuracy: "
print ((m[0][0]+m[1][1])/(m[0][0]+m[1][0]+m[0][1]+m[1][1]))




            
            







