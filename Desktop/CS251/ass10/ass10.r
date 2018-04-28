#importing the dataset
dataset = rexp(n=50000,rate=0.2)
dataset
plot(dataset)
matrixdata=matrix(dataset,nrow=500,ncol=100)
dim(matrixdata)
for(i in 1:5)
{
y1=matrixdata[i,1:100]
plot(y1,0.2*exp(-0.2*y1))
}
for(i in 1:5)
{
  print(mean(matrixdata[i,1:100]))
  print(sd(matrixdata[i,1:100]))
}
newdata<-array(1:500)
#newdata[1]=mean(matrixdata[1,1:100])
for (i in 1:500)
{
  newdata[i]=mean(matrixdata[i,1:100])
  #newdata[i]=i
}
print(newdata)
#plot(newdata,xlab="Value",ylab="Frequency")
tab <- table(round(newdata))
str(tab)
plot(tab)

plot(tab, "h", xlab="Value", ylab="Frequency")
plot(tab)
newtab=tab
num_entry=nrow(tab)
for (i in 2:num_entry)
{
  newtab[i]=newtab[i]+newtab[i-1]
}
newtab
str(newtab)
plot(newtab)
#plot(tab, "h", xlab="Value", ylab="Frequency")
pdata <- rep(0, 10);

for(i in 1:500){
  val=round(newdata[i], 0);
  if(val <= 100){
    pdata[val] = pdata[val] + 1/ 500; 
  }
}

xcols <- c(0:9)

str(pdata)
str(xcols)

plot(xcols, pdata, "p", xlab="X", ylab="f(X)")

cdata <- rep(0, 10)
xcols1 <-c(0:9)
cdata[1] <- pdata[1]

for(i in 2:10){
  cdata[i] = cdata[i-1] + pdata[i]
}

plot(xcols1, cdata, "o", col="blue", xlab="X", ylab="F(X)")
print(mean(newdata))
print(sd(newdata))
print(mean(dataset))
print(sd(dataset))

