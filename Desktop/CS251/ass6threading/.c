#include <stdio.h>
#include<stdlib.h>
#include<fcntl.h>
#include<pthread.h>
#include<string.h>
#define MAX_THREADS 64
#define START_INDEX 1001
#define SIZE 10000
#define USAGE_EXIT(s) do{ \
                             printf("Usage: %s <acc_file.txt> <txn_file.txt> <# of txns> <# of threads> \n %s\n", argv[0], s); \
                            exit(-1);\
                    }while(0);

#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))
struct acc{
  double bal;
  int prev_trans_id;
  struct trx* trans;
};
struct trx{
  int txn_id;#
	double amt;
  struct trx* next;
};
struct thread_param{
  pthread_t tid;
  struct acc* acn;
  int skip;
  int i;

};
typedef struct acc AC;
typedef struct trx txn;
void actual_Calc(AC* acn,txn* trans,int id) //id == acc no-START_INDEX
{
  if(trans==NULL)
  {
    return;
  }
  else
  {
    AC* curr = (acn+id);
    switch(trans->txn_id)
    {
      case 1:
            curr->bal = curr->bal + .99*((trans->amt));
            break;
      case 2:
            curr->bal = curr->bal - 1.01*((trans->amt));
            break;
      case 3:
            curr->bal = (curr->bal)*1.071;
            break;
    }
    actual_Calc(acn,trans->next,id);
    free(trans);
    return;
  }

}
void functor(AC* ac,int index)
{
    actual_Calc(ac,(ac+index)->trans,index);
    return;
}
void* calculateIt(void *arg)
{
   struct thread_param * params =(struct thread_param *) arg;
    int  i = params->i;
    int skip=params->skip;
    for(int j = i;j<SIZE;)
    {
      functor(params->acn,j);
      j = j + skip;
    }
    return NULL;
}
void insertTxn(AC *acn,int src_id,int dest_id,int txn_code,double amt)
{ if(acn != NULL)
  { 
    // if((acn+src_id)->prev_trans_id == 0)
    // {
    //   (acn+src_id)->trans=NULL;
    //   (acn+src_id)->prev_trans_id = 1;
    // }
    if(txn_code < 4 && txn_code >0)
    {
        txn* curr =  (acn+src_id)->trans;
        txn* nw=(txn*) malloc(sizeof(txn));
        nw->next=NULL;
        nw->amt=amt;
        nw->txn_id=txn_code;   
        txn_code = 0; 
        if(curr==NULL)
        {
          (acn+src_id)->trans=nw;
          return;
        }   
        else
        {
          while(curr->next!=NULL)
          {
            curr= curr->next;
          }
          curr->next=nw;
          return;          
         }
    }
    else if(txn_code == 4)
    {
        insertTxn(acn,src_id,dest_id,2,amt);//withdraw from src_id 
        insertTxn(acn,dest_id,src_id,1,amt);//deposit in dest_id;
        return;
    }
  }
  return;
}
void print_trxns(txn* trans)
{
  if(trans==NULL)
  {
    printf("\n");
    return;
  }
  else
  {
      printf("==>(id:%d,amt:%.2lf) ",trans->txn_id,trans->amt);
      print_trxns(trans->next);
      return;
  }
  
}
void pretty_print(AC* ac,int id)
{
  printf("%d\t%.2lf",(id+START_INDEX),(ac+id)->bal);
  print_trxns((ac+id)->trans);
  return;
}
int main(int argc,char** argv)
{
	//  int fd, ctr;
  //    unsigned long size, bytes_read = 0, hash_count;
  //    char *buff, *cbuff;
  //    unsigned long *hashes;
     if(argc != 5){
            USAGE_EXIT("not enough parameters");
      }  
     FILE* acc_file= fopen(argv[1],"r");
     if(acc_file==NULL)
     {
       printf("Unable to read the specified account file\n");
       exit(-1);
     }
    FILE* txn_file =fopen(argv[2],"r");
    if(txn_file==NULL)
    {
      printf("Unable to read the specified transaction file\n");
      exit(-1);
    }
    ///files can be read.
    int nThreads=atoi(argv[4]);
    if(nThreads <=0 || nThreads >MAX_THREADS)
    {
      printf("ThreadNumberOutOfRange Exception ");
      exit(-1);
    }
    int nTrans =atoi(argv[3]);
    if(nTrans <=0 )
    {
      printf("TransactionNumberOutOfRange Exception ");
      exit(-1);
    }
    AC* acns =(AC*)malloc(10000*sizeof(AC));
    //bzero(acns,10000*sizeof(AC*));
    for(int i =0;i<10000;i++)
    {
      int id;
      double bal;
      fscanf(acc_file,"%d %lf",&id,&bal);
      (acns+i)->bal=bal;
      (acns+i)->prev_trans_id=0;
    }
    //accounts file already Read;
  //Now make the data Structure
    for (int i=0;i<nTrans;i++)
    {
      int sNo,txnCode,ac1,ac2;
      double amt;
      txnCode= 0;
      fscanf(txn_file,"%d %d %lf %d %d",&sNo,&txnCode,&amt,&ac1,&ac2);
      insertTxn(acns,ac1-START_INDEX,ac2-START_INDEX,txnCode,amt);
    }
    //all files read properly
    // //
    // for(int i=0;i<10000;i++)
    // pretty_print(acns,i);
    //
    fclose(acc_file);
    fclose(txn_file);
    //file stream closed
    struct thread_param* params;
    params = malloc(nThreads*sizeof(struct thread_param));
    bzero(params,nThreads*sizeof(struct thread_param));
    // pthread_t ids[nThreads];//create array of pthreads
    for (int ctr=0;ctr<nThreads;ctr++)
    {
      (params+ctr)->skip=nThreads;
      (params+ctr)->acn=acns;
      (params+ctr)->i = ctr;
      if(pthread_create(&(params+ctr)->tid,NULL,calculateIt,(params+ctr))!=0)
        {
          perror("pthread_create");
          exit(-1);
        }      
    }
   for(int ctr=0;ctr < nThreads;ctr++){
   struct thread_param* paramq = params +ctr;
   pthread_join(paramq->tid,NULL);
   }
       //
    // for(int i=0;i<10000;i++)
    // pretty_print(acns,i);

///////////////
 for(int i = 0; i< 10000;i++)
 {
   printf("%d %lf\n",(i+START_INDEX),(acns+i)->bal);
 }
 free(acns);
 free(params);

}