#ifndef EQUITY_MANAGER_H
#define EQUITY_MANAGER_H

class EquityManager
{
public:
   //--- Get Singleton Instance
   static EquityManager* GetInstance(void);
   
private:
   //--- Singleton Instance
   static EquityManager* Instance;
   
   // Main Constructor --- Singleton
   EquityManager(void);
};

EquityManager* EquityManager::Instance = NULL;

#endif