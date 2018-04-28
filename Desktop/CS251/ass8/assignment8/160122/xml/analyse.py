def variance(x_s,x):
    for i in range(5):
        for j in range(len(x_s[i])):
            (dt)=x[i][j][1]
            sp=x_s[i][j][1]
            tavg=x_s[i][j][2]
            sum=0.0
            for k in dt:
                val=tavg/float(k) - (sp)
                sum= sum +round((val)**2,3)
            sum = round(sum/100,3)
            x_s[i][j]=(x_s[i][j][0],sp,sum)

    return x_s



def varian(t,avgs):
    sum = 0.0
    for i in t:
        sum = sum+(int(i)-avgs)**2
    if(len(t) == 0):
        print 'Couldn\'t find the variance'
        return 0
    return round(sum/len(t),3)
def meen(x):
    sum =0.0

    for i in x:
        sum = sum +int(i)     
    if(len(x) == 0):
        print 'Couldn\'t find the mean'
        return 0
    
    return round(sum/len(x),3)
###############################
"""
Prepare data for (2)
"""
file=open('analyse','w')
file.write(" ")
file.close()
x=[[],[],[],[],[]]
# print len(x)
threads=['1','2','4','8','16']
for i in range(5):
    file_name="thread_"+threads[i]+".out"
    file=open(file_name,"r")
    count=0
    # prevE=-1
    dts=[]
    for lines in file:
        count = count +1 
        lines =lines.strip()
        (e,t)=lines.split(' ')
        dts.append(t)
        if count == 100:
            count =0
            # # print dts
            # if not (prevE == -1):
            x[i].append((e,dts))
            # prevE =int(e);
            dts=[]
"""
"""
# print len(x)
# x_0=x[0]
# (e,t)=x_0[0]
# print len(t)
# exit(-1)

"""
Prepare the avg data
"""
x_avgs=[[],[],[],[],[]]
# from numpy import var
for i in range(5):
    file_name='line_'+threads[i]+'.out'
    string =''
    for j in x[i]:
        (e,t)=j;
        meenI=meen(t)
        # var=variance(t,meenI)
        # print var
        string=string+'\n'+e+' '+str(meenI)
        x_avgs[i].append((e,meenI))
    string = string.strip()
    file= open(file_name,"w")
    file.write(string)
    file.close()
x_speedUps=[[],[],[],[],[]]
elems=[]
"""
Avg Data prepared
Prepare Data with variance and speedUps
"""

for i in range(5):
    for j in range(len(x_avgs[i])):
        (e,tavg)=x_avgs[i][j]
        (e,t_ref)=x_avgs[0][j]
        # print tavg,t_ref
        x_speedUps[i].append((e,round(tavg/t_ref,3),tavg))
        if not(len(elems)==len(x_avgs[i])):
            elems.append(e)
    # print "============"

"""
Prepared Data With Variance and speed ups.
Prepare in th format:
num_elem t1_sp,t2_sp,t4_sp,t8_sp,t16_sp,q1_sp,q2_sp,q4_sp,q8_sp,q16_sp
"""
# for i in x_speedUps:
#     print i
# exit (-1)
# print x[i][j][1]
# exit(-1)

x_speedUps=variance(x_speedUps,x)
x_spds=[]
for i in elems:
    x_spds.append(str(i))
# print x_spds
for i in range (len (elems)):
    (e,t1,q1)=x_speedUps[0][i]
    (e,t2,q2)=x_speedUps[1][i]
    (e,t3,q3)=x_speedUps[2][i]
    (e,t4,q4)=x_speedUps[3][i]
    (e,t5,q5)=x_speedUps[4][i]    
    strindTvals=str(t1)+" "+str(t2)+" "+str(t3)+" "+str(t4)+" "+str(t5)
    strindQvals=str(q1)+" "+str(q2)+" "+str(q3)+" "+str(q4)+" "+str(q5)
    x_spds[i]=x_spds[i]+" "+strindTvals+" "+strindQvals
"""
Prepared the data:
    TODO: print the data to the data file
"""
string_header="#NumofElements Thread=1  Thread=2 Thread=4 Threads=8 Threads=16\n"
file_name="bar_plot.out"
file=open(file_name,"w")
# file.write(string_header)
for i  in x_spds:
    file.write(i+"\n")
file.close()
