# Breast-Cancer-Prediction
Breast Cancer Prediction using fuzzy clustering and classification

# Objective
The objective of these predictions is to assign patients to either a benign group that is noncancerous or a malignant group that is cancerous.

# Dataset
The experimental study is based on the Wisconsin Breast Cancer database from the UC Irvine Machine Learning Repository. [Dataset Link](https://archive.ics.uci.edu/ml/datasets/breast+cancer+wisconsin+(original))

The Breast Cancer database was obtained from the University of Wisconsin Hospitals, Madison from Dr. William H. Wolberg. It contains 699 instances, 458 (65.5%) benign and 241 (34.5%) malignant cases. Each case is characterized by 9 attributes as described by Table I and two classes (benign and malignant).

Attributes and domains are as follows: <br>
1. Clump Thickness:  1 – 10 <br>
2. Uniformity of Cell Size:  1 – 10 <br>
3. Uniformity of Cell shape:  1 – 10<br>
4. Marginal Adhesion:  1 – 10<br>
5. Single Epithelial Cell Size:  1 – 10<br>
6. Bare Nuclei:  1 – 10<br>
7. Bland Chromatin:  1 – 10<br>
8. Normal Nucleoli:  1 – 10<br>
9. Mitoses: 1 – 10<br>

# Accuracy Comparison of various models
<b>C4.5 Classifier</b>: 89.6%<br>
<b>KNN Classifier</b>: 95.4%<br>
<b>K means Clustering and C4.5 decision tree classifier</b>: 95.1%<br>
<b>Fuzzy K means clustering and C4.5 decision tree classifier</b>: 96.5%<br>
<b>K means Clustering and Fuzzy knn classifier:</b> 93.7%<br>
<b>Fuzzy K means Clustering and Fuzzy knn  Classifier</b>: 93.7%<br>
<b>Fuzzy K means Clustering and Fuzzy knn Classifier with feature selection (Final Model) </b>: 96.5%<br>


