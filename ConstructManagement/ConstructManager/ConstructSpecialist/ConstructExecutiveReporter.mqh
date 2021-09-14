#ifndef CONSTRUCT_EXECUTIVE_REPORTER_H
#define CONSTRUCT_EXECUTIVE_REPORTER_H

#include "../ConstructManager.mqh"

class ConstructExecutiveReporter : public ConstructManager
{
public:
   //--- Get Singleton Instance
   static ConstructExecutiveReporter* GetInstance(void);
   
   //--- Report Contents
   double GetTotalCurrentValueAtRisk(void) const;
   
private:
   //--- Singleton Instance
   static ConstructExecutiveReporter* Instance;
   
   // Main Constructor --- Singleton
   ConstructExecutiveReporter(void);
};

ConstructExecutiveReporter* ConstructExecutiveReporter::Instance = NULL;

#endif