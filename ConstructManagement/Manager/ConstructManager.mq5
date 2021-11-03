#property strict

#include "../../ConstructManagement/Manager/ConstructManager.mqh"

//--- Main Constructor
ConstructManager::ConstructManager(void) {
   IP = IndicatorProcessor::GetInstance();
}

//--- Destructor
ConstructManager::~ConstructManager(void) {

}