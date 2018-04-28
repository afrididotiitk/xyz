#!/usr/bin/python
def main():
    from sys import exit
    # a = raw_input("give number in any random base ")
    # b = 0.0
    # b = input("give base ")
    from sys import argv
    a= argv[1].strip()
    b= int(argv[2])
    if (len(argv)!=3):
        print "sorry_inavlid_input"
        exit()
    neg=0
    if b<2 or b>36:
        print "sorry_inavlid_input"
        exit()
        
    length=len(a)
    if a[0]=='-':
        a=a[1:length]
        neg=1
    count=0;
    for j in range(length):
        if a[j]!='0':
            break
        else:
            count +=1


    c=a[count:length]
    length= len(c)
    if length==1 and c[0]=='.':
        print "sorry_inavlid_input"
        exit()
    flag=0
    valid=0
    decimal_index=0
    n=0.0
    np=0.0
    for i in range(0,length):
        if  c[i]<'0' or c[i]>'Z' or (c[i]>'9' and c[i]<'A'):
            if c[i]=='.' and i==length-1:
                print "sorry_inavlid_input"
                exit()
            if c[i]=='.'and flag==0:
                flag=1
                decimal_index=i
            else:
                print "sorry_invalid_input"
                exit()
        elif c[i]<='9'and (ord(c[i])-48)>=b:
            print "sorry_inavlid_input"
            exit()
        elif c[i]>'9'and (ord(c[i])-55)>=b:
            print "sorry_inavlid_input"
            exit()
        elif(i==length-1):
            valid=1

    if valid==1 and flag==0:
        decimal_index=length
    if valid==1 and decimal_index!=0:
        for i in range(0,decimal_index):
            if c[i]<'A':
                n=n + (b**(decimal_index-i-1))*(ord(c[i])-48)
            else:
                n=n + (b**(decimal_index-i-1))*(ord(c[i])-55)
                

    if flag==1:
        for k in range(decimal_index+1,length):
            if c[i]<'A':
                np=np+((ord(c[k])-48)*1.0)/(b**(k-decimal_index))
            else:
                np=np+((ord(c[k])-55)*1.0)/(b**(k-decimal_index))
    result=n+np
    if result > 999999999:
        print "sorry! output out of bound"
        exit()
    if neg==0:
        print result
    if neg==1:
        print -result
if __name__ =='__main__':
    main()