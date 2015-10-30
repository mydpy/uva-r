#
#  UVA McIntire Seminar, Presentedby CapTech
#      R Functions
#      Materials modifed from Learning Base R by Larry Leemis @2015
#    
#  Introduction to built-in functions
#  Introduction to probability distributions
#  Introduction to user-defined functions
#    
####################################################
#  Introduction to built-in functions 
#      So many more that aren't mentioned!
#

x = seq(-2*pi, 2*pi, pi/4)  # remember this? uh-oh
sum(x); mean(x); median(x)
sd(x);  var(x)              # sample std.dev, variance
cumprod(x)                  # cumulative product
range(x)[1] <= range(x)[2]  # range 

var(cos(x), sin(x))         # sample covariance between a and b
var(sin(x),cos(x))==cov(cos(x),sin(x))
cor(cos(x), sin(x))         # sample correlation between a and b
cor(-1:0, 0:1)
cor(0:-1, 0:1)

sort(x, decreasing = TRUE)   # sort into descending order

#  Introduction to probability distributions
#
#      Functions for probability distributions
#   .- d, p, q, r - use ?rnorm for more information
#   |
#   |   Probability distributions
#   '----> norm unif beta weib exp binom chisq ...

pnorm(1.64)                         # cdf at x = 1.64 for X ~ N(0, 1)
qnorm(.95)                          # returns the 
plot(function(x) dnorm(x), -2, 2)   # pdf at x in [-2,2] for X ~ N(0, 1)
plot(sort(rnorm(50)),type='l')      # generates 50 pseudo-random variates from X ~ N(0, 1)

require(tigerstats)                                             # library for teaching stats concepts
pnormGC(1.645, region="below", mean=0,sd=1,graph=TRUE)          # show lower-tail probabilities
pnormGC(c(-1.96,1.96),region="between",mean=0,sd=1,graph=TRUE)  # show 1-alpha/2 probabilities

#  Introduction to user-defined functions
#
#  Functions
#      typing the function name shows implementation
#      user-defined functions are defined by assigning
#        the function definition to an object. Keyword
#        function identifies the function and return shows
#        return type 

sd                                # prints the implementation of sd

pet.genie <- function(null){      # no arguments
  rv = runif(1, min=0, max=1)     # generates rv from X ~ unif(0,1)
  if(rv < .5)         
    return ('kitten')             # if instance of rv less than .50
  else if (rv < .95)
    return ('puppy')              # if instance of rv between [.5, .95)
  else
    return ('gerbil')             # else
}

pets = lapply(1:100, pet.genie)   # applies function pet.genie to 
                                  # each element in 1:100 vector -> list
str(pets)                         # uh-oh - a list of 100 elements!
pets.v = unlist(pets)             # convert the list into a vector
table(pets.v)                     # summarize pets.v in a table
plot(table(pets.v))               # plot the table summary