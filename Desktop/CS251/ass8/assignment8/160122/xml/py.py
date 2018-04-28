def getDatas(num_elements,gt):
    op=''
    for i in gt:
        op=op+'\n'+num_elements+' '+i
    return op.strip()
def meen(x):
    sum =0.0

    for i in x:
        sum = sum +int(i)     
    if(len(x) == 0):
        print 'Couldn\'t find the mean'
        return 0
    return sum/len(x)


file=open('runtest','w')
file.write(" ")
file.close()
import os
# import er
file=''
try:
    file=open('params.txt','r')
except Exception:
    print "Could not load the parameter file"
    exit(-1)
lines=file.read().strip()
params=[]
lines=lines.split(' ')
for line in lines:
    params.append(line)

try:
    file=open('threads.txt',"r")
except Exception:
    print "Could not load the thread file"
    exit(-1)
threads=[]
lines=file.read().strip()
lines=lines.split(' ')
for line in lines:
    threads.append(line)
# print "This process may take time"
# print params
# print threads
# exit(-1)
threads=['1','2','4','8','16']
ops=[]
import subprocess as sb
porg='./App '
# nums=[(,[(,[])])]
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
        # print index
        x[(index)].append((num_elements,perThread))


for i in range(5):
    file_name="thread_"+threads[i]+".out"
    file=open(file_name,"w")
    write_data=''
    for j in x[i]:
        (et,dt)=j;
        write_data=write_data+"\n"+getDatas(et,dt);
    file.write(write_data.strip())
# print nums
# Trial 1
# print "Data formation over"
# # from numpy import  mean as mean

# # from matplotlib import pyplot as plt
# for i in range(5):
#     file_name='sline_'+threads[i]+'.out'
#     file2='scatter_'+threads[i]+'.out'
#     file2=open(file2,'w')
#     file=open(file_name,'w')
#     write_string=''
#     write_string2=''
#     for k in range(len(x[i])):
#         (et,dt)=x[i][k]
#         write_string2=getDatas(et,dt)
#         dt=meen(dt)
#         file2.write(write_string2+"\n")
#         write_string=write_string+'\n'+et+'\t'+str(dt)
#     file.write(write_string.strip())

# # print e
# # print dT



# # op=[]
# # for (numE,eData) in nums:
# #     opData=[]
# #     for (tData,arr)  in eData:
# #         opData.append((tData,mean(arr)))
# #     op.append()
# # print params,threads