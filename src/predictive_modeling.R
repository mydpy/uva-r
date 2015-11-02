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
class(raw.wine.quality)           # show the class type 

####################################################
#  Partition data into training and test data
#   

set.seed(1234)                          # set random number generator seed to recreate results

ind = base::sample(2                    # index data set by sampling
                    , nrow(raw.wine.quality)        
                    , replace=TRUE      # sample with replacement or not
                    , prob=c(0.7, 0.3)) # ratio of train/test

wine.train = raw.wine.quality[ind==1,]  # create training data set
wine.test  = raw.wine.quality[ind==2,]  # create testing  data set

####################################################
#  configure environment
#  
e.tree = new.env()                      # technical note: demonstrates R's powerful  
                                        # yet complex notion of lexical scoping
                                        # see: http://adv-r.had.co.nz/Environments.html
####################################################
#  Building a decision tree  
#  

library(party)
setClass(Class="BinaryTreeModel",       # creating a class to hold general tree properties
         representation(       
           tree.model="BinaryTree",     # formula is object.property.name = "class_type"
           tree.results="factor",       # use class(object_name) when creating classes
           tree.formula="formula",      # each tree has a model, results, formula used
           tree.predict="factor"        # to create the tree, and a prediction
         )
)

build_tree = function(tree.formula, tree.train, tree.test, env=e){
    .model = party::ctree(tree.formula, data=tree.train)
                                        # pass in the tree formula and the data ?ctree
    .formula = tree.formula             # write the formula so we can recreate results
    .results = predict(.model, data = tree.train)   # predict invokes BinaryTree fitting functions
    .predict = predict(.model, newdata = tree.test) # run for both train and test data
    return (new( "BinaryTreeModel",     # return the class object of the trees we just modeled
                 tree.model=.model,
                 tree.results=.results,
                 tree.formula=.formula,
                 tree.predict=.predict))
}

quality.formula.full = quality ~ fixed.acidity + volatile.acidity + 
                       citric.acid + residual.sugar + chlorides + 
                       free.sulfur.dioxide + total.sulfur.dioxide + 
                       density + pH + sulphates + alcohol

quality.formula.small = quality ~ alcohol           # compare the full and simple model

wine.model.small <<- build_tree(quality.formula.small, wine.train, wine.test, e.tree)
wine.model.full <<-  build_tree(quality.formula.full, wine.train, wine.test, e.tree)
                                        # build a tree for each formula. Pass in the
                                        # formula, training set, test set, and environment

####################################################
#  Visualizing a decision tree
#  

print(wine.model.small@tree.model)      # print the model parameters for small tree
print(wine.model.full@tree.model)       # print the model parameters for complex tree

jpeg('figs/wine-model-small.jpg', width=800 , height=400)  # save figure to our local machine
 plot(wine.model.small@tree.model)                         # plot the small tree model
dev.off()                                                  # tell R we're done modifying the plot

jpeg('figs/wine-model-small-simple.jpg', width=800 , height=400)
 plot(wine.model.small@tree.model, type="simple")          # plot the simple small tree model
dev.off()

jpeg('figs/wine-model-full.jpg', width=2400 , height=1200)
plot(wine.model.full@tree.model)                           # plot the full tree model
dev.off()

jpeg('figs/wine-model-full-simple.jpg', width=2400 , height=1200)
plot(wine.model.full@tree.model, type="simple")            # plot the simple full tree model
dev.off()


####################################################
#  Evaluating a decision tree
#  

table(wine.model.small@tree.results, wine.train$quality
                       , leg=c("Predicted", "Actual"))   # print the confusion matrix
table(wine.model.small@tree.predict, wine.test$quality   # for the results and prediction
                       , leg=c("Predicted", "Actual"))   # against the actual results
                                                         # perfect case: main diagonal 
                                                         # contains all values

wine.predict = predict(wine.ctree, newdata = wine.test)
wine.test.table = table(wine.predict, wine.test$quality)

                                                         # Decision Tree Metrics
                                                         # overall accuracy
                                                         # precision
                                                         # recall

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




