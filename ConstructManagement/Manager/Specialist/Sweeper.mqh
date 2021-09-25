#ifndef CONSTRUCT_SWEEPER_H
#define CONSTRUCT_SWEEPER_H

#include "../ConstructManager.mqh"

class ConstructSweeper : public ConstructManager
{
public:
   //--- Get Singleton Instance
   static ConstructSweeper* GetInstance(void);
   
   //--- Remove Inactive Construct
   void Sweep(void);
   
private:   
   //--- Singleton Instance
   static ConstructSweeper* Instance;
   
   // Main Constructor --- Singleton
   ConstructSweeper(void);
};

ConstructSweeper* ConstructSweeper::Instance = NULL;

#endif