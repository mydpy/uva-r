#
#  UVA McIntire Seminar, Presentedby CapTech
#      R Predictive Modeling
#    
#  Predictive Modeling Techniques: 
#      Loading an external dataset
#      Building a decision tree
#      Visualizing a decision tree
#      Evaluating a decision tree
#      Random-forest models
#      Advanced visualization libraries
#    
####################################################
#  Loading an external data set  
#
#  Load a csv file using the csv function
#   

csv.wine.quality = read.csv("resources/WineQuality-White.csv")
raw.wine.quality = read.csv("resources/WineQuality-White.csv"
                            , header = TRUE
                            , sep = ","
                            , quote = '"'
                            , strip.white = TRUE) 
all.equal( csv.wine.quality
          ,raw.wine.quality)      # show loading works each time
str(raw.wine.quality)             # examine dataset
summary(raw.wine.quality)
names(raw.wine.quality)
class(raw.wine.quality)

####################################################
#  Partition data into training and test data
#   

set.seed(1234)                          # set random number generator seed to recreate results

ind = base::sample(2                    # sample data set
                    , nrow(raw.wine.quality)        
                    , replace=TRUE      # sample with replacement or not
                    , prob=c(0.7, 0.3)) # ratio of train/test

wine.train = iris[ind==1,]              # create training data set
wine.test  = iris[ind==2,]              # create testing  data set

####################################################
#  Building a decision tree  
#  

# ind = base::sample(2, nrow(iris)        # sample data set
#                     , replace=TRUE      # sample with replacement or not
#                     , prob=c(0.7, 0.3)) # ratio of train/test
# trainData <- iris[ind==1,]
# testData <- iris[ind==2,]
# 
# library(party)
# myFormula <- Species ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width
# iris_ctree <- ctree(myFormula, data=trainData)
# table(predict(iris_ctree), trainData$Species)
# print(iris_ctree)
# plot(iris_ctree)
# plot(iris_ctree, type="simple")
# 
# testPred <- predict(iris_ctree, newdata = testData)
# table(testPred, testData$Species)
# 
# #using RPart
# set.seed(1234)
# ind <- sample(2, nrow(bodyfat), replace=TRUE, prob=c(0.7, 0.3))
# bodyfat.train <- bodyfat[ind==1,]
# bodyfat.test <- bodyfat[ind==2,]
# # train a decision tree 
# library(rpart)
# myFormula <- DEXfat ~ age + waistcirc + hipcirc + elbowbreadth + kneebreadth
# bodyfat_rpart <- rpart(myFormula, data = bodyfat.train,control = rpart.control(minsplit = 10))
# attributes(bodyfat_rpart)
# print(bodyfat_rpart$cptable)
# print(bodyfat_rpart)
# plot(bodyfat_rpart)
# text(bodyfat_rpart, use.n=T)
# opt <- which.min(bodyfat_rpart$cptable[,"xerror"])
# cp <- bodyfat_rpart$cptable[opt, "CP"]
# bodyfat_prune <- prune(bodyfat_rpart, cp = cp)
# print(bodyfat_prune)
# plot(bodyfat_prune)
# text(bodyfat_prune, use.n=T)
# 
# DEXfat_pred <- predict(bodyfat_prune, newdata=bodyfat.test)
# xlim <- range(bodyfat$DEXfat)
# plot(DEXfat_pred ~ DEXfat, data=bodyfat.test, xlab="Observed", ylab="Predicted", ylim=xlim, xlim=xlim)
# abline(a=0, b=1)
# 
# 
# #  Section Name 
# #
# #  Topic 1
# #      Information
# #   
# 
# ind <- sample(2, nrow(iris), replace=TRUE, prob=c(0.7, 0.3))
# trainData <- iris[ind==1,]
# testData <- iris[ind==2,]
# library(randomForest)
# rf <- randomForest(Species ~ ., data=trainData, ntree=100, proximity=TRUE)
# table(predict(rf), trainData$Species)
# print(rf)
# attributes(rf)
# plot(rf)
# importance(rf)
# varImpPlot(rf)
# irisPred <- predict(rf, newdata=testData)
# table(irisPred, testData$Species)
# plot(margin(rf, testData$Species))




