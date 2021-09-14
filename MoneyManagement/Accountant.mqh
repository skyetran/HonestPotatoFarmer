#ifndef ACCOUNTANT_H
#define ACCOUNTANT_H

#include <Generic\ArrayList.mqh>

#include "../ConstructManagement/Construct/Construct.mqh"

#define MAX_CAPACITY 10000

class Accountant
{
public:
   //--- Constructor
   Accountant(void);
   
   //--- Destructor
   ~Accountant(void);
   
   //--- Log Trading Result
   void LogTradingResult(Construct *construct);
   
protected:
   CArrayList<double> ProfitDatabase;
   CArrayList<double> MaxRishDatabase;
   
   void LogProfit(Construct *construct);
   void LogMaxRisk(Construct *construct);
};

#endif