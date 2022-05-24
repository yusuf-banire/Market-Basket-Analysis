#set my working directory 

setwd("C:/Users/new/OneDrive - University of Salford/Desktop/ASDM")
getwd()

# read my data to a dataframe and set my columm class as a factor

Trans_market_basket <- read.csv("ARM_MARKETBASKET.csv",header = TRUE,colClasses = "factor")

#inspect my dataset
names(Trans_market_basket)
head(Trans_market_basket)
summary(Trans_market_basket)
tail(Trans_market_basket)
View(Trans_market_basket)
dim(Trans_market_basket)
str(Trans_market_basket)

#finding the number of yes an no in each column
Num_yes <- colSums(Trans_market_basket == "Yes") 
Num_yes

Num_no <- colSums(Trans_market_basket == "No")

Transactions <- rbind(Num_yes,Num_no)
Transactions

barplot(Transactions,legend=rownames(Transactions))

barplot(Transactions, beside = TRUE,legend=rownames(Transactions))

# installing packages and calling the libarary
install.packages("arules")
library(arules)

#creating rules using apriori
trans_rules <- apriori(Trans_market_basket)

summary(trans_rules)

#reduce the number of rules using the parameter argument

telco_rules <- apriori(Trans_market_basket,parameter = list (minlen=2,maxlen=2,conf=0.50))

inspect(telco_rules)

# reuducing rules to meet certain criteria
telco_rules <- apriori(Trans_market_basket,parameter = list (minlen=2,maxlen=2,conf=0.40),
                       appearance = list(rhs=c("Coffee=Yes"),default="lhs"))
inspect(telco_rules)

# installing arulesViz for visualizing the rules
install.packages("arulesViz")
library(arulesViz)

plot(telco_rules)

#Create an interactive plot environment

plot(telco_rules,engine="plotly")

# creating  rules to modify with rulesExplorer
telco_rulesExpl <- apriori(Trans_market_basket,parameter = list (minlen=2,maxlen=3,conf=0.50),
                       appearance = list(rhs=c("Coffee=Yes"),default="lhs"))

install.packages("shiny")
library(shiny)
install.packages("shinythemes")

ruleExplorer(telco_rulesExpl)
