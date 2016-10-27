#include<stdio.h>
#include<stdlib.h>
#include<iostream>
#include"mex.h"
#include<cmath>
#include<math.h>
#include <windows.h>
using namespace std;
int normaliseArray(double *inputVector, int *outputVector, int vectorLength)
{
    FILE *fp = fopen("H.txt","a+");
  double minVal = 0;
  double maxVal = 0;
  double currentValue=0;
  int i=0;
 
  if (vectorLength > 0)
  {
    minVal = inputVector[0];
    maxVal =inputVector[0];
  
    for (i = 0; i < vectorLength; i++)
    {
      currentValue = inputVector[i];
      outputVector[i] = currentValue;
      
      if (currentValue < minVal)
      {
        minVal = currentValue;
      }
      else if (currentValue > maxVal)
      {
        maxVal = currentValue;
      }
    }/*for loop over vector*/
 //   cout<<minVal<<endl;
    for (i = 0; i < vectorLength; i++)
    {
      outputVector[i] = (int)((inputVector[i] - minVal)/0.2);
     // cout<<inputVector[i]<<"\t"<<outputVector[i] <<"\n";
  //    fprintf(fp,"%d\t",outputVector[i]);
    }
//    cout<<minVal<<"\t"<<maxVal<<endl;
    maxVal = (maxVal - minVal)/0.2 + 1;
  }
//  fprintf(fp,"\n");
  fclose(fp);
  return (int)maxVal;
}/*normaliseArray(double*,double*,int)*/

double get_H_mix(double *data,int Ninp, int vectorLength)
{
     FILE *fp = fopen("H.txt","a+");
    double **inp =  (double**)calloc(sizeof(double*),Ninp);
    for (int i = 0;i<Ninp;i++){
        inp[i] =  (double *) calloc(vectorLength,sizeof(double));
    }
    for (int i = 0;i<Ninp;i++){
        for(int j = 0;j<(vectorLength);j++){
            inp[i][j] = data[i*(vectorLength)+j];  
        }
          
    }
    int ** normVec;
    normVec = (int**)calloc(sizeof(int*),Ninp);
    int * numStates;
    numStates = (int*)calloc(sizeof(int),Ninp);
    for (int i = 0;i<Ninp;i++){
        normVec[i] =  (int *) calloc(vectorLength,sizeof(int));
    }
    
    int jointNumStates = 1;
    for (int i = 0;i<Ninp;i++){
        numStates[i] = normaliseArray(inp[i],normVec[i],vectorLength);
        jointNumStates *= numStates[i];
       // cout<<"total "<<numStates[i]<<" states"<<endl;
        
    }
   // cout<<"total "<<jointNumStates<<" states"<<endl;
    int **StateCounts;
    StateCounts=(int**)calloc(sizeof(int*),Ninp);
    for (int i = 0;i<Ninp;i++){
        StateCounts[i] = (int *) calloc(numStates[i],sizeof(int));
    }
    int * jointStateCounts;
   jointStateCounts = (int *) calloc(jointNumStates,sizeof(int));
 // double**StateProbs;
  //  StateProbs=(double**)calloc(sizeof(double*),Ninp);
  //  for (int i = 0;i<Ninp;i++){
//        StateProbs[i] = (double *) calloc(numStates[i],sizeof(double));
 //   }
    double* jointStateProbs;
    jointStateProbs= (double *) calloc(jointNumStates,sizeof(double));
    double Length = vectorLength;
    /* Optimised for number of FP operations now O(states) instead of O(vectorLength) */
    int idx = 0;
    int *bias = (int*)calloc(sizeof(int),Ninp);
    bias[0] = 1;
    for (int i = 1;i<Ninp;i++){
        bias[i] = bias[i-1]*numStates[i-1];
    }
    for (int j = 0; j < vectorLength; j++){
        idx = 0;
        for (int i = 0;i<Ninp;i++){
  //          StateCounts[i][normVec[i][j]] += 1;
            idx += normVec[i][j]*bias[i];
        }
        jointStateCounts[idx] += 1;
    }
    //FILE*fp =  fopen("joint.txt","a+");
 //   for (int i = 0; i<jointNumStates;i++){
 //       fprintf(fp,"%d\t",jointStateCounts[i]);
//    }
////     fprintf(fp,"\n");
 //    fclose(fp);
    double H = 0;
//    for (int i = 0;i<Ninp;i++){
//        for (int j = 0; j < numStates[i]; j++){
//            StateProbs[i][j] = StateCounts[i][j] /Length;
 //       }
 //   }
    for (int i = 0; i < jointNumStates; i++)
    {
        jointStateProbs[i] = jointStateCounts[i] / Length;
    }
    const double epi = 0.0000001;double val = 0;
    for (int  i = 0; i<jointNumStates;i++){
      //  cout<<jointStateProbs[i]<<"\t";
      //  fprintf(fp,"%f\n",jointStateProbs[i]);
        val = jointStateProbs[i];
     //   cout<<val<<endl;
        if(val>0){
        (H) += (-(val)*log(val));
        }
    }
   // cout<<H<<endl;
    for (int i = 0;i<Ninp;i++){
         free(normVec[i]);
         free(StateCounts[i]);
    //    free(StateProbs[i]);
         free(inp[i]);
     }
   free(bias);bias = NULL;
     free(normVec);normVec = NULL;
    free(StateCounts);StateCounts = NULL;
//    free(StateProbs);StateProbs = NULL;
     free(jointStateCounts);jointStateCounts =NULL;
     free(jointStateProbs);jointStateProbs = NULL;
     free(inp);inp=NULL;
    // Sleep(1000);
     fclose(fp);
     return H;
}

void mexFunction(int nlhs, mxArray *plhs[],int nrhs, const mxArray *prhs[]) //OMP(y,d,t)
{ 
   // FILE *fp = fopen("H.txt","a+");
    double* data = mxGetPr(prhs[0]);
    double* Ninp = mxGetPr(prhs[1]);
    double* Nsamples = mxGetPr(prhs[2]);
    double* H;
   
    
   // f//close(fp);
    plhs[0]=mxCreateDoubleMatrix(1,1,mxREAL);
    H = mxGetPr(plhs[0]);
   * H=get_H_mix(data,*Ninp,*Nsamples);
   // cout<<H<<endl;

   // 
   // fprintf(fp,"%f\n",H);
//    cout<<"hello world"<<endl;
   // fclose(fp);
}