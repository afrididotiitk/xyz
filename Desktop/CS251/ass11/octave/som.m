inpfile1=dlmread('train.csv',',',1,0);
X_train=inpfile1(:,1);
Y_train=inpfile1(:,2);
onesvector=(ones(1,10000))';
newX_train=[onesvector,X_train];

w=rand(2,1);

hold on;

scatter(X_train, Y_train);
xlabel ("X_train");
ylabel ("Y_train");
title ("feature v/s label graph train data");
plot(X_train,((w')*newX_train'))
print -dpdf "fig11.pdf";
close

w_direct=(inv((newX_train'*newX_train)))*(newX_train')*Y_train;

hold on;
scatter(X_train,Y_train);
plot(X_train,(w_direct')*(newX_train'));
print -dpdf "fig22.pdf";
close;
eta=0.00000001

xp=[]
yp=[]
count=1;
hold on;
for j=1:10000
  x=inpfile1(j,1)
  y=inpfile1(j,2)
  xdash=[1;x]
  p=w-eta*((w')*xdash-y)*xdash

  if(mod(j,100) == 0)
    #xp=[xp,x]
    #new=[(w')*xdash]
    #yp=[yp,new]
    count=count+1;
    plot(X_train,(p')*(newX_train'));
   
    
  endif
  w=p
endfor
print -dpdf "fig33.pdf";

#plot(xp,yp)


scatter(X_train, Y_train);
plot(X_train,((w')*newX_train'))
#print -dpdf "fig44.pdf";
#print -dpdf "fig55.pdf";

inpfile2=dlmread('test.csv',',',1,0);
X_test=inpfile2(:,1)
Y_test=inpfile2(:,2)
onesvector=(ones(1,10500))'
newX_test=[onesvector,X_test]
y_pred1=newX_test*w
(y_pred1-Y_test)
(y_pred1-Y_test)*2

#RMSE=sqrt(M1);
#print -dpdf "fig66.pdf";

y_pred2=newX_test*w_direct
(y_pred2-Y_test)
(y_pred2-Y_test)*2
M1=mean((y_pred1-Y_test).^2)
M2=mean((y_pred2-Y_test).^2)
RMSE1=sqrt(M1)
RMSE2=sqrt(M2)
m3=count;
#print -dpdf "fig77.pdf";
