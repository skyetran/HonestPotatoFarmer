#ifndef POSITION_MANAGEMENT_HYPER_PARAMETERS_H
#define POSITION_MANAGEMENT_HYPER_PARAMETERS_H

#include "GlobalHelperFunctions.mqh"

#define MIN_SLIPPAGE                3
#define MAX_SLIPPAGE                20
#define MIN_INTERVAL_SIZE_INCREMENT 2
#define MIN_OUT_OF_BOUND_BUFFER     30

class PositionManagementHyperParameters
{
public:
   //--- Get Singleton Instance
   static PositionManagementHyperParameters *GetInstance(void);
   
   //--- Setters And Validation
   bool LogSlippage(const int &InputSlippage);
   bool LogIntervalSizeIncrement(const int &InputIntervalSizeIncrement);
   bool LogOutOfBoundBuffer(const int &InputOutOfBoundBuffer);

   //--- Getters
   int    GetSlippageInPts(void)           const;
   double GetSlippageInPrice(void)         const;
   int    GetIntervalSizeIncrement(void)   const;
   int    GetOutOfBoundBufferInPts(void)   const;
   double GetOutOfBoundBufferInPrice(void) const;

private:
   //--- Main Constructor --- Singleton
   PositionManagementHyperParameters(void);
   
   //--- Hyperparamenters
   int Slippage;
   int IntervalSizeIncrement;
   int OutOfBoundBuffer;
   
   static PositionManagementHyperParameters *Instance;
   
   //--- Validation
   bool IsSlippageValid(const int &InputSlippage)                           const;
   bool IsIntervalSizeIncrementValid(const int &InputIntervalSizeIncrement) const;
   bool IsOutOfBoundBufferValid(const int &InputOutOfBoundBuffer)           const;
};

PositionManagementHyperParameters* PositionManagementHyperParameters::Instance = NULL;

#endif