#property strict

#include "../OrderManagement/OrderManager.mqh"

//--- Main Constructor
OrderManager::OrderManager(void) {
   IP   = IndicatorProcessor::GetInstance();
   PMHP = PositionManagementHyperParameters::GetInstance(); 
   GS   = GeneralSettings::GetInstance();
   
   TradePoolList = new CArrayList<ConstructTradePool*>();
   
   CombinedTradeRequestNavIntermediate = new CHashMap<MqlTradeRequestWrapper*, CArrayList<MqlTradeRequestWrapper*>*>();
   CombinedTradeRequestNav             = new CHashMap<MqlTradeRequestWrapper*, CArrayList<ConstructTradePool*>*>();
   CombinedTradeRequestVol             = new CHashMap<MqlTradeRequestWrapper*, CArrayList<double>*>();
   
   RequestResultSession     = new CHashMap<MqlTradeRequestWrapper*, MqlTradeResultWrapper*>();
   RequestSessionExpiration = new CHashMap<MqlTradeRequestWrapper*, ENUM_POOLING_STATUS>();
   
   RawMarketRequestList = new CArrayList<MqlTradeRequestWrapper*>();
   LimitRequestList     = new CArrayList<MqlTradeRequestWrapper*>();
   StopLimitRequestList = new CArrayList<MqlTradeRequestWrapper*>();
   StopRequestList      = new CArrayList<MqlTradeRequestWrapper*>();
   LongRequestList      = new CArrayList<MqlTradeRequestWrapper*>();
   ShortRequestList     = new CArrayList<MqlTradeRequestWrapper*>();
}

//--- Destructor
OrderManager::~OrderManager(void) {   
   TradePoolList.Clear();
   
   CombinedTradeRequestNavIntermediate.Clear();
   CombinedTradeRequestNav.Clear();
   CombinedTradeRequestVol.Clear();
   
   RequestResultSession.Clear();
   RequestSessionExpiration.Clear();
   
   RawMarketRequestList.Clear();
   LimitRequestList.Clear();
   StopLimitRequestList.Clear();
   StopRequestList.Clear();
   LongRequestList.Clear();
   ShortRequestList.Clear();
   
   delete TradePoolList;
   
   delete CombinedTradeRequestNavIntermediate;
   delete CombinedTradeRequestNav;
   delete CombinedTradeRequestVol;
   
   delete RequestResultSession;
   delete RequestSessionExpiration;
   
   delete RawMarketRequestList;
   delete LimitRequestList;
   delete StopLimitRequestList;
   delete StopRequestList;
   delete LongRequestList;
   delete ShortRequestList;
}

//--- OnTick Functions
void OrderManager::ManageNewRequestStream(void) {
   CombineRawMarketRequestList();
   CombineLimitRequestList();
   CombineStopLimitRequestList();
   CombineStopRequestList();
}

//--- Helper Functions: ManageNewRequestStream
void OrderManager::CombineRawMarketRequestList(void) {
   CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *RawMarketRequestOriginMapping = GetRawMarketRequestOriginMapping();
   CArrayList<MqlTradeRequestWrapper*> *CombinedRequestList = new CArrayList<MqlTradeRequestWrapper*>();
   CHashMap<MqlTradeRequestWrapper*, CArrayList<MqlTradeRequestWrapper*>*> *CombinedRequestNavIntermediate = new CHashMap<MqlTradeRequestWrapper*, CArrayList<MqlTradeRequestWrapper*>*>();
   CHashMap<MqlTradeRequestWrapper*, CArrayList<ConstructTradePool*>*> *CombinedRequestNav = new CHashMap<MqlTradeRequestWrapper*, CArrayList<ConstructTradePool*>*>();
   CHashMap<MqlTradeRequestWrapper*, CArrayList<double>*> *CombinedRequestVol = new CHashMap<MqlTradeRequestWrapper*, CArrayList<double>*>();
   
   CombineRequest(RawMarketRequestOriginMapping, CombinedRequestList, CombinedRequestNavIntermediate, CombinedRequestNav, CombinedRequestVol);
   ManagePoolRawMarketRequestList(CombinedRequestList);
   ManageNewRequestGeneralProperties(CombinedRequestList);
   ManageCombinedRequestNavIntermediate(CombinedRequestNavIntermediate);
   ManageCombinedRequestNav(CombinedRequestNav);
   ManageCombinedRequestVol(CombinedRequestVol);
   
   delete CombinedRequestVol;
   delete CombinedRequestNav;
   delete CombinedRequestNavIntermediate;
   delete CombinedRequestList;
   delete RawMarketRequestOriginMapping;
}

//--- Helper Functions: CombineOperations
CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *OrderManager::GetRawMarketRequestOriginMapping(void) {
   CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *RawMarketRequestOriginMapping = new CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*>();
   
   ConstructTradePool *TempTradePool;
   CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *TempTradePoolRawMarketRequestOriginMapping;
   for (int i = 0; i < TradePoolList.Count(); i++) {
      TradePoolList.TryGetValue(i, TempTradePool);
      TempTradePoolRawMarketRequestOriginMapping = TempTradePool.GetRawMarketRequestOriginMapping();
      MergeOriginMapping(TempTradePoolRawMarketRequestOriginMapping, RawMarketRequestOriginMapping);
      delete TempTradePoolRawMarketRequestOriginMapping;
   }
   return RawMarketRequestOriginMapping;
}

//--- Helper Functions: CombineOperations
void OrderManager::CombineLimitRequestList(void) {
   CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *LimitRequestOriginMapping = GetLimitRequestOriginMapping();
   CArrayList<MqlTradeRequestWrapper*> *CombinedRequestList = new CArrayList<MqlTradeRequestWrapper*>();
   CHashMap<MqlTradeRequestWrapper*, CArrayList<MqlTradeRequestWrapper*>*> *CombinedRequestNavIntermediate = new CHashMap<MqlTradeRequestWrapper*, CArrayList<MqlTradeRequestWrapper*>*>();
   CHashMap<MqlTradeRequestWrapper*, CArrayList<ConstructTradePool*>*> *CombinedRequestNav = new CHashMap<MqlTradeRequestWrapper*, CArrayList<ConstructTradePool*>*>();
   CHashMap<MqlTradeRequestWrapper*, CArrayList<double>*> *CombinedRequestVol = new CHashMap<MqlTradeRequestWrapper*, CArrayList<double>*>();
   
   CombineRequest(LimitRequestOriginMapping, CombinedRequestList, CombinedRequestNavIntermediate, CombinedRequestNav, CombinedRequestVol);
   ManagePoolLimitRequestList(CombinedRequestList);
   ManageNewRequestGeneralProperties(CombinedRequestList);
   ManageCombinedRequestNavIntermediate(CombinedRequestNavIntermediate);
   ManageCombinedRequestNav(CombinedRequestNav);
   ManageCombinedRequestVol(CombinedRequestVol);
   
   delete CombinedRequestVol;
   delete CombinedRequestNav;
   delete CombinedRequestNavIntermediate;
   delete CombinedRequestList;
   delete LimitRequestOriginMapping;
}

//--- Helper Functions: CombineOperations
CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *OrderManager::GetLimitRequestOriginMapping(void) {
   CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *LimitRequestOriginMapping = new CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*>();
   
   ConstructTradePool *TempTradePool;
   CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *TempTradePoolLimitRequestOriginMapping;
   for (int i = 0; i < TradePoolList.Count(); i++) {
      TradePoolList.TryGetValue(i, TempTradePool);
      TempTradePoolLimitRequestOriginMapping = TempTradePool.GetLimitRequestOriginMapping();
      MergeOriginMapping(TempTradePoolLimitRequestOriginMapping, LimitRequestOriginMapping);
      delete TempTradePoolLimitRequestOriginMapping;
   }
   return LimitRequestOriginMapping;
}

//--- Helper Functinos: CombineOperations
void OrderManager::CombineStopLimitRequestList(void) {
   CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *StopLimitRequestOriginMapping = GetStopLimitRequestOriginMapping();
   CArrayList<MqlTradeRequestWrapper*> *CombinedRequestList = new CArrayList<MqlTradeRequestWrapper*>();
   CHashMap<MqlTradeRequestWrapper*, CArrayList<MqlTradeRequestWrapper*>*> *CombinedRequestNavIntermediate = new CHashMap<MqlTradeRequestWrapper*, CArrayList<MqlTradeRequestWrapper*>*>();
   CHashMap<MqlTradeRequestWrapper*, CArrayList<ConstructTradePool*>*> *CombinedRequestNav = new CHashMap<MqlTradeRequestWrapper*, CArrayList<ConstructTradePool*>*>();
   CHashMap<MqlTradeRequestWrapper*, CArrayList<double>*> *CombinedRequestVol = new CHashMap<MqlTradeRequestWrapper*, CArrayList<double>*>();
   
   CombineRequest(StopLimitRequestOriginMapping, CombinedRequestList, CombinedRequestNavIntermediate, CombinedRequestNav, CombinedRequestVol);
   ManagePoolStopLimitRequestList(CombinedRequestList);
   ManageNewRequestGeneralProperties(CombinedRequestList);
   ManageCombinedRequestNavIntermediate(CombinedRequestNavIntermediate);
   ManageCombinedRequestNav(CombinedRequestNav);
   ManageCombinedRequestVol(CombinedRequestVol);
   
   delete CombinedRequestVol;
   delete CombinedRequestNav;
   delete CombinedRequestNavIntermediate;
   delete CombinedRequestList;
   delete StopLimitRequestOriginMapping;
}

//--- Helper Functions: CombineOperations
CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *OrderManager::GetStopLimitRequestOriginMapping(void) {
   CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *StopLimitRequestOriginMapping = new CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*>();
   
   ConstructTradePool *TempTradePool;
   CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *TempTradePoolStopLimitRequestOriginMapping;
   for (int i = 0; i < TradePoolList.Count(); i++) {
      TradePoolList.TryGetValue(i, TempTradePool);
      TempTradePoolStopLimitRequestOriginMapping = TempTradePool.GetStopLimitRequestOriginMapping();
      MergeOriginMapping(TempTradePoolStopLimitRequestOriginMapping, StopLimitRequestOriginMapping);
      delete TempTradePoolStopLimitRequestOriginMapping;
   }
   return StopLimitRequestOriginMapping;
}

//--- Helper Functinos: CombineOperations
void OrderManager::CombineStopRequestList(void) {
   CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *StopRequestOriginMapping = GetStopRequestOriginMapping();
   CArrayList<MqlTradeRequestWrapper*> *CombinedRequestList = new CArrayList<MqlTradeRequestWrapper*>();
   CHashMap<MqlTradeRequestWrapper*, CArrayList<MqlTradeRequestWrapper*>*> *CombinedRequestNavIntermediate = new CHashMap<MqlTradeRequestWrapper*, CArrayList<MqlTradeRequestWrapper*>*>();
   CHashMap<MqlTradeRequestWrapper*, CArrayList<ConstructTradePool*>*> *CombinedRequestNav = new CHashMap<MqlTradeRequestWrapper*, CArrayList<ConstructTradePool*>*>();
   CHashMap<MqlTradeRequestWrapper*, CArrayList<double>*> *CombinedRequestVol = new CHashMap<MqlTradeRequestWrapper*, CArrayList<double>*>();
   
   CombineRequest(StopRequestOriginMapping, CombinedRequestList, CombinedRequestNavIntermediate, CombinedRequestNav, CombinedRequestVol);
   ManagePoolStopRequestList(CombinedRequestList);
   ManageNewRequestGeneralProperties(CombinedRequestList);
   ManageCombinedRequestNavIntermediate(CombinedRequestNavIntermediate);
   ManageCombinedRequestNav(CombinedRequestNav);
   ManageCombinedRequestVol(CombinedRequestVol);
   
   delete CombinedRequestVol;
   delete CombinedRequestNav;
   delete CombinedRequestNavIntermediate;
   delete CombinedRequestList;
   delete StopRequestOriginMapping;
}

//--- Helper Functions: CombineOperations
CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *OrderManager::GetStopRequestOriginMapping(void) {
   CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *StopRequestOriginMapping = new CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*>();
   
   ConstructTradePool *TempTradePool;
   CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *TempTradePoolStopRequestOriginMapping;
   for (int i = 0; i < TradePoolList.Count(); i++) {
      TradePoolList.TryGetValue(i, TempTradePool);
      TempTradePoolStopRequestOriginMapping = TempTradePool.GetStopRequestOriginMapping();
      MergeOriginMapping(TempTradePoolStopRequestOriginMapping, StopRequestOriginMapping);
      delete TempTradePoolStopRequestOriginMapping;
   }
   return StopRequestOriginMapping;
}

//--- Helper Functions: CombineOperations
void OrderManager::MergeOriginMapping(CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *InputSource, CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *InputDestination) {
   MqlTradeRequestWrapper *RequestList[];
   ConstructTradePool *OriginMappingList[];
   InputSource.CopyTo(RequestList, OriginMappingList);
   
   for (int i = 0; i < ArraySize(RequestList); i++) {
      InputDestination.Add(RequestList[i], OriginMappingList[i]);
   }
}

//--- Helper Functions: CombineOperations
void OrderManager::CombineRequest(CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *InputRequestOriginMapping,
                                  CArrayList<MqlTradeRequestWrapper*> *OutputCombinedRequestList,
                                  CHashMap<MqlTradeRequestWrapper*, CArrayList<MqlTradeRequestWrapper*>*> *OutputCombinedRequestNavIntermediate,
                                  CHashMap<MqlTradeRequestWrapper*, CArrayList<ConstructTradePool*>*> *OutputCombinedRequestNav,
                                  CHashMap<MqlTradeRequestWrapper*, CArrayList<double>*> *OutputCombinedRequestVol) {
   
   CHashMap<string, CArrayList<MqlTradeRequestWrapper*>*> *IntermediateCombinedRequestList = GetIntermediateCombinedRequestList(InputRequestOriginMapping);
   
   string GroupingAttribute[];
   CArrayList<MqlTradeRequestWrapper*> *SameGroupingAttributeRequestList[];
   IntermediateCombinedRequestList.CopyTo(GroupingAttribute, SameGroupingAttributeRequestList);
   
   for (int i = 0; i < ArraySize(GroupingAttribute); i++) {
      CArrayList<MqlTradeRequestWrapper*> *TempSameGroupingAttributeRequestList = SameGroupingAttributeRequestList[i];
      MqlTradeRequestWrapper *CombinedRequest = GetCombinedRequest(TempSameGroupingAttributeRequestList);
      CArrayList<ConstructTradePool*> *CombinedRequestOriginMapping = GetCombinedRequestOriginMapping(InputRequestOriginMapping, TempSameGroupingAttributeRequestList);
      CArrayList<double> *CombinedRequestVolumeMapping = GetCombinedRequestVolumeMapping(TempSameGroupingAttributeRequestList, CombinedRequest);
      
      OutputCombinedRequestList.Add(CombinedRequest);
      OutputCombinedRequestNavIntermediate.Add(CombinedRequest, TempSameGroupingAttributeRequestList);
      OutputCombinedRequestNav.Add(CombinedRequest, CombinedRequestOriginMapping);
      OutputCombinedRequestVol.Add(CombinedRequest, CombinedRequestVolumeMapping);
      
      delete TempSameGroupingAttributeRequestList;
   }
   delete IntermediateCombinedRequestList;
}

//--- Helper Functions: CombineOperations
CHashMap<string, CArrayList<MqlTradeRequestWrapper*>*> *OrderManager::GetIntermediateCombinedRequestList(CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *InputRequestOriginMapping) {
   CHashMap<string, CArrayList<MqlTradeRequestWrapper*>*> *IntermediateCombinedRequestList = new CHashMap<string, CArrayList<MqlTradeRequestWrapper*>*>();
   
   MqlTradeRequestWrapper *RequestList[];
   ConstructTradePool *OriginMappingList[];
   InputRequestOriginMapping.CopyTo(RequestList, OriginMappingList);
   
   for (int i = 0; i < ArraySize(RequestList); i++) {
      if (IsNewGroupingAttributeRequest(IntermediateCombinedRequestList, RequestList[i])) {
         AddNewGroupingAttributeRequest(IntermediateCombinedRequestList, RequestList[i]);
      } else {
         AddExistedGroupingAttributeRequest(IntermediateCombinedRequestList, RequestList[i]);
      }
   }
   return IntermediateCombinedRequestList;
}

//--- Helper Functions: CombineOperations
bool OrderManager::IsNewGroupingAttributeRequest(CHashMap<string, CArrayList<MqlTradeRequestWrapper*>*> *InputIntermediateCombinedRequestList,
                                                 MqlTradeRequestWrapper *InputRequest) {
   CArrayList<MqlTradeRequestWrapper*> *TempSameGroupingAttributeRequestList;
   return !InputIntermediateCombinedRequestList.TryGetValue(GetRequestGroupingAttributes(InputRequest), TempSameGroupingAttributeRequestList);
}

//--- Helper Functions: CombineOperations
void OrderManager::AddNewGroupingAttributeRequest(CHashMap<string, CArrayList<MqlTradeRequestWrapper*>*> *InputIntermediateCombinedRequestList,
                                                  MqlTradeRequestWrapper *InputRequest) {
   CArrayList<MqlTradeRequestWrapper*> *SameGroupingAttributeRequestList = new CArrayList<MqlTradeRequestWrapper*>();
   SameGroupingAttributeRequestList.Add(InputRequest);
   InputIntermediateCombinedRequestList.Add(GetRequestGroupingAttributes(InputRequest), SameGroupingAttributeRequestList);
}

//--- Helper Functions: CombineOperations
void OrderManager::AddExistedGroupingAttributeRequest(CHashMap<string, CArrayList<MqlTradeRequestWrapper*>*> *InputIntermediateCombinedRequestList,
                                                      MqlTradeRequestWrapper *InputRequest) {
   CArrayList<MqlTradeRequestWrapper*> *TempSameGroupingAttributeRequestList;
   InputIntermediateCombinedRequestList.TryGetValue(GetRequestGroupingAttributes(InputRequest), TempSameGroupingAttributeRequestList);
   TempSameGroupingAttributeRequestList.Add(InputRequest);
   InputIntermediateCombinedRequestList.TrySetValue(GetRequestGroupingAttributes(InputRequest), TempSameGroupingAttributeRequestList);
}

//--- Helper Functions: CombineOperations
string OrderManager::GetRequestGroupingAttributes(MqlTradeRequestWrapper* InputRequest) {
   return IntegerToString(InputRequest.type)                               + 
          DoubleToString(NormalizeDouble(InputRequest.price, Digits()))    +
          DoubleToString(NormalizeDouble(InputRequest.stoplimit, Digits()));
}

//--- Helper Functions: CombineOperations
MqlTradeRequestWrapper *OrderManager::GetCombinedRequest(CArrayList<MqlTradeRequestWrapper*> *SameGroupingAttributeRequestList) {
   MqlTradeRequestWrapper *CombinedRequest = new MqlTradeRequestWrapper(GetFirstRequest(SameGroupingAttributeRequestList));
   
   MqlTradeRequestWrapper *TempRequest;
   for (int i = 1; i < SameGroupingAttributeRequestList.Count(); i++) {
      SameGroupingAttributeRequestList.TryGetValue(i, TempRequest);
      MergeRequest(TempRequest, CombinedRequest);
   }
   return CombinedRequest;
}

//--- Helper Functions: CombineOperations
MqlTradeRequestWrapper *OrderManager::GetFirstRequest(CArrayList<MqlTradeRequestWrapper*> *InputRequestList) {
   MqlTradeRequestWrapper *FirstRequest;
   InputRequestList.TryGetValue(0, FirstRequest);
   FirstRequest.comment += GetRandomString();
   return FirstRequest;
}

//--- Helper Functions: CombineOperations
void OrderManager::MergeRequest(MqlTradeRequestWrapper *InputSource, MqlTradeRequestWrapper *InputDestination) {
   InputDestination.volume += InputSource.volume;
}

//--- Helper Functions: CombineOperations
CArrayList<ConstructTradePool*> *OrderManager::GetCombinedRequestOriginMapping(CHashMap<MqlTradeRequestWrapper*, ConstructTradePool*> *InputRequestOriginMapping,
                                                                               CArrayList<MqlTradeRequestWrapper*> *SameGroupingAttributeRequestList) {
   CArrayList<ConstructTradePool*> *CombinedRequestOriginMapping = new CArrayList<ConstructTradePool*>();
   
   MqlTradeRequestWrapper *TempRequest;
   ConstructTradePool *TempTradePool;
   for (int i = 0; i < SameGroupingAttributeRequestList.Count(); i++) {
      SameGroupingAttributeRequestList.TryGetValue(i, TempRequest);
      InputRequestOriginMapping.TryGetValue(TempRequest, TempTradePool);
      CombinedRequestOriginMapping.Add(TempTradePool);
   }
   return CombinedRequestOriginMapping;
}

//--- Helper Functions: CombineOperations
CArrayList<double> *OrderManager::GetCombinedRequestVolumeMapping(CArrayList<MqlTradeRequestWrapper*> *SameGroupingAttributeRequestList,
                                                                  MqlTradeRequestWrapper *InputCombinedRequest) {
   CArrayList<double> *CombinedRequestVolumeMapping = new CArrayList<double>();
   
   MqlTradeRequestWrapper *TempRequest;
   for (int i = 0; i < SameGroupingAttributeRequestList.Count(); i++) {
      SameGroupingAttributeRequestList.TryGetValue(i, TempRequest);
      CombinedRequestVolumeMapping.Add(TempRequest.volume / InputCombinedRequest.volume);
   }
   return CombinedRequestVolumeMapping;
}

//--- Helper Functions: CombineOperations
string OrderManager::GetRandomString(void) {
   return IntegerToString(1 * MathRand()) + IntegerToString(2 * MathRand()) + IntegerToString(3 * MathRand()) +
          IntegerToString(4 * MathRand()) + IntegerToString(5 * MathRand()) + IntegerToString(6 * MathRand()) +
          IntegerToString(7 * MathRand()) + IntegerToString(8 * MathRand()) + IntegerToString(9 * MathRand()) +
          IntegerToString(8 * MathRand()) + IntegerToString(7 * MathRand()) + IntegerToString(6 * MathRand());
}

//--- Helper Functions: ManageNewRequestStream
void OrderManager::ManagePoolRawMarketRequestList(CArrayList<MqlTradeRequestWrapper*> *InputRequestList) { RawMarketRequestList.AddRange(InputRequestList); }
void OrderManager::ManagePoolLimitRequestList(CArrayList<MqlTradeRequestWrapper*> *InputRequestList)     { LimitRequestList.AddRange(InputRequestList);     }
void OrderManager::ManagePoolStopLimitRequestList(CArrayList<MqlTradeRequestWrapper*> *InputRequestList) { StopLimitRequestList.AddRange(InputRequestList); }
void OrderManager::ManagePoolStopRequestList(CArrayList<MqlTradeRequestWrapper*> *InputRequestList)      { StopRequestList.AddRange(InputRequestList);      }

//--- Helper Functions: ManageNewRequestStream
void OrderManager::ManagePoolRawMarketRequestList(MqlTradeRequestWrapper *InputRequest) { RawMarketRequestList.Add(InputRequest); }
void OrderManager::ManagePoolLimitRequestList(MqlTradeRequestWrapper *InputRequest)     { LimitRequestList.Add(InputRequest);     }
void OrderManager::ManagePoolStopLimitRequestList(MqlTradeRequestWrapper *InputRequest) { StopLimitRequestList.Add(InputRequest); }
void OrderManager::ManagePoolStopRequestList(MqlTradeRequestWrapper *InputRequest)      { StopRequestList.Add(InputRequest);      }

//--- Helper Functions: ManageNewRequestStream
void OrderManager::ManageNewRequestGeneralProperties(CArrayList<MqlTradeRequestWrapper*> *InputRequestList) {
   ManageRequestDirection(InputRequestList);
   ManageNewRequestPoolingStatus(InputRequestList);
}

//--- Helper Functions: ManageNewRequestStream
void OrderManager::ManageRequestDirection(CArrayList<MqlTradeRequestWrapper*> *InputRequestList) {
   MqlTradeRequestWrapper *TempRequest;
   for (int i = 0; i < InputRequestList.Count(); i++) {
      InputRequestList.TryGetValue(i, TempRequest);
      ManageRequestDirection(TempRequest);
   }
}

//--- Helper Functions: ManageRequestDirection
void OrderManager::ManageRequestDirection(MqlTradeRequestWrapper *InputRequest) {
   if (InputRequest.IsBuyRequest()) {
      ManageLongRequest(InputRequest);
   }
   if (InputRequest.IsSellRequest()) {
      ManageShortRequest(InputRequest);
   }
}

//--- Helper Functions: ManageRequestDirection
void OrderManager::ManageLongRequest(MqlTradeRequestWrapper *InputRequest)  { LongRequestList.Add(InputRequest);  }
void OrderManager::ManageShortRequest(MqlTradeRequestWrapper *InputRequest) { ShortRequestList.Add(InputRequest); }

//--- Helper Functions: ManageNewRequestStream
void OrderManager::ManageNewRequestPoolingStatus(CArrayList<MqlTradeRequestWrapper*> *InputRequestList) {
   MqlTradeRequestWrapper *TempRequest;
   for (int i = 0; i < InputRequestList.Count(); i++) {
      InputRequestList.TryGetValue(i, TempRequest);
      ManageNewRequestPoolingStatus(TempRequest);
   }
}

//--- Helper Functions: ManageNewRequestStream
void OrderManager::ManageNewRequestPoolingStatus(MqlTradeRequestWrapper *InputRequest) {
   RequestSessionExpiration.Add(InputRequest, UNPOOL);
}

//--- Helper Functions: ManageNewRequestStream
void OrderManager::ManageCombinedRequestNavIntermediate(CHashMap<MqlTradeRequestWrapper*, CArrayList<MqlTradeRequestWrapper*>*> *InputCombinedRequestNavIntermediateBuffer) {
   MqlTradeRequestWrapper *CombinedRequestList[];
   CArrayList<MqlTradeRequestWrapper*> *CombinedRequestNavIntermediateList[];
   InputCombinedRequestNavIntermediateBuffer.CopyTo(CombinedRequestList, CombinedRequestNavIntermediateList);
   
   for (int i = 0; i < ArraySize(CombinedRequestList); i++) {
      CombinedTradeRequestNavIntermediate.Add(CombinedRequestList[i], CombinedRequestNavIntermediateList[i]);
   }
}

//--- Helper Functions: ManageNewRequestStream
void OrderManager::ManageCombinedRequestNav(CHashMap<MqlTradeRequestWrapper*, CArrayList<ConstructTradePool*>*> *InputCombinedRequestNavBuffer) {
   MqlTradeRequestWrapper *CombinedRequestList[];
   CArrayList<ConstructTradePool*> *CombinedRequestNavList[];
   InputCombinedRequestNavBuffer.CopyTo(CombinedRequestList, CombinedRequestNavList);
   
   for (int i = 0; i < ArraySize(CombinedRequestList); i++) {
      CombinedTradeRequestNav.Add(CombinedRequestList[i], CombinedRequestNavList[i]);
   }
}

//--- Helper Functinos: ManageNewRequestStream
void OrderManager::ManageCombinedRequestVol(CHashMap<MqlTradeRequestWrapper*, CArrayList<double>*> *InputCombinedRequestVolBuffer) {
   MqlTradeRequestWrapper *CombinedRequestList[];
   CArrayList<double> *CombinedRequestVolList[];
   InputCombinedRequestVolBuffer.CopyTo(CombinedRequestList, CombinedRequestVolList);
   
   for (int i = 0; i < ArraySize(CombinedRequestList); i++) {
      CombinedTradeRequestVol.Add(CombinedRequestList[i], CombinedRequestVolList[i]);
   }
}

//--- Operations
void OrderManager::AddTradePool(CArrayList<Construct*> *InputConstructs) {
   Construct *TempConstruct;
   for (int i = 0; i < InputConstructs.Count(); i++) {
      InputConstructs.TryGetValue(i, TempConstruct);
      AddTradePool(TempConstruct);
   }
   delete InputConstructs;
}

//--- Operations
void OrderManager::AddTradePool(Construct *InputConstruct) {
   AddTradePool(InputConstruct.GetConstructTradePool());
}

//--- Operations
void OrderManager::AddTradePool(CArrayList<ConstructTradePool*> *InputTradePools) {
   TradePoolList.AddRange(InputTradePools);
   delete InputTradePools;
}

//--- Operations
void OrderManager::AddTradePool(ConstructTradePool *InputTradePool) {
   TradePoolList.Add(InputTradePool);
}

//--- Operations
CArrayList<MqlTradeRequestWrapper*> *OrderManager::PoolRawMarketRequest(void) { return GetUnpoolRequests(RawMarketRequestList); }
CArrayList<MqlTradeRequestWrapper*> *OrderManager::PoolLimitRequest(void)     { return GetUnpoolRequests(LimitRequestList);     }
CArrayList<MqlTradeRequestWrapper*> *OrderManager::PoolStopLimitRequest(void) { return GetUnpoolRequests(StopLimitRequestList); }
CArrayList<MqlTradeRequestWrapper*> *OrderManager::PoolStopRequest(void)      { return GetUnpoolRequests(StopRequestList);      }

//--- Operations
CArrayList<MqlTradeRequestWrapper*> *OrderManager::GetLongRequest(void)       { return LongRequestList;                         }
CArrayList<MqlTradeRequestWrapper*> *OrderManager::GetShortRequest(void)      { return ShortRequestList;                        }

//--- Helper Functions: PoolRawMarketRequest/PoolLimitRequest/PoolStopLimitRequest/PoolStopRequest
CArrayList<MqlTradeRequestWrapper*> *OrderManager::GetUnpoolRequests(CArrayList<MqlTradeRequestWrapper*> *RequestList) {
   CArrayList<MqlTradeRequestWrapper*> *UnpoolRequestList = new CArrayList<MqlTradeRequestWrapper*>();
   
   MqlTradeRequestWrapper *RequestTemp;
   for (int i = 0; i < RequestList.Count(); i++) {
      RequestList.TryGetValue(i, RequestTemp);
      if (IsRequestUnpool(RequestTemp)) {
         UnpoolRequestList.Add(RequestTemp);
         SetRequestPoolingStatusToAlreadyPool(RequestTemp);
      }
   }
   return UnpoolRequestList;
}

//--- Helper Functions: PoolRawMarketRequest/PoolLimitRequest/PoolStopLimitRequest/PoolStopRequest
bool OrderManager::IsRequestUnpool(MqlTradeRequestWrapper *InputRequest) {
   return GetPoolingStatus(InputRequest) == UNPOOL;
}

//--- Helper Functions: PoolRawMarketRequest/PoolLimitRequest/PoolStopLimitRequest/PoolStopRequest
bool OrderManager::IsRequestAlreadyPool(MqlTradeRequestWrapper *InputRequest) {
   return GetPoolingStatus(InputRequest) == ALREADY_POOL;
}

//--- Helper Functions: PoolRawMarketRequest/PoolLimitRequest/PoolStopLimitRequest/PoolStopRequest
ENUM_POOLING_STATUS OrderManager::GetPoolingStatus(MqlTradeRequestWrapper *InputRequest) {
   ENUM_POOLING_STATUS RequestPoolingStatus = ALREADY_POOL;
   RequestSessionExpiration.TryGetValue(InputRequest, RequestPoolingStatus);
   return RequestPoolingStatus;
}

//--- Helper Functions: PoolRawMarketRequest/PoolLimitRequest/PoolStopLimitRequest/PoolStopRequest
void OrderManager::SetRequestPoolingStatusToAlreadyPool(MqlTradeRequestWrapper *InputRequest) {
   RequestSessionExpiration.TrySetValue(InputRequest, ALREADY_POOL);
}

//--- Operations
void OrderManager::LogExecutedRequest(MqlTradeRequestWrapper *InputCombinedRequest, MqlTradeResultWrapper *InputCombinedResult) {
   RequestResultSession.Add(InputCombinedRequest, InputCombinedResult);
   
   CArrayList<MqlTradeRequestWrapper*> *SubRequestList;
   CArrayList<ConstructTradePool*> *SubRequestTradePoolList;
   CArrayList<double> *VolumeRatioList;
   
   CombinedTradeRequestNavIntermediate.TryGetValue(InputCombinedRequest, SubRequestList);
   CombinedTradeRequestNav.TryGetValue(InputCombinedRequest, SubRequestTradePoolList);
   CombinedTradeRequestVol.TryGetValue(InputCombinedRequest, VolumeRatioList);
   
   MqlTradeRequestWrapper *TempSubRequest;
   ConstructTradePool *TempTradePool;
   double TempVolumeRatio;
   for (int i = 0; i < SubRequestList.Count(); i++) {
      SubRequestList.TryGetValue(i, TempSubRequest);
      SubRequestTradePoolList.TryGetValue(i, TempTradePool);
      VolumeRatioList.TryGetValue(i, TempVolumeRatio);
      TempTradePool.LogExecutedRequest(TempSubRequest, new MqlTradeResultWrapper(InputCombinedResult, TempVolumeRatio));
   }
}

//--- Operations
void OrderManager::MakeFullyHedged(void) {
   ConstructTradePool *TempTradePool;
   for (int i = 0; i < TradePoolList.Count(); i++) {
      TradePoolList.TryGetValue(i, TempTradePool);
      TempTradePool.MakeFullyHedged();
   }
}

//--- Getters
double OrderManager::GetCurrentPnL(void) {
   double CurrentPnL = 0;
   
   ConstructTradePool *TempTradePool;
   for (int i = 0; i < TradePoolList.Count(); i++) {
      TradePoolList.TryGetValue(i, TempTradePool);
      CurrentPnL += TempTradePool.GetCurrentPnL();
   }
   return CurrentPnL;
}

//--- Getters
double OrderManager::GetPositiveSlippagePnL(void) {
   double PositiveSlippagePnL = 0;
   
   ConstructTradePool *TempTradePool;
   for (int i = 0; i < TradePoolList.Count(); i++) {
      TradePoolList.TryGetValue(i, TempTradePool);
      PositiveSlippagePnL += TempTradePool.GetPositiveSlippagePnL();
   }
   return PositiveSlippagePnL;
}

//--- Getters
bool OrderManager::IsFullyHedged(void) {
   bool FullyHedgedFlag = true;
   
   ConstructTradePool *TempTradePool;
   for (int i = 0; i < TradePoolList.Count(); i++) {
      TradePoolList.TryGetValue(i, TempTradePool);
      FullyHedgedFlag = (FullyHedgedFlag && TempTradePool.IsFullyHedged());
   }
   return FullyHedgedFlag;
}