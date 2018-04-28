#importing the dataset
data = rexp(n=50000,rate=0.2)
dataset=sort(data)
plot(data)
plot(dataset)
matrixdata=matrix(dataset,nrow=100,ncol=500)
#dim(matrixdata)
for(i in 1:5)
{
  y1=matrixdata[1:100,i]
  plot(y1,0.2*exp(-0.2*y1))
  plot(y1,(1-exp(-0.2*y1)))
}
for(i in 1:5)
{
  y1=ecdf(matrixdata[1:100,i])
  plot(y1)
}
ymeans<-array(1:500)
ysd<-array(1:500)
for(i in 1:500)
{
  ymeans[i]=(mean(matrixdata[1:100,i]))
  ysd[i]=(sd(matrixdata[1:100,i]))
}
for(i in 1:5)
{
  print(paste("mean of Y[",i,"] =",ymeans[i],"& SD of Y[",i,"] =",ysd[i]))

}
Z<-array(1:500)
#newdata[1]=mean(matrixdata[1,1:100])
for (i in 1:500)
{
  Z[i]=mean(matrixdata[1:100,i])
  #newdata[i]=i
}
#@print(Z)
#plot(newdata,xlab="Value",ylab="Frequency")
tab <- table(round(Z))
#str(tab)
plot(tab, "h", xlab="Value", ylab="Frequency")
newtab=tab
num_entry=nrow(tab)
for (i in 2:num_entry)
{
  newtab[i]=newtab[i]+newtab[i-1]
}
#str(newtab)
plot(newtab, "h", xlab="Value", ylab="Comulative_Frequency")

pdata <- rep(0, 100);

for(i in 1:500){
  val=round(Z[i], 0);
  if(val <= 100){
    pdata[val] = pdata[val] + 1/ 500; 
  }
}

xcols <- c(0:99)

#str(pdata)
#str(xcols)

plot(xcols, pdata, "p",col="red", xlab="X", ylab="f(X)")

cdata <- rep(0, 100)
xcols1 <-c(0:99)
cdata[1] <- pdata[1]

for(i in 2:100){
  cdata[i] = cdata[i-1] + pdata[i]
}

plot(xcols1, cdata, "s", col="red", xlab="X", ylab="F(X)")
print(paste("Mean of new data Z = ",mean(Z),"& Mean of original data =", mean(dataset)))
print(paste("SD of new data Z =",sd(Z),"& SD of original data =",sd(dataset)))

#print(sd(newdata))
#print(mean(dataset))
#print(sd(dataset))

