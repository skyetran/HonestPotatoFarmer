#ifndef CONSTRUCT_COORDINATOR_H
#define CONSTRUCT_COORDINATOR_H

class ConstructCoordinator
{
public:
   //--- Get Singleton Instance
   static ConstructCoordinator* GetInstance(void);
   
   //--- Destructor
   ~ConstructCoordinator(void);
   
private:
   //--- Singleton Instance
   static ConstructCoordinator* Instance;
   
   // Main Constructor --- Singleton
   ConstructCoordinator(void);
};

ConstructCoordinator* ConstructCoordinator::Instance = NULL;

#endif