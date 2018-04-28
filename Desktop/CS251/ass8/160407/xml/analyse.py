def variance(elm_s,elm):
    for i in range(5):
        for j in range(len(elm_s[i])):
            (dta)=elm[i][j][1]
            sp=elm_s[i][j][1]
            avgtime=elm_s[i][j][2]
            summation=0.0
            for k in dta:
                valu=avgtime/float(k) - (sp)
                summation= summation +round((valu)**2,3)
            summation = round(summation/100,3)
            elm_s[i][j]=(elm_s[i][j][0],sp,summation)

    return elm_s


def avg(num):
    summation =0.0

    for i in num:
        summation = summation +int(i)     
    if(len(num) == 0):
        print 'Couldn\'t find the mean'
        return 0
    
    return round(summation/len(num),3)


file=open('analyse','w')
file.write(" ")
file.close()
x=[[],[],[],[],[]]

threads=['1','2','4','8','16']
for i in range(5):
    file_name="outputfile"+threads[i]+".out"
    file=open(file_name,"r")
    count=0
   
    dts=[]
    for lines in file:
        count = count +1 
        lines =lines.strip()
        (e,t)=lines.split(' ')
        dts.append(t)
        if count == 100:
            count =0
            
            x[i].append((e,dts))
           
            dts=[]

x_avgs=[[],[],[],[],[]]

for i in range(5):
    file_name='line_'+threads[i]+'.out'
    string =''
    for j in x[i]:
        (e,t)=j;
        avgI=avg(t)
       
        string=string+'\n'+e+' '+str(avgI)
        x_avgs[i].append((e,avgI))
    string = string.strip()
    file= open(file_name,"w")
    file.write(string)
    file.close()
x_speedUps=[[],[],[],[],[]]
elems=[]


for i in range(5):
    for j in range(len(x_avgs[i])):
        (e,tavg)=x_avgs[i][j]
        (e,t_ref)=x_avgs[0][j]
      
        x_speedUps[i].append((e,round(tavg/t_ref,3),tavg))
        if not(len(elems)==len(x_avgs[i])):
            elems.append(e)
    

x_speedUps=variance(x_speedUps,x)
x_spds=[]
for i in elems:
    x_spds.append(str(i))

for i in range (len (elems)):
    (e,t1,q1)=x_speedUps[0][i]
    (e,t2,q2)=x_speedUps[1][i]
    (e,t3,q3)=x_speedUps[2][i]
    (e,t4,q4)=x_speedUps[3][i]
    (e,t5,q5)=x_speedUps[4][i]    
    strindTvals=str(t1)+" "+str(t2)+" "+str(t3)+" "+str(t4)+" "+str(t5)
    strindQvals=str(q1)+" "+str(q2)+" "+str(q3)+" "+str(q4)+" "+str(q5)
    x_spds[i]=x_spds[i]+" "+strindTvals+" "+strindQvals

string_header="#NumofElements Thread=1  Thread=2 Thread=4 Threads=8 Threads=16\n"
file_name="bar_plot.out"
file=open(file_name,"w")

for i  in x_spds:
    file.write(i+"\n")
file.close()
