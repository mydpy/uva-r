#
#  UVA McIntire Seminar, Presentedby CapTech
#      R Predictive Modeling
#    
#  Predictive Modeling Techniques: 
#      Building a decision tree
#      Vector     (1-dimensional array)
#      Vector     (1-dimensional array)
#      Random-forest models
#      Advanced visualization libraries
#    
####################################################
#  Basic Structures 
#
#  Vectors
#      Create vectors using one of 4 methods
#      :, c(), seq(), rep()

x=-7:7                     # a vector from [a,b]
c(-7:-1,0:7)               # c() combines a list of elements  
seq(-7,7,1)                # seq() creates a sequence [a,b] by c
rep(c(-7:-1,0:7),each=1)   # repeats each combination once

x                          # display x
x[1:7]                     # display elements a:b of x
x[c(7,1,7,1)]              # elements 7, 1, 7, and 1 again
x[c(6, 3, 6, 1)]           # elements 6, 3, 6, and 1 
x[-1:-7]                   # exclude elements 1:7

x+7                        # add to each element
x*2                        # multiply each element
x^2                        # power function each element
(x+7)*2                    # combine operations using PEMDAS precedence 

#
#  Matrices [i,j]
#      i - row number
#      j - column number
#      matrices are stored column-wise by default

matrix((-7:7)[-8], nrow = 2, ncol = 7)               # a 2 x 7 matrix
matrix((-7:7)[-8], nrow = 2, ncol = 7, byrow=TRUE)   # data populated by row

m = rbind(-7:-1, 1:7)                                # row-bind pastes vectors as rows
m                                                    # print entire matrix
m[1,] ; m[,1]                                        # print first row, then first column
m[-1,]; m[,-1]                                       # exclude first row/column

m[-1,] = 8                                           # assign to 8 all but first row

#  Arrays [x1,x2,...,xn]
#      an array is an n-dimensional generalization of a matrix 

a = array(-7:7, dim = c(3, 5, 2))    # 3 x 5 x 2 array of with repeated values
a
a[1,,1]                              # list array contents like a vector or matrix

#  Advanced Structures 
#
#  Lists
#      a list is an ordered collection of objects known as "components"
#      most flexible object type in R
#      syntax:  list(name1 = object1, name2 = object2, ...)

list1 = list(pi, x=-7:7, title="Oh, the Places You'll Go!", 
             TRUE, matrix(0, 2, 2))
list1                # display list1
list1[[2]]           # display the second component of the list 
list1[[2]][7]        # display the seventh element of the second component 
list1$x              # display the component named x

names(list1)         # print component names of list1
length(list1)        # number of componenets in list1

#  Data Frames 
#
#      combines the best of matrices and lists
#      columns can have different data types (integers and chars)
#      usually labeled with schema (think like a .csv file or a database)
#      syntax:  data.frame(col1, col2, ... , row.names = NULL, ...)

#      data source: https://collegescorecard.ed.gov
name=c("College of William & Mary", "University of Virginia", "Massachusetts Institute of Technology", "Standford")
state=c("VA", "VA", "MA", "CA")
city=c("Williamsburg","Charlottesville", "Cambridge","Stanford")
annual.tuition=c(24377,17149,15713,21816)
graduation.rate=c(.90, .93, .95, .93)
salary.after.graduating=c(56400,58600,80900,91600)

universities = data.frame(name, state, city, annual.tuition,graduation.rate,salary.after.graduating) 
universities                        # display university data from collegescorecard.ed.gov

nrow(universities)                  # number of universities
ncol(universities)                  # number of variables 
head(universities, n=2)             # display header
str(universities)                   # display structure of d
summary(universities)               # display summary of d
universities[1, 1]                  # print universities
universities[2, ]                   # print UVA data
universities[[3]]                   # print cities 
universities[["city"]]              # print cities
universities[ , 3]                  # print cities
universities$city                   # print cities

mean(c(universities[2, "graduation.rate"],d[1, "graduation.rate"]))
universities[universities$state == "VA", ]    

