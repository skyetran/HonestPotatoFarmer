#ifndef POSITION_MANAGEMENT_HYPER_PARAMETERS_H
#define POSITION_MANAGEMENT_HYPER_PARAMETERS_H

#define MIN_SLIPPAGE                3
#define MAX_SLIPPAGE                20
#define MIN_INTERVAL_SIZE_INCREMENT 2
#define MIN_MIN_LEVEL               3
#define MIN_OUT_OF_BOUND_BUFFER     30

class PositionManagementHyperParameters
{
public:
   //--- Get Singleton Instance
   static PositionManagementHyperParameters *GetInstance(void);
   
   //--- Setters And Validation
   bool LogSlippage(const int &InputSlippage);
   bool LogIntervalSizeIncrement(const int &InputIntervalSizeIncrement);
   bool LogMinLevel(const int &InputMinLevel);
   bool LogOutOfBoundBuffer(const int &InputOutOfBoundBuffer);

   //--- Getters
   int GetSlippage(void);
   int GetIntervalSizeIncrement(void);
   int GetMinLevel(void);
   int GetOutOfBoundBuffer(void);

private:
   //--- Main Constructor --- Singleton
   PositionManagementHyperParameters(void);
   
   //--- Hyperparamenters
   int Slippage;
   int IntervalSizeIncrement;
   int MinLevel;
   int OutOfBoundBuffer;
   
   static PositionManagementHyperParameters *Instance;
   
   //--- Validation
   bool IsSlippageValid(const int &InputSlippage);
   bool IsIntervalSizeIncrementValid(const int &InputIntervalSizeIncrement);
   bool IsMinLevelValid(const int &InputMinLevel);
   bool IsOutOfBoundBufferValid(const int &InputOutOfBoundBuffer);
};

PositionManagementHyperParameters* PositionManagementHyperParameters::Instance = NULL;

#endif