
library(tidyverse)
library(ggplot2)
library(gapminder)



## The assignment operator 
# assign the value 1 to a.
# a gets the value 1
a <- 1
a
a <- 1 + 2
a



## Objects

objects(); a <- 1+2; x
objects()
rm(x); objects()


# Inf` is a special number.

1/Inf
Inf/Inf


#  Objects in R have attributes like `names()`, `length()`, and `class()`, `dimnames()` (for a matrix, array or data frame).

a1 <- 12; class(a1); length(a1)
names(a1) <- 'Number'; names(a1)



## The *pass-by-value* and *pass-by-reference* in R
# By default, R uses "pass-by-value" paradigm. Consider the following example;

x <- 1:10
x*2
x
# or consider
y <- x
x*3
y





# Implicit Coercion occurs when we try to combine objects of two or more different classes. The ordering is roughly **LINCL** i.e `logical < integer < numeric < complex < character<list`.

x <- c(1.7, "a"); class(x)
y <- c(TRUE, 2);class(y)
z <- c("a", TRUE);class(z)



## {.smaller}

# We can explicitly coerce objects by using `as.*()` functions.

x <- c(0,1,2,3,4,5,6)
class(x)
as.character(x)
as.complex(x)
as.logical(x)


#  Nonsensical coercion result in `NA`s. `NA` stands for Not Available.

x <- c("my", "name ", "is", "khan!")
as.numeric(x)
as.complex(x)
as.logical(x)




## Your turn

#- Create an integer vector that contains numbers 1 to 5 and assign it to `n`.
#- Check the class of `n` and convert it to a character vector. Call it `n_c`.


## Operations on Matrices
# Matrices are vectors with `dimension()` attribute.

m <- matrix(1:10, nrow = 2, ncol = 5)
m
dim(m)
length(m)
class(m)




## Subsetting a matrix
# Subsetting a matrix with `[` will subset objects of the same class

x <- matrix(1:10, 2, 5); x
x[1,2]
x[2,5]
x[,2]
x[2,]
x[,1:3] # subset the first 3 columns of the matrix
x[,c(2,4)] # subset the second and fourth columns
x[1,c(2,4)] # subset the 1st row and second + fourth columns
diag(x) # this works only for a square matrix
t(x) # matrix transpose



## Your turn
#- Create a 10X6 matrix with numbers between -30 and 30 (excluding 0). (Hint: Use vector subsetting.)
#- Extract the first and second elements from the fourth row. 
#- Extract the second and fifth elements from the second row




#  We can create factors using the information in the previous table:
 
(Names <- c("Kunal", "Ben", "Kritika", "Reena", "Narendra", "Smriti"))
(Gender <- factor(c("Male", "Male", "Female", "Female", "Male", "Female")))
(Month.Birth <- factor(c("January", "March", "March", "December", "October", "October")))
(Month.Birth <- factor(c("January", "March", "March", "December", "October", "October"), levels = c("January", "March", "October", "December")))


#- Which month was Smriti born in?

Month.Birth[Names == "Smriti"]

#- Which boy was born in March?
 
Names[Gender == "Male" & Month.Birth == "March"]


## Releveling a factor
(levels(Month.Birth) <- c(1, 3, 10, 12))
(levels(Gender) <- c(0, 1)) # 0 indicates female



m <- c("Poor", "Good", "Better")
rate <- factor(m)

(rate <- factor(m, ordered = TRUE,
                levels = m))


## Defining and Ordering levels

s <- 1:5
rating <- factor(s)

(rating <- factor(s, ordered = TRUE,
                  levels = s))





  ## Data frames 
  

mydata <- data.frame(Name =   c("Kunal", "Ben", "Kritika", "Reena", "Narendra", "Smriti"),
                     Gender = factor(c("M", "M", "F", "F", "M", "F"), levels = c("M", "F")),
                     Age = c(20, 18, 30, 24, 24, 27))
mydata


mydata$Name
mydata[,c("Name", "Age")]
mydata[,c(1,3)]


## Tibble
tibble(
  `:)` = "smile", 
  ` ` = "space",
  `2000` = "number"
)




tribble(
  ~x, ~y, ~z,
  "a", 2, 3.6,
  "b", 1, 8.5
)




  Some examples
a <- c(T,F,T,F); a
b <- c(F,T,T,T); b
a&b; a&&b
a|b; a||b
