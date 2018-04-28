#!/usr/bin/python
def inputfile(name):
    file=open(name)
    x_train=[]
    y_train=[]
    i=0
    for line in file:        
        if i>0:
            line=line.strip().split(',')
            x_train.append(float(line[0]))
            y_train.append(float(line[1]))
        i=i+1
    return (x_train,y_train)
def bitwisemul(x,w):
    prod=[]
    for i in range(0,len (x)):
        p= 1*w[0]+(w[1]*x[i])
        prod.append(p)
    return prod

def main():
    eta=0.00000001
    (X,Y)=inputfile('train.csv')
    import numpy as np
    length= len(X)
    Xpoint=np.asarray(X).reshape(length,1)
    y_train=np.asarray(Y).reshape(length,1)
    x_train=np.insert(Xpoint,0,1,axis=1)
    w = np.random.rand(2,1)
    xmult=np.matmul(x_train.transpose(),x_train)
    xymult=np.matmul(x_train.transpose(),y_train)   
    xmulinverse=np.linalg.inv(xmult)
    w_direct=np.matmul(xmulinverse,xymult)

    # xprime=x_train.transpose()
    
    from matplotlib import pyplot as plt 
    plt.grid()
    plt.plot(X,Y,'.',color='yellow')
    plt.plot(X,bitwisemul(X,w),color='red')
    plt.plot(X,bitwisemul(X,w_direct),color='green')
    for i in range(0,9):
        for j in range(0,length):
            xbar=np.random.rand(2,1)
            xbar[0]=1
            xbar[0]=Xpoint[j]
            t=Xpoint[j]*w[1]+w[0]
            w[0]=w[0]-eta*t+eta*Y[j]
            w[1]=w[1]-(eta*t-eta*Y[j])*X[j]
            if (j%100==0):
                plt.plot(X,bitwisemul(X,w),linewidth=0.2)
    plt.plot(X,bitwisemul(X,w),color='brown')
    plt.show()
    (testx,testy)=inputfile("test.csv")
    sqsum1=0
    sqsum2=0
    for i in range(0,len (testx)):
        temp=(w[0]+w[1]*testx[i])-testy[i]
        sqsum1=sqsum1+(temp*temp)
    sqsum1=sqsum1/(len(testx))

    for i in range(0,len (testx)):
        temp=(w_direct[0]+w_direct[1]*testx[i])-testy[i]
        sqsum2=sqsum2+(temp*temp)
    sqsum2=sqsum2/(len(testx))

    from math import sqrt
    print sqrt(sqsum1)
    print sqrt(sqsum2)
           
if __name__=='__main__':
    main()
