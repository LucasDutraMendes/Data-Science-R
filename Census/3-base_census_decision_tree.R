
                       #Decision Tree
#-------------------------------------------------------------#
#install.packages("rpart")
library(rpart)
classifier <- rpart(formula = income ~. , data = training_base) #training
classifier

#install.packages("rpart.plot")
library(rpart.plot)
rpart.plot(classifier) # plotting the tree

predict <- predict(classifier, newdata = test_base[-15], type = 'class') #predict
predict

matrix_conf <- table(test_base[, 15], predict)
matrix_conf # decision tree score

library(caret)
confusionMatrix(matrix_conf) #Accuracy : 0.8458          
#-------------------------------------------------------------#

                          #Prune
#-------------------------------------------------------------#
#it's a small project, so the prune have effects here
#but if we wanted, we could apply a prune using the code below
trim = classifier$cptable[which.min(classifier$cptable[, "xerror"]), "CP"]
classifier$cptable
prune(classifier, trim)
classifier
#-------------------------------------------------------------#