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

class Construct
{
public:
   //--- Constructor
   Construct(void);
   
   //--- Destructor
   virtual ~Construct(void);
   
   //--- Register Construct Type To The Right Construct Factory
   static void RegisterType(ConstructType *Type, ConstructFactory *Factory);
   
   //--- Register Construct Type To The Right Construct Monitor
   static void RegisterMonitor(ConstructType *Type, ConstructMonitor *Monitor);
   
   //--- Return Key Variables To Check If Construct Meet Requirements --- Validation Happens Elsewhere
   static ConstructPreCheckInfo *PreCheck(ConstructType *Type, ConstructParameters *Parameters);
   
   //--- Find The Corresponding Construct Factory And Get Factory To Create The Construct
   static Construct *create(ConstructType *Type, ConstructParameters *Parameters);
   
   //--- Getters
   ConstructKey         *GetConstructKey(void)         const;
   ConstructParameters  *GetConstructParameters(void)  const;
   ConstructType        *GetConstructType(void)        const;
   ConstructRollingInfo *GetConstructRollingInfo(void) const;
   ConstructResultInfo  *GetConstructResultInfo(void)  const;

   //--- Setters
   void SetConstructParameters(ConstructParameters *InputParameters);

   //--- Main Operation
   ConstructTradePool *GetConstructTradePool(void);
   void Update(void);

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
   
   virtual void FillTradePool(void) = NULL;
   
   //--- Validation
   virtual bool IsConstructValid(void)             const = NULL;
   virtual bool IsConstructKeyValid(void)          const = NULL;
   virtual bool IsConstructParametersValid(void)   const = NULL;
   virtual bool IsConstructTypeValid(void)         const = NULL;
   
private:
   static CHashMap<ConstructType*, ConstructFactory*> *GetConstructFactories() {
      static CHashMap<ConstructType*, ConstructFactory*> *ConstructFactories;
      return ConstructFactories;
   };
};

#endif