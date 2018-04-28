#! /usr/bin/gawk 
BEGIN	{
    lines=0;
    comment=0;
    string=0;
    tmp=-1;
    flag=0;
   
}

{ 
    lines++;
    b=$0
    tmp2=-1
     for(i=1;i<=NF;i++)
        { 
            if(tmp2==-1&&!flag)
            {
                if($i=="//"||$i~"//+")
                    {
                        tmp2=3;
                        comment=comment+1;
                        break;
                    }
                if($i=="/*"||$i=="/*+")
                    {
                        tmp2=1;
                        tmp=NR;
                    }
                if($i~"\"")
                {
                    tmp2=2;
                }
                
            }
            else
            {        
                    if(tmp2==1||flag)
                    {
                        if($i=="*/"){
                        tmp2=-1;
                        if(flag!=0)
                        {
                            comment =comment+(lines-tmp)+1;
                            }
                        else
                         {
                             comment=comment+1;
                         }
                         flag=0;

                         }
                    }
                    else if(tmp2==2) 
                    {
                          if($i~"\"")  
                          {
                              tmp2=-1;
                              flag =0;
                              string=+1;
                          }
                    }
            }
        }
    if(tmp2==1)
        {
            flag=1;
        }
}
END	{
    printf "%d\t%d",comment,string   
}