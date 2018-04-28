%%%%%%%%%%%%%%     STEP 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%
inpfile1=dlmread('train.csv',',',1,0);
X_train=inpfile1(:,1);
Y_train=inpfile1(:,2);
onesvector=(ones(1,10000))';
newX_train=[onesvector,X_train];

%%%%%%%%%%%%%%     STEP 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%

w=rand(2,1);

%%%%%%%%%%%%%%     STEP 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%

hold on;
scatter(X_train, Y_train);
xlabel ("X_train");
ylabel ("Y_train / w'*X_train'");
title ("feature/w'*x' v/s label graph train data");
plot(X_train,((w')*newX_train'))
print -dpdf "fig1.pdf";
close

%%%%%%%%%%%%%%     STEP 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%

w_direct=(inv((newX_train'*newX_train)))*(newX_train')*Y_train;

hold on;
scatter(X_train,Y_train);
title ("feature/W_direct*x' V/S X_train graph");
plot(X_train,(w_direct')*(newX_train'));
print -dpdf "fig2.pdf";
close;

%%%%%%%%%%%%%%     STEP 5 %%%%%%%%%%%%%%%%%%%%%%%%%%%

hold on;
eta=0.00000001;
for j=1:10000
  x=inpfile1(j,1);
  y=inpfile1(j,2);
  xdash=[1;x];
  p=w-eta*((w')*xdash-y)*xdash;

  if(mod(j,100) == 0)
    
    plot(X_train,(p')*(newX_train'));
   
    
  endif
  w=p;
endfor
print -dpdf "fig3.pdf";
close

%%%%%%%%%%%%%%     STEP 6 %%%%%%%%%%%%%%%%%%%%%%%%%%%

hold on;
scatter(X_train, Y_train);
plot(X_train,((w')*newX_train'));
plot(X_train,(w_direct')*(newX_train'));
print -dpdf "fig4.pdf";
close

%%%%%%%%%%%%%%     STEP 7 %%%%%%%%%%%%%%%%%%%%%%%%%%%

inpfile2=dlmread('test.csv',',',1,0);
X_test=inpfile2(:,1);
Y_test=inpfile2(:,2);
onesvector=(ones(1,10500))';
newX_test=[onesvector,X_test];
y_pred1=newX_test*w;
y_pred2=newX_test*w_direct;
M1=mean((y_pred1-Y_test).^2);
M2=mean((y_pred2-Y_test).^2);
%%%%%%%%%%%%%%     output values %%%%%%%%%%%%%%%%%%%%%%%%%%%

RMSE_Y_pred1=sqrt(M1)
RMSE_Y_pred2=sqrt(M2)
