

                        #  Naive Bayes 
#-------------------------------------------------------------#
#install.packages('e1071')
library(e1071)

classifier <- naiveBayes(training_base[-4], training_base$default) #training
classifier 

prediction <- predict(classifier, newdata = test_base[-4]) #predict
prediction 

matrix_conf = table(test_base[, 4], prediction)
matrix_conf  #naive bayes score

#install.packages('caret')
library(caret)
confusionMatrix(matrix_conf) #Accuracy : 0.916
#-------------------------------------------------------------#