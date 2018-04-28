def getDatas(num_elements,gt):
    op=''
    for i in gt:
        op=op+'\n'+num_elements+' '+i
    return op.strip()
def avg(num):
    summation =0.0

    for i in num:
        summation = summation +int(i)     
    if(len(num) == 0):
        print 'Couldn\'t find the mean'
        return 0
    return summation/len(num)


file=open('runtest','w')
file.write(" ")
file.close()
import os

file=''
file=open('params.txt','r')

lines=file.read().strip()
params=[]
lines=lines.split(' ')
for line in lines:
    params.append(line)


file=open('threads.txt',"r")

threads=[]
lines=file.read().strip()
lines=lines.split(' ')
for line in lines:
    threads.append(line)

threads=['1','2','4','8','16']
ops=[]
import subprocess as sb
porg='./App '

from math import log

nums=[]
x=[[],[],[],[],[],[],[]]
for num_elements in params:
    num=[]
    k=1;
    for num_threads in threads:
        perThread=[]
        for i in range(100):
            xop=porg+num_elements+' '+num_threads
            proc=sb.Popen(xop,stdout=sb.PIPE, shell=True)
            (out,err)=proc.communicate()
            out=out.split(' ')
            if not (len(out) == 5):
                   print "\n\n\n"
                   print out
                   print "Input Incorrect"
                   exit(-1)
            perThread.append(out[3])
        index=int(log(int(num_threads),2))
    
        x[(index)].append((num_elements,perThread))


for i in range(5):
    file_name="outputfile"+threads[i]+".out"
    file=open(file_name,"w")
    write_data=''
    for j in x[i]:
        (et,dt)=j;
        write_data=write_data+"\n"+getDatas(et,dt);
    file.write(write_data.strip())

