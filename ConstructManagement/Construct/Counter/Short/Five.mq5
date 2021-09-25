#property strict

#include "../../../../ConstructManagement/Construct/Counter/Short/Five.mqh"

//--- Constructor
FiveLevelNetShortCounterConstruct::FiveLevelNetShortCounterConstruct(void) {
   Type = new ConstructType(COUNTER_SHORT, FIVE_LEVEL);
}

//--- Destructor
FiveLevelNetShortCounterConstruct::~FiveLevelNetShortCounterConstruct(void) {

}