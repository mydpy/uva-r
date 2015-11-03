#
#  UVA McIntire Seminar, Presentedby CapTech
#      R Basic Modeling
#    
#  Basic Modeling Techniques: 
#      Exploring datasets using R
#      Visualization techniques
#    
####################################################
#  Exploratory data analysis using R
#
#  Examining R's built-in datasets
#      understanding available data
#      summarizing and tabulating data sets
#

library(help = "datasets")      # view data sets included in Base R
head(iris)                      # Edgar Anderson's Iris Data
head(iris3)                     # why is this view different?
str(iris)                       # structure of iris  dataset
str(iris3)                      # structure of iris3 dataset

?iris                           # get help with the dataset

dim(iris)                       # print dimensions
attributes(iris)                # describe an objects attributes
                                # this function can also set attributes

summary(iris)                   # summarizes the data frame fields

stats::quantile(                # use stats:: to specify which package to use
   iris$Sepal.Length)           # produces sample quantiles corresponding to the given probabilities.
cov(iris[,1:4])                 # variance-covariance matrix

aggregate(  Sepal.Length ~ Species      # formula: response variable ~ explanatory variables
            , base::mean                # specify a function used to aggregate
            , data=iris)                # specify dataset

str(Sepal.Length ~ Species)             # show the formula attributes

aggregate(  Sepal.Length ~ Species
            , summary                   # try a different function
            , data=iris)

####################################################
#  Coffee Break
#
#  Examining Formulas
#      y ~ x
#        think: basic regression formula
#        x is the explanatory variable or independent variable,
#        y is the response variable or dependent variable
#     y ~ x + z
#        think: multiple regression, two predictors
#        WARNING: symbols have new context inside model formulae. 
#          +	+x	include this variable
#          -	-x	delete this variable
#          :	x:z	include the interaction of these variables
#          *	x*z	include these variables and the interactions between them
#          /	x/z	nesting: include z nested within x
#          |	x|z	conditioning: include x given z
#
#         Misc:
#           Error	Error(a/b)	specify the error term
#           I	    I(x*z)	    as is: include a new variable consisting of these variables multiplied
####################################################


#  Visualization techniques
#
#  Examining data using R's built-in/low-level visualization packages
#      plot - everything* is a plot! 
#      
#

plot(iris$Sepal.Length)               # lowest level plot function

hist(iris$Sepal.Length)               # histogram
                                      # try: matplot, boxplot, lines, etc.

plot(density(iris$Sepal.Length))      # plotting the kernal density estimation

plot(  jitter(iris$Sepal.Length)      # jitter makes statistically insignificant
     , jitter(iris$Sepal.Width))      # changes to point values for plotting

#  Visualization with advanced packages
#      scatterplot3d - plots a three dimensional (3D) point cloud
#      lattice       - implementation of Trellis graphics for R
#      ggplot2       - by far the most robust and popular visualization package
#      MASS          - package for modern applied statistics with S
#   

library("scatterplot3d")                         # load the referenced library

shapes = c(21, 22, 23)                           # define a character set
shapes <- shapes[as.numeric(iris$Species)]       # manipulate it for type requirements
scatterplot3d(  iris$Petal.Width                 # create a 3d scatterplot
              , iris$Sepal.Length
              , iris$Sepal.Width
              , pch=shapes)                      # choose symbols from characters

scatterplot3d(  iris[,1:3]                       # select certain frames of the data
              , pch = shapes                   
              , main="3D Scatter Plot")          # give the plot a title

colors <- c("navy", "chocolate2", "snow1")       # define a color set
colors <- colors[as.numeric(iris$Species)]
scatterplot3d(  iris[,1:3], pch = 21
              , color="black"                    # give the points a black outline
              , bg=colors                        # apply our colors to the plot
              , grid=TRUE                        # keep the z plane grid
              , box=FALSE                        # turn off the box surrounding the plot
              , main='GO HOOS')                      

library(lattice)
levelplot(Petal.Width~Sepal.Length*Sepal.Width   # formula for generating shingles
          , iris
          , cuts=2                               # devide z into 2 levels
          , col.regions=colors
          )

library(MASS) 
parcoord(iris[1:4], col=iris$Species)            # parallel coordinates plot

library(ggplot2)                                 # ggplot2: everything you ever wanted

qplot(  Sepal.Length                             # quick plot designed to act like plot()
      , Petal.Length
      , data = iris
      , color = Species)

qplot(  Sepal.Length
      , Sepal.Width
      , data=iris
      , facets=Species ~.)                       # tell ggplot to create facets for each specicies (faceting formula)

qplot(  Sepal.Length
      , Petal.Length
      , data = iris
      , color = Species                          # color by data.frame value
      , size = Petal.Width                       # size by data.frame value
      , alpha = I(0.7))                          # adding graphics properties

ggplot(  data = iris
       , aes(Sepal.Length, Sepal.Width)) +       # aes = aesthetic mapping between x, y
         geom_point(aes(colour = (Species))) +   # point geometry for scatter plots
         geom_smooth(method = "lm")              # try: loess

ggplot(  data = iris
       , aes(Sepal.Length, Sepal.Width)) +
         geom_point() +                          # adding qualities to the aesthetic mapping
         facet_grid(. ~ Species) +               # adding a facet grid (think qplot)
         geom_smooth(method = "loess")           # smoothing algorithm



