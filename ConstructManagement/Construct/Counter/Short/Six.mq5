#property strict

#include "../../../../ConstructManagement/Construct/Counter/Short/Six.mqh"

//--- Constructor
SixLevelNetShortCounterConstruct::SixLevelNetShortCounterConstruct(void) {
   Type = new ConstructType(COUNTER_SHORT, SIX_LEVEL);
}

//--- Destructor
SixLevelNetShortCounterConstruct::~SixLevelNetShortCounterConstruct(void) {

}