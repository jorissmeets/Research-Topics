library(missMethods)
library(mice)
library(VIM)
library(class)
library(Rcpp)

dataset.name <- 'user_data'

setwd(sprintf('C:/Users/20175878/Documents/DSAI/Y1Q1_RTDM/research_paper/code/%1$s',dataset.name))
data<- read.csv(sprintf('C:/Users/20175878/Documents/DSAI/Y1Q1_RTDM/research_paper/code/%1$s/%1$s.csv',dataset.name), header = F, sep=',')

i <- 1
while (i < 51) {
  
  data1 = sort(sample(nrow(data), nrow(data)*.7))
  
  train<-data[data1,]
  test<-data[-data1,]
  
  # specifics for the different dataset
  if(dataset.name == 'scale_data' || dataset.name == 'banknote_data'){
    test<-test[,c("V2","V3","V4","V5","V1")]
    train<-train[,c("V2","V3","V4","V5","V1")]
    train1 = train[,c("V2","V3","V4","V5")]
    train1_label <- "V1"
    
    df <- data.frame (fourth_column = c(1,1,1,1),
                      first_column  = c(0, 0, 1,0),
                      second_column = c(1, 0, 0,0),
                      third_column = c(0, 1, 0,0)
                      )
  }

  if(dataset.name == 'user_data'){
    test<-test[,c("V2","V3","V4","V5","V6","V1")]
    train<-train[,c("V2","V3","V4","V5","V6","V1")]
    train1 = train[,c("V2","V3","V4","V5","V6")]
    train1_label <- "V1"
    
    df <- data.frame (first_column  = c(0, 0, 1,0),
                      second_column = c(1, 0, 0,0),
                      third_column = c(0, 1, 0,0),
                      fourth_column = c(0,0,0,1),
                      fifth_column = c(1,1,1,1))
  }
    
  if(dataset.name == 'wine_data'){
    train1= train[,c("V2","V3","V4","V5","V6","V7","V8","V9","V10","V11","V12","V13")]
    train1_label <- "V1"
    test<-test[,c("V1","V2","V3","V4","V5","V6","V7","V8","V9","V10","V11","V12","V13")]
    train<-train[,c("V1","V2","V3","V4","V5","V6","V7","V8","V9","V10","V11","V12","V13")]
    
    df <- data.frame (first_column  = c(0, 1, 0),
                      second_column = c(0, 1, 0),
                      third_column = c(0, 1, 0),
                      fourth_column = c(0,1,0),
                      fifth_column  = c(0, 1, 0),
                      sixth_column = c(1, 0, 0),
                      seventh_column = c(1,0, 0),
                      eight_column = c(1,0,0),
                      ninth_column  = c(1, 0, 0),
                      tenth_column = c(1, 0, 0),
                      eleventh_column = c(1, 1,1),
                      twelveth_column = c(1,1,1))  
    }  
  dname <- as.character(i)
  dpath <- paste("./",dname,"/", sep="")
  
  #10% missing data
  a <- ampute(train1, patterns = df, prop = 0.1, type="RIGHT", bycases=FALSE, mech="MAR")
  data10 <- a$amp
  data10$label <- train[[train1_label]]

  
  #20% missing data
  b <- ampute(train1, patterns = df, prop = 0.2, type="RIGHT", bycases=FALSE, mech="MAR")
  data20 <- b$amp
  data20$label <- train[[train1_label]]

  
  #50% missing data 
  c <- ampute(train1, patterns = df, prop = 0.5, type="RIGHT", bycases=FALSE, mech="MAR")
  data50 <- c$amp
  data50$label <- train[[train1_label]]

  
  dir.create(dname)
  write.csv(x=test,paste(dpath, "test.csv", sep=""))
  write.csv(x=train,paste(dpath, "train.csv", sep=""))
  
  #10% missing data mice
  ta <- mice(data10)
  train10a <- complete(ta, 1)
  train10b <- complete(ta, 2)
  train10c <- complete(ta, 3)
  train10d <- complete(ta, 4)
  train10e <- complete(ta, 5)
  write.csv(x=train10a, paste(dpath,"train10a.csv",sep=""))
  write.csv(x=train10b, paste(dpath,"train10b.csv",sep=""))
  write.csv(x=train10c, paste(dpath,"train10c.csv",sep=""))
  write.csv(x=train10d, paste(dpath,"train10d.csv",sep=""))
  write.csv(x=train10e, paste(dpath,"train10e.csv",sep=""))
  
  #20% missing data mice
  tb <- mice(data20)
  train20a <- complete(tb, 1)
  train20b <- complete(tb, 2)
  train20c <- complete(tb, 3)
  train20d <- complete(tb, 4)
  train20e <- complete(tb, 5)
  write.csv(x=train20a, paste(dpath,"train20a.csv",sep=""))
  write.csv(x=train20b, paste(dpath,"train20b.csv",sep=""))
  write.csv(x=train20c, paste(dpath,"train20c.csv",sep=""))
  write.csv(x=train20d, paste(dpath,"train20d.csv",sep=""))
  write.csv(x=train20e, paste(dpath,"train20e.csv",sep=""))
  
  #50% missing data mice
  tc <- mice(data50)
  train50a <- complete(tc, 1)
  train50b <- complete(tc, 2)
  train50c <- complete(tc, 3)
  train50d <- complete(tc, 4)
  train50e <- complete(tc, 5)
  write.csv(x=train50a, paste(dpath,"train50a.csv",sep=""))
  write.csv(x=train50b, paste(dpath,"train50b.csv",sep=""))
  write.csv(x=train50c, paste(dpath,"train50c.csv",sep=""))
  write.csv(x=train50d, paste(dpath,"train50d.csv",sep=""))
  write.csv(x=train50e, paste(dpath,"train50e.csv",sep=""))
  i = i+1
}