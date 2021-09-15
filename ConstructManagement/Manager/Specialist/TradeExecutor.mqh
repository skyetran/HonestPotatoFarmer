#ifndef CONSTRUCT_TRADE_EXECUTOR_H
#define CONSTRUCT_TRADE_EXECUTOR_H

#include "../ConstructManager.mqh"

class ConstructTradeExecutor : public ConstructManager
{
public:
   //--- Main Constructor
   ConstructTradeExecutor(void);
   
   //--- Destructor
   ~ConstructTradeExecutor(void);
   
   //--- Only Operation
   void Execute(void);

private:
   
};

#endif