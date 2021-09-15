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
   //--- Constructor
   Construct(void);
   
   //--- Destructor
   virtual ~Construct(void);
   
   //--- Register Construct Type To The Right Construct Factory
   static void RegisterType(ConstructType *InputType, ConstructFactory *InputFactory);
   
   //--- Register Construct Type To The Right Construct Monitor
   static void RegisterMonitor(ConstructType *InputType, ConstructMonitor *InputMonitor);
   
   //--- Return Key Variables To Check If Construct Meet Requirements --- Validation Happens Elsewhere
   static ConstructPreCheckInfo *PreCheck(ConstructType *InputType, ConstructParameters *InputParameters);
   
   //--- Find The Corresponding Construct Factory And Get Factory To Create The Construct
   static Construct *create(ConstructType *InputType, ConstructParameters *InputParameters);
   
   //--- Getters
   ConstructKey         *GetConstructKey(void)         const;
   ConstructParameters  *GetConstructParameters(void)  const;
   ConstructType        *GetConstructType(void)        const;
   ConstructRollingInfo *GetConstructRollingInfo(void) const;
   ConstructResultInfo  *GetConstructResultInfo(void)  const;
   ConstructTradePool   *GetConstructTradePool(void)   const;

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
   ConstructParameters   *Parameters;
   ConstructPreCheckInfo *PreCheckInfo;
   ConstructResultInfo   *ResultInfo;
   ConstructRollingInfo  *RollingInfo;
   ConstructType         *Type;
   
   //--- Validation
   bool IsConstructValid(void)           const;
   bool IsConstructKeyValid(void)        const;
   bool IsConstructParametersValid(void) const;
   bool IsConstructTypeValid(void)       const;
   
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