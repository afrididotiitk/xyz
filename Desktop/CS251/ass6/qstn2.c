#include<stdio.h>
#include<stdlib.h>
#include<sys/time.h>
#include<string.h>
#include<pthread.h>
#include<math.h>
#include<fcntl.h>
#define SEED 0x7457

#define MAX_THREADS 64
#define USAGE_EXIT(s) do{ \
                             printf("Usage: %s <# of elements> <# of threads> \n %s\n", argv[0], s); \
                            exit(-1);\
                    }while(0);

#define TDIFF(start, end) ((end.tv_sec - start.tv_sec) * 1000000UL + (end.tv_usec - start.tv_usec))

typedef struct txn_param
{
    int opt;
    double amount;
    struct txn_param *next;
}txn;
typedef struct account_detail
{
//    int acc_no;
    double bal;
    txn * mtp;
}AC;
struct thread_param
{
    pthread_t tid;
    struct account_detail* acc;
    int skip;
    int index;

};

void calculation(AC* account, txn* trans, int id)
{
    if( trans ==NULL)
        return;
    else
    {        //txn* trans1= trans;


            if (trans->opt==1)
                (account+id)->bal=(account+id)->bal + 0.99*(trans->amount);
            else if (trans->opt==2)
                (account+id)->bal=(account+id)->bal-1.01*(trans->amount);
            else if(trans->opt==3)
                (account+id)->bal=((account+id)->bal)*1.071;
            calculation(account,trans->next,id);
//            free(trans);
            return;
        //free((account+id)->next);
        //(account+id)->next=NULL;
    }
}
void *threading(void *arg)
{
    struct thread_param * params=(struct thread_param*) arg;
    int i = params->index;
    int skip=params->skip;
    for(int j=i;j<10000;)
    {
        calculation(params->acc,(params->acc+j)->mtp,j);
        j=j+skip;
    }
    return NULL;
}
void insertion(AC *account, int acc1,int opcode,double amount)
{

    if(account!=NULL){
        txn *curr;
        txn *trans1=(txn*)malloc(sizeof(txn));
        trans1->opt=opcode;
        trans1->amount=amount;
        trans1->next=NULL;
        //trans1=malloc
        if ((account+acc1-1001)->mtp==NULL)
            (account+acc1-1001)->mtp=trans1;
        else
        {
            curr = (account+acc1-1001)->mtp;
            while (curr->next!=NULL)
                curr=curr->next;
            curr->next =trans1;
        }


        return;
    }
}

int main(int argc, char **argv)
{
    struct timeval start, end;
    int  num_txn, ctr, num_threads;
//  int max;
    //`int max_index;
    AC *account;
    account=(AC*)malloc(10000*sizeof(AC));
    if(account==NULL)
    {
        printf("error");
        exit(-1);
    }

    if(argc !=5)
        USAGE_EXIT("not enough parameters");
    //file reading taking input
    FILE *accnt= fopen(argv[1],"r");
    if (!accnt){
        printf("error opening file");
        exit(-1);
    }
    for(int i=0;i<10000;i++)
    {
        int tmp;
        fscanf(accnt,"%d %lf\n", &tmp,&(account+i)->bal);
    }
    FILE *trxn = fopen(argv[2], "r");
    if (!trxn)
    {
        printf("error reading transaction file");
        exit(-1);
    }

    num_txn = atoi(argv[3]);
    if(num_txn <0)
        USAGE_EXIT("invalid num elements");
    if(num_txn==0)
        {
            FILE* final_acc = fopen("final_acc.txt","w");
                for(int i = 0; i< 10000;i++)
                {
                fprintf(final_acc,"%d %.2lf\n",(i+1001),(account+i)->bal);
                }
            exit(0);
        }
    num_threads = atoi(argv[4]);
    if(num_threads <=0 || num_threads > MAX_THREADS){
        USAGE_EXIT("invalid num of threads");
    }
//storing the transaction details
    for(int i=0;i<num_txn;i++)
    {
        int s_no,type,acc1,acc2;
        double amt;
        fscanf(trxn, "%d %d %lf %d %d\n",&s_no,&type,&amt,&acc1,&acc2);

        if (type!=4)
            insertion (account,acc1,type,amt);

        else
        {
            insertion(account,acc1,2,amt);
            insertion(account,acc2,1,amt);
        }
    }

    struct thread_param* params;

    params = malloc(num_threads * sizeof(struct thread_param));
    bzero(params, num_threads * sizeof(struct thread_param));

    gettimeofday(&start, NULL);

    /*Partion data and create threads*/
    for(int ctr=0; ctr < num_threads; ++ctr)
    {
        struct thread_param *paramq = params + ctr;

        paramq->skip = num_threads;
        paramq->acc= account ;
        paramq->index=ctr;

        if(pthread_create(&paramq->tid, NULL, threading, paramq) != 0){
            perror("pthread_create");
            exit(-1);
        }

    }
    /*Wait for threads to finish their execution*/
    for(ctr=0; ctr < num_threads; ++ctr){
        struct thread_param *paramw = params + ctr;
        pthread_join(paramw->tid, NULL);
        //    if(ctr == 0 || (ctr > 0 && param->max > max)){
        //       max = param->max;
        //     max_index = param->max_index;
        //}
    }
    // if(max!=1)
    // printf("Max = %d at index=%d\n", max , max_index);
//  else printf("sorry! ,no prime generated in random data");
    gettimeofday(&end, NULL);
//    printf("Time taken = %ld microsecs\n", TDIFF(start, end));
    //////////////////===================================================
    for (int i=0;i<10000;i++)
      printf("%d %lf\n",(i+1001),(account+i)->bal);
	/*FILE* final_acc = fopen("final_acc.txt","w");
	 for(int i = 0; i< 10000;i++)
	 {
   	fprintf(final_acc,"%d %.2lf\n",(i+1001),(account+i)->bal);
	 }*/
    //free(params);
}
