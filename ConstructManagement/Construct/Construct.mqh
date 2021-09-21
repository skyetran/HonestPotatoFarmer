#ifndef CONSTRUCT_H
#define CONSTRUCT_H

#include <Generic\HashMap.mqh>

#include "../../General/PositionManagementHyperParameters.mqh"
#include "../../OrderManagement/ConstructTradePool.mqh"
#include "Key.mqh"
#include "Parameters.mqh"
#include "PreCheckInfo.mqh"
#include "ResultInfo.mqh"
#include "RollingInfo.mqh"
#include "Type.mqh"

class ConstructFactory;

class ConstructMonitor;

class Construct
{
public:
   //--- Main Constructor
   Construct(void);
   
   //--- Destructor
   virtual ~Construct(void);
   
   //--- Register Construct Type To The Right Construct Factory
   static void RegisterFactory(ConstructType *InputType, ConstructFactory *InputFactory);
   
   //--- Register Construct Type To The Right Construct Monitor
   static void RegisterMonitor(ConstructType *InputType, ConstructMonitor *InputMonitor);
   
   //--- Return Key Variables To Check If Construct Meet Requirements
   static ConstructPreCheckInfo *PreCheck(ConstructType *InputType, ConstructParameters *InputParameters);
   
   //--- Find The Corresponding Construct Factory And Validate The Construct
   static bool Validate(ConstructType *InputType, ConstructParameters *InputParameters, const int InputEntryPosition);
   
   //--- Find The Corresponding Construct Factory And Get Factory To Create The Construct
   static Construct *create(ConstructType *InputType, ConstructParameters *InputParameters, const int InputEntryPosition);
   
   //--- Getters
   ConstructTradePool   *GetConstructTradePool(void)   const;
   ConstructKey         *GetConstructKey(void)         const;
   ConstructType        *GetConstructType(void)        const;
   ConstructParameters  *GetConstructParameters(void)  const;
   ConstructRollingInfo *GetConstructRollingInfo(void) const;
   ConstructResultInfo  *GetConstructResultInfo(void)  const;

   //--- Main Operations
   //--- Find The Right Monitor And Run OnTick Update
   void UpdateTradePool(void);
   void UpdateFinance(void);
   void UpdateRisk(void);
   
   //--- Report Result To The Right Accountant Based On EntryPositionID & Construct Type
   void Report(void);

protected:
   //--- External Attributes
   PositionManagementHyperParameters *PMHP;
   
   //--- Core Information
   ConstructTradePool    *Pool;
   ConstructKey          *Key;
   ConstructType         *Type;
   ConstructParameters   *Parameters;
   ConstructRollingInfo  *RollingInfo;
   ConstructResultInfo   *ResultInfo;
   
private:
   static CHashMap<ConstructType*, ConstructFactory*> *GetConstructFactories(void) {
      static CHashMap<ConstructType*, ConstructFactory*> *ConstructFactories;
      return ConstructFactories;
   };
   
   static CHashMap<ConstructType*, ConstructMonitor*> *GetConstructMonitors(void) {
      static CHashMap<ConstructType*, ConstructMonitor*> *ConstructMonitors;
      return ConstructMonitors;
   }
};

#endif