#!/usr/bin/gawk -f
BEGIN {
	flag=0 ; string=0; comment=0; line=0; tmp=-1;
	
	}

{
	line = line + 1;
	flag1=-1
	for(i=1;i<=NF;i++)
	{
	   if(flag1==-1&&!flag)
	   {
	    if($i=="//"||$i~"//+")
	 	{
		comment++;
		flag1=3;
		break;
		}
    	    if($i=="/*"||$i=="/*+")
    		{
		flag1=1;
		tmp=NR;
    		}
	    if($i~"\"+")
    		{
		flag1=2;
    		}			
 	   }
	   else 
		   {
			   if(flag1==1||flag)
			   {
				if($i=="*/")
				{
					flag1=-1;
					if(flag!=0)
					{
						comment= comment +(line-tmp) +1; 
					}
					else
					{
						comment++;
					}
					flag=0;
				}
			   }
			  else if(flag1==2)
			  {
				  if($i~"\"")
				  {
					  flag1=-1;
					  flag=0;
					  string++;
				  }
			  }
		   }
	   
	}
	if(flag1==1)
	{
		flag=1;
	}
}
END
{ printf "%d\t%d",comment,string }
