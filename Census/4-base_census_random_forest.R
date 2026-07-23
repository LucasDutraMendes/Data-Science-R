

                      #Random Forest
#-------------------------------------------------------------#
#install.packages("randomForest")
library(randomForest)
set.seed(1) #this code gets the same portion of the dataset

classifier <- randomForest(x = training_base[-15], 
                           y = training_base$income, ntree = 15) #training

prediction <- predict(classifier, newdata = test_base[-15]) #predict

matrix_conf <- table(test_base[, 15], prediction)
matrix_conf # random forest score

#install.packages("caret")
library(caret)
confusionMatrix(matrix_conf) # Accuracy : 0.8567    
#-------------------------------------------------------------#