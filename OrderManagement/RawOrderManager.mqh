#ifndef RAW_ORDER_MANAGER_H
#define RAW_ORDER_MANAGER_H

#include <Generic\ArrayList.mqh>

class RawOrderManager
{
public:
   //--- Destructor
   ~RawOrderManager(void);
   
   //--- Get Singleton Instance
   static RawOrderManager* GetInstance(void);
   
private:
   //--- Single Instance
   static RawOrderManager* Instance;
   
   // Main Constructor --- Singleton
   RawOrderManager(void);
};

RawOrderManager* RawOrderManager::Instance = NULL;

#endif