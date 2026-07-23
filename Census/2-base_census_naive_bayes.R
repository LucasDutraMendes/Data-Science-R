
                    #Naive Bayes
#-------------------------------------------------------------#
#install.packages("e1071")
library(e1071)

classifier <- naiveBayes(training_base[-15], training_base$income) #training
classifier

prediction <- predict(classifier, newdata = test_base[-15]) #predict
prediction #scores

matrix_conf <- table(test_base[,15], prediction)
matrix_conf #naive bayes score

#install.packages('caret')
library(caret)
confusionMatrix(matrix_conf) #Accuracy : 0.8286
#-------------------------------------------------------------#