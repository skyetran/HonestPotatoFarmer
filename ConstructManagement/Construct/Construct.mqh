#ifndef CONSTRUCT_H
#define CONSTRUCT_H

#include <Generic\HashMap.mqh>

#include "../../General/GlobalConstants.mqh"
#include "../../General/PositionManagementHyperParameters.mqh"
#include "../../OrderManagement/ConstructTradePool.mqh"
#include "Attributes/FullTradePool.mqh"
#include "Attributes/Key.mqh"
#include "Attributes/Parameters.mqh"
#include "Attributes/PreCheckInfo.mqh"
#include "Attributes/ResultInfo.mqh"
#include "Attributes/RollingInfo.mqh"
#include "Attributes/Type.mqh"

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
   static Construct *Create(ConstructType *InputType, ConstructParameters *InputParameters, const int InputEntryPosition);
   
   //--- Getters
   ConstructFullTradePool *GetFullConstructTradePool(void) const;
   ConstructTradePool     *GetConstructTradePool(void)     const;
   ConstructKey           *GetConstructKey(void)           const;
   ConstructType          *GetConstructType(void)          const;
   ConstructParameters    *GetConstructParameters(void)    const;
   ConstructRollingInfo   *GetConstructRollingInfo(void)   const;
   ConstructResultInfo    *GetConstructResultInfo(void)    const;
   int                     GetEntryPositionID(void)        const;
   int                     GetMultiplier(void)             const;
   
   //--- Setters
   void SetConstructKey(ConstructKey *InputConstructKey);
   void SetConstructParameters(ConstructParameters *InputConstructParameters);
   void SetEntryPositionID(const int InputEntryPositionID);
   void SetFullTradePool(ConstructFullTradePool *InputFullTradePool);
   void SetMultiplier(const int InputMultiplier);

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
   ConstructFullTradePool *FullTradePool;
   ConstructTradePool     *Pool;
   ConstructKey           *Key;
   ConstructType          *Type;
   ConstructParameters    *Parameters;
   ConstructRollingInfo   *RollingInfo;
   ConstructResultInfo    *ResultInfo;
   int                     EntryPositionID;
   int                     Multiplier;
   
private:
   static CHashMap<ConstructType*, ConstructFactory*> *ConstructFactories;
   static CHashMap<ConstructType*, ConstructMonitor*> *ConstructMonitors;

   static CHashMap<ConstructType*, ConstructFactory*> *GetConstructFactories(void) {
      return ConstructFactories;
   };
   
   static CHashMap<ConstructType*, ConstructMonitor*> *GetConstructMonitors(void) {
      return ConstructMonitors;
   }
};

CHashMap<ConstructType*, ConstructFactory*> *Construct::ConstructFactories = new CHashMap<ConstructType*, ConstructFactory*>();
CHashMap<ConstructType*, ConstructMonitor*> *Construct::ConstructMonitors  = new CHashMap<ConstructType*, ConstructMonitor*>();

#endif