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
#  Define forumlas for our tree(s)
#   

quality.formula.full = quality ~ fixed.acidity + volatile.acidity + 
  citric.acid + residual.sugar + chlorides + 
  free.sulfur.dioxide + total.sulfur.dioxide + 
  density + pH + sulphates + alcohol

quality.formula.small = quality ~ alcohol           # compare the full and simple model

####################################################
#  configure environment
#  
rm(e.tree)
e.tree = new.env()                      # technical note: demonstrates R's powerful  
                                        # yet complex notion of lexical scoping
                                        # see: http://adv-r.had.co.nz/Environments.html
####################################################
#  Building a decision tree with conditional inference
#  

library(party)

# Conditional inference trees estimate a regression relationship by binary recursive partitioning 
# in a conditional inference framework. Roughly, the algorithm works as follows: 1) Test the global
# null hypothesis of independence between any of the input variables and the response 
# (which may be multivariate as well). Stop if this hypothesis cannot be rejected. 
# Otherwise select the input variable with strongest association to the resonse. 
# This association is measured by a p-value corresponding to a test for the partial null 
# hypothesis of a single input variable and the response. 2) Implement a binary split in the 
# selected input variable. 3) Recursively repeate steps 1) and 2).

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
                       , dnn=c("Predicted", "Actual"))   # print the confusion matrix
table(wine.model.small@tree.predict, wine.test$quality   # for the results and prediction
                       , dnn=c("Predicted", "Actual"))   # against the actual results
                                                         # perfect case: main diagonal 
                                                         # contains all values

tree_accuracy = function(prediction, actual){            # write a function
  return(sum(actual==prediction)/length(prediction))     # for the tree accuracy metric
}

tree_accuracy(wine.model.small@tree.results,wine.train$quality)  # accuracy for training of small tree
tree_accuracy(wine.model.small@tree.predict,wine.test$quality)   # accuracy for testing of small tree

tree_accuracy(wine.model.full@tree.results,wine.train$quality)   # accuracy for training of full tree
tree_accuracy(wine.model.full@tree.predict,wine.test$quality)    # accuracy for testing of full tree

####################################################
#  Building and pruning a Decision Tree using RPart
#  

library(rpart)

wine.full.rpart = rpart(quality.formula.full,                    # Fit an rpart model to the formula
                         data = wine.train,                      # which data to use
                         control = rpart.control(minsplit = 50)) # configuration parameters. minsplit is the number 
# of observations that must exist in a node in order 
# for a split to be attempted.
# See ?rpart.control 

print(wine.full.rpart)                                           # print the levels of the tree
attributes(wine.full.rpart)                                      # attributes of the tree model created by rpart
print(wine.full.rpart$cptable)                                   # a matrix of information on the optimal prunings based on a complexity parameter.
plot(wine.full.rpart)                                            # plot the tree  
text(wine.full.rpart, use.n=T)                                   # add text (this method is low-level and fuzzy)

opt <- which.min(wine.full.rpart$cptable[,"xerror"])             # returns the index of minimum element                      
cp <- wine.full.rpart$cptable[opt, "CP"]                         # returns the complexity parameter for minimum index (to prune)         
wine.full.rpart.prune <- prune(wine.full.rpart, cp = cp)         # find a nested sequence of subtrees by recursively snipping off the least important splits based on (cp).                
print(wine.full.rpart.prune)                                     
plot(wine.full.rpart.prune)                                      
text(wine.full.rpart.prune, use.n=T)                                  
wine.full.rpart.prune.predict <- 
         predict(wine.full.rpart.prune, newdata=wine.test)       # calculate predictions on the pruned tree  
wine.full.rpart.predict <- 
  predict(wine.full.rpart, newdata=wine.test)                    # calculate predictions on the pruned tree     
table(wine.full.rpart.predict[,1],wine.test$quality)             # display the prediction results by cp
table(wine.full.rpart.prune.predict[,1],wine.test$quality)     

####################################################
#  Random-forest models using RandomForest
#    randomly assigned a bootstrapped sample of the training
#    data to multiple trees, and determine summary statistics
#    for the 'forest' you create -> ensemble classifier. 

library(randomForest)

# randomForest implements Breiman's random forest algorithm 
# for classification and regression.


wine.full.rf <<- randomForest(quality.formula.full,    # formula to use when creating trees   
                              data=wine.train,         # pass it the training data
                              ntree=100,               # size of the forest
                              proximity=TRUE)          # include row proximity in cp metrics

print(wine.full.rf)                                    # show the forest
attributes(wine.full.rf)                               # show the forest object attributes
table(predict(wine.full.rf), wine.train$quality)       # confusion matrix for the full forest with training data

plot(wine.full.rf)                                     # plot the error by tree in forest

importance(wine.full.rf)                               # display the importance of each facet (Gini impurity score)
varImpPlot(wine.full.rf)                               # plot the importance matrix


wine.full.rf.predict <- predict(wine.full.rf,          # predict using the forest on the test data
                                newdata=wine.test)
table(wine.full.rf.predict, wine.test$quality)         # display the results
plot(margin(wine.full.rf, wine.test$quality))          # plot the error margin for the prediction results




