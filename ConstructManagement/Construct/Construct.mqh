#ifndef CONSTRUCT_H
#define CONSTRUCT_H

#include <Generic\HashMap.mqh>

#include "../../General/PositionManagementHyperParameters.mqh"
#include "../../OrderManagement/ConstructTradePool.mqh"
#include "ConstructKey.mqh"
#include "ConstructParameters.mqh"
#include "ConstructPreCheckInfo.mqh"
#include "ConstructResultInfo.mqh"
#include "ConstructRollingInfo.mqh"
#include "ConstructType.mqh"

class ConstructFactory;

class ConstructMonitor;

class Accountant;

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
   
   //--- Register Construct Type To The Right Accountant
   static void RegisterAccountant(ConstructType *InputType, Accountant* InputAccountant);
   
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
   
   static CHashMap<ConstructType*, Accountant*> *GetAccountants(void) {
      static CHashMap<ConstructType*, Accountant*> *Accountants;
      return Accountants;
   }
};

#endif