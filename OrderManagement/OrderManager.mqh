#ifndef RAW_ORDER_MANAGER_H
#define RAW_ORDER_MANAGER_H

#include <Generic\ArrayList.mqh>
#include <Generic\HashMap.mqh>

#include "ConstructTradePool.mqh"

class Construct;

class OrderManager
{
public:
   //--- Main Constructor
   OrderManager(void);
   
   //--- Destructor
   ~OrderManager(void);
   
   //--- OnTick Function
   void ManageNewRequestStream(void);
   
   //--- Operations
   void AddTradePool(CArrayList<Construct*> *InputConstructs);
   void AddTradePool(Construct *InputConstruct);
   void AddTradePool(CArrayList<ConstructTradePool*> *InputTradePools);
   void AddTradePool(ConstructTradePool *InputTradePool);
   
   CArrayList<MqlTradeRequestWrapper*> *PoolRawMarketRequest(void);
   CArrayList<MqlTradeRequestWrapper*> *PoolLimitRequest(void);
   CArrayList<MqlTradeRequestWrapper*> *PoolStopLimitRequest(void);
   CArrayList<MqlTradeRequestWrapper*> *PoolStopRequest(void);
   
   CArrayList<MqlTradeRequestWrapper*> *GetLongRequest(void);
   CArrayList<MqlTradeRequestWrapper*> *GetShortRequest(void);
   
   void LogExecutedRequest(MqlTradeRequestWrapper *InputCombinedRequest, MqlTradeResultWrapper *InputCombinedResult);
   
   void MakeFullyHedged(void);
   
   //--- Getters
   double GetCurrentPnL(void);
   double GetPositiveSlippagePnL(void);
   
   bool IsFullyHedged(void);
   
private:
   //--- External Objects
   IndicatorProcessor *IP;
   PositionManagementHyperParameters *PMHP;
   GeneralSettings *GS;
   
   //--- Subcribed Construct Trade Pools
   CArrayList<ConstructTradePool*> *TradePoolList;
   
   //--- Log Combined Trade Requests Storage
   CHashMap<MqlTradeRequestWrapper*, CArrayList<MqlTradeRequestWrapper*>*> *CombinedTradeRequestNavIntermediate;
   CHashMap<MqlTradeRequestWrapper*, CArrayList<ConstructTradePool*>*>     *CombinedTradeRequestNav;
   CHashMap<MqlTradeRequestWrapper*, CArrayList<double>*>                  *CombinedTradeRequestVol;
   
   //--- Session History
   CHashMap<MqlTradeRequestWrapper*, MqlTradeResultWrapper*> *RequestResultSession;
   CHashMap<MqlTradeRequestWrapper*, ENUM_POOLING_STATUS>    *RequestSessionExpiration;
   
   //--- Current
   CArrayList<MqlTradeRequestWrapper*> *RawMarketRequestList;
   CArrayList<MqlTradeRequestWrapper*> *LimitRequestList;
   CArrayList<MqlTradeRequestWrapper*> *StopLimitRequestList;
   CArrayList<MqlTradeRequestWrapper*> *StopRequestList;
   CArrayList<MqlTradeRequestWrapper*> *LongRequestList;
   CArrayList<MqlTradeRequestWrapper*> *ShortRequestList;
   
   //--- Helper Functions: ManageNewRequestStream
   void CombineRawMarketRequestList(void);
   void CombineLimitRequestList(void);
   void CombineStopLimitRequestList(void);
   void CombineStopRequestList(void);
   
   //--- Helper Functions: CombineOperations
   CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *GetRawMarketRequestOriginMapping(void);
   CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *GetLimitRequestOriginMapping(void);
   CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *GetStopLimitRequestOriginMapping(void);
   CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *GetStopRequestOriginMapping(void);
   void MergeOriginMapping(CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *InputSource, CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *InputDestination);
   
   void CombineRequest(CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *InputRequestOriginMapping, CArrayList<MqlTradeRequestWrapper*> *OutputCombinedRequestList, CHashMap<MqlTradeRequestWrapper*, CArrayList<MqlTradeRequestWrapper*>*> *OutputCombinedRequestNavIntermediate, CHashMap<MqlTradeRequestWrapper*, CArrayList<ConstructTradePool*>*> *OutputCombinedRequestNav, CHashMap<MqlTradeRequestWrapper*, CArrayList<double>*> *OutputCombinedRequestVol);
   
   CHashMap<string, CArrayList<MqlTradeRequestWrapper*>*> *GetIntermediateCombinedRequestList(CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *InputRequestOriginMapping);
   bool IsNewGroupingAttributeRequest(CHashMap<string, CArrayList<MqlTradeRequestWrapper*>*> *InputIntermediateCombinedRequestList, MqlTradeRequestWrapper *InputRequest);
   void AddNewGroupingAttributeRequest(CHashMap<string, CArrayList<MqlTradeRequestWrapper*>*> *InputIntermediateCombinedRequestList, MqlTradeRequestWrapper *InputRequest);
   void AddExistedGroupingAttributeRequest(CHashMap<string, CArrayList<MqlTradeRequestWrapper*>*> *InputIntermediateCombinedRequestList, MqlTradeRequestWrapper *InputRequest);
   string GetRequestGroupingAttributes(MqlTradeRequestWrapper *InputRequest);
   
   MqlTradeRequestWrapper *GetCombinedRequest(CArrayList<MqlTradeRequestWrapper*> *SameGroupingAttributeRequestList);
   CArrayList<ConstructTradePool*> *GetCombinedRequestOriginMapping(CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *InputRequestOriginMapping, CArrayList<MqlTradeRequestWrapper*> *SameGroupingAttributeRequestList);
   CArrayList<double> *GetCombinedRequestVolumeMapping(CArrayList<MqlTradeRequestWrapper*> *SameGroupingAttributeRequestList, MqlTradeRequestWrapper *InputCombinedRequest);
   
   MqlTradeRequestWrapper *GetFirstRequest(CArrayList<MqlTradeRequestWrapper*> *InputRequestList);
   void MergeRequest(MqlTradeRequestWrapper *InputSource, MqlTradeRequestWrapper *InputDestination);
   string GetRandomString(void);
   
   //--- Helper Functions: ManageNewRequestStream
   void ManagePoolRawMarketRequestList(CArrayList<MqlTradeRequestWrapper*> *InputRequestList);
   void ManagePoolLimitRequestList(CArrayList<MqlTradeRequestWrapper*> *InputRequestList);
   void ManagePoolStopLimitRequestList(CArrayList<MqlTradeRequestWrapper*> *InputRequestList);
   void ManagePoolStopRequestList(CArrayList<MqlTradeRequestWrapper*> *InputRequestList);
   
   void ManagePoolRawMarketRequestList(MqlTradeRequestWrapper *InputRequest);
   void ManagePoolLimitRequestList(MqlTradeRequestWrapper *InputRequest);
   void ManagePoolStopLimitRequestList(MqlTradeRequestWrapper *InputRequest);
   void ManagePoolStopRequestList(MqlTradeRequestWrapper *InputRequest);
   
   void ManageNewRequestGeneralProperties(CArrayList<MqlTradeRequestWrapper*> *InputRequestList);
   
   void ManageRequestDirection(CArrayList<MqlTradeRequestWrapper*> *InputRequestList);
   void ManageRequestDirection(MqlTradeRequestWrapper *InputRequest);
   void ManageLongRequest(MqlTradeRequestWrapper *InputRequest);
   void ManageShortRequest(MqlTradeRequestWrapper *InputRequest);
   
   void ManageNewRequestPoolingStatus(CArrayList<MqlTradeRequestWrapper*> *InputRequestList);
   void ManageNewRequestPoolingStatus(MqlTradeRequestWrapper *InputRequest);
   
   void ManageCombinedRequestNavIntermediate(CHashMap<MqlTradeRequestWrapper*, CArrayList<MqlTradeRequestWrapper*>*> *InputCombinedRequestNavIntermediateBuffer);
   void ManageCombinedRequestNav(CHashMap<MqlTradeRequestWrapper*, CArrayList<ConstructTradePool*>*> *InputCombinedRequestNavBuffer);
   void ManageCombinedRequestVol(CHashMap<MqlTradeRequestWrapper*, CArrayList<double>*> *InputCombinedRequestVolBuffer);
   
   //--- Helper Functions: ManagePoolRawMarketRequestLists/ManagePoolLimitRequestLists/ManagePoolStopLimitRequestLists/ManagePoolStopRequestLists
   CArrayList<MqlTradeRequestWrapper*> *GetCombinedRequestList(CArrayList<MqlTradeRequestWrapper*> *InputRequestList);
   
   //--- Helper Functions: PoolRawMarketRequest/PoolLimitRequest/PoolStopLimitRequest/PoolStopRequest
   CArrayList<MqlTradeRequestWrapper*> *GetUnpoolRequests(CArrayList<MqlTradeRequestWrapper*> *RequestList);
   bool IsRequestUnpool(MqlTradeRequestWrapper *InputRequest);
   bool IsRequestAlreadyPool(MqlTradeRequestWrapper *InputRequest);
   ENUM_POOLING_STATUS GetPoolingStatus(MqlTradeRequestWrapper *InputRequest);
   void SetRequestPoolingStatusToAlreadyPool(MqlTradeRequestWrapper *InputRequest);
};

#endif