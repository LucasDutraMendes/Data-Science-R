

                  #  Random Forest 
#-------------------------------------------------------------#
#install.packages("randomForest")
library(randomForest)
set.seed(1) #that code creates always the same portion of data
            #allowing us to obtain equal results

classifier <- randomForest(training_base[-4], 
                           y = training_base$default, ntree =  30) #training
classifier

prediction <- predict(classifier, newdata = test_base[-4]) #predict
prediction


matrix_conf <- table(test_base[, 4], prediction)
matrix_conf # random forest score 

#install.packages('caret')
library(caret)
confusionMatrix(matrix_conf) # Accuracy : 0.986         
#-------------------------------------------------------------#