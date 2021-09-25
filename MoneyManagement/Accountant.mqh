#ifndef ACCOUNTANT_H
#define ACCOUNTANT_H

#include <Generic\ArrayList.mqh>
#include <Generic\HashMap.mqh>

#include "../ConstructManagement/Construct/Construct.mqh"
#include "../ConstructManagement/Construct/Attributes/Type.mqh"

#define MAX_CAPACITY 10000

class Accountant
{
public:
   //--- Constructor
   Accountant(int InputEntryPositionID);
   
   //--- Destructor
   ~Accountant(void);
   
   //--- Log Trading Result
   void LogTradingResult(ConstructType *Type);
   
protected:
   int EntryPositionID;
   
   CHashMap<ConstructType*, CArrayList<double>*> ProfitDatabase;
   CHashMap<ConstructType*, CArrayList<double>*> MaxRiskDatabase;
   
   void LogProfit(ConstructType *Type);
   void LogMaxRisk(ConstructType *Type);
};

#endif