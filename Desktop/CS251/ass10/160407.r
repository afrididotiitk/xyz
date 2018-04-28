#######   STEP 1 importing the dataset  #########
data = rexp(n=50000,rate=0.2)
dataset=(data)
data=sort(data)

plot(dataset,main="Scatter Plot of randomly generated and unsorted Data")
plot(data,main="Scatter Plot of above data but Sorted ")

#######    STEP 2     ##################
matrixdata=matrix(dataset,nrow=100,ncol=500)


######      STEP 3    ##################

#### pdf cdf ###
for(i in 1:5)
  {
    y1=matrixdata[1:100,i]
    pdata <- rep(0, 100);
    y1=round(y1)
    for(j in 1:100){
      val=y1[j]
      
      pdata[val] = pdata[val] + 1/ 100; 
      
    }
    
    xcols <- c(0:99)
    
    #str(pdata)
    #str(xcols)
    
    plot(xcols, pdata, "p",main=paste("PDF of Y",i),col="red", xlab="X", ylab="f(X)")
    
    y2=ecdf(y1)
    plot(y2,main=paste("CDF of Y",i))
    
  }

##### calculating mean of y's
ymeans<-array(1:500)
ysd<-array(1:500)
for(i in 1:500)
{
  ymeans[i]=(mean(matrixdata[1:100,i]))
  ysd[i]=(sd(matrixdata[1:100,i]))
}

#### printing mean and SD of first five Y's 
for(i in 1:5)
{
  print(paste("mean of Y[",i,"] =",ymeans[i],"& SD of Y[",i,"] =",ysd[i]))

}
##### STEP 4 #######
Z<-array(1:500)

for (i in 1:500)
{
  Z[i]=mean(matrixdata[1:100,i])
  
}

tab <- table(round(Z,1))
#str(tab)
plot(tab, "h",main="Frequency Distribution of Z", xlab="Value", ylab="Frequency")
newtab=tab
num_entry=nrow(tab)
for (i in 2:num_entry)
{
  newtab[i]=newtab[i]+newtab[i-1]
}
#str(newtab)
plot(newtab, "h",main="Commulative Frequency Distribution of Z",xlab="Value", ylab="Comulative_Frequency")

pdata <- rep(0, 100);

for(i in 1:500){
  val=round(Z[i], 1);
  if(val <= 100){
    pdata[10*val] = pdata[10*val] + 1/ 500; 
  }
}

xcols <- c(0:99)

#str(pdata)
#str(xcols)

plot(xcols, pdata, "p",main="PDF of Z",col="red", xlab="X", ylab="f(X)")
val1=ecdf(round(Z,1))
plot(val1,main="CDF of Z")

#cdata <- rep(0, 100)
#xcols1 <-c(0:99)
#cdata[1] <- pdata[1]

#for(i in 2:100){
#  cdata[i] = cdata[i-1] + pdata[i]
#}

#plot(xcols1, cdata, "s", col="red", xlab="X", ylab="F(X)")


######### STEP 5 & 6 ########
print(paste("Mean of new data Z = ",mean(Z),"& Mean of original data =", mean(dataset)))
print(paste("SD of new data Z =",sd(Z),"& SD of original data =",sd(dataset)))

