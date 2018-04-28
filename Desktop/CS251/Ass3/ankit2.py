def calcRMS(w,x_test,y_test):
    sum=0
    for i in range(0,len(x_test)):
        tmp=(w[0]+w[1]*x_test[i])-y_test[i]
        sum = sum+(tmp**2)
    sum=sum/(len(x_test))
    from math import sqrt
    return sqrt(sum)
def leastSq(w,w_direct):
    (x_test,y_test)=readFile('test.csv')
    rms1=calcRMS(w,x_test,y_test)
    # print rms1
    rms2=calcRMS(w_direct,x_test,y_test)
    # print rms2
    return (rms1,rms2)
def plotLineVars(x,w):
    zp=[]
    for i in range(0,len(x)):
        t=w[0]+x[i]*w[1]
        zp.append(t)
    return zp
def readXY():
    return readFile('train.csv')
def readFile(fileName):
    train=open(fileName)
    x_train=[]
    y_train=[]
    i=0;
    # from numpy import float_ as toFloat
    for line in train:
        if(i==0):
            i=i+1
            continue
        line=line.strip().split(',')
        x_train.append(float(line[0]))
        y_train.append(float(line[1]))
    return (x_train,y_train)
def main():
    (xp,yp)=readXY()
    # print xp,yp
    nData=len(xp)
    eta=0.00000001
    import numpy as np
    x=np.asarray(xp).reshape(nData,1)
    y=np.asarray(yp).reshape(nData,1) 
    xPrime=np.insert(x,0,1,axis=1)
    # xPrime=np.reshape(nData,2)
    w = np.random.rand(2,1)
    mtp=(np.matmul(xPrime.transpose(),y))
    xTransX=np.matmul(xPrime.transpose(),xPrime)
    xTXInv=np.linalg.inv(xTransX)
    w_direct=np.matmul(xTXInv,mtp)
    from matplotlib import pyplot as plt
    plt.grid()
    plt.plot(xp,plotLineVars(xp,w),color='black')
    plt.plot(xp,plotLineVars(xp,w_direct),color='red')
    for i in range(0,5):
        for j in range(0,nData):
            xTrans=np.random.rand(2,1)
            xTrans[0]=1
            xTrans[1]=xp[j]
            w=w-eta*(w[0]+w[1]*xp[j]-yp[j])*(xTrans)
            if(j%100==0):
                plt.plot(xp,plotLineVars(xp,w))
    plt.plot(xp,plotLineVars(xp,w),color='black')
    plt.show()
    (r1,r2)=leastSq(w,w_direct)
    print "rms1", r1
    print "rms2", r2
if __name__ == "__main__":
    main()
