

                    #  Decision Tree 
#-------------------------------------------------------------#
#install.packages("rpart")
library(rpart)
classifier <- rpart(formula = default ~ ., data = training_base) #training
classifier 

#install.packages("rpart.plot")
library(rpart.plot)

rpart.plot(classifier) # Plotting the decision tree

prediction <- predict(classifier, newdata = test_base[-4], type = 'class')
prediction

matrix_conf <- table(test_base[, 4], prediction)
matrix_conf # decision tree score

#install.packages('caret')
library(caret)
confusionMatrix(matrix_conf) # Accuracy : 0.97 
#-------------------------------------------------------------#