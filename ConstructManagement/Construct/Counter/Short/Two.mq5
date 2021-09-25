#property strict

#include "../../../../ConstructManagement/Construct/Counter/Short/Two.mqh"

//--- Constructor
TwoLevelNetShortCounterConstruct::TwoLevelNetShortCounterConstruct(void) {
   Type = new ConstructType(COUNTER_SHORT, TWO_LEVEL);
}

//--- Destructor
TwoLevelNetShortCounterConstruct::~TwoLevelNetShortCounterConstruct(void) {

}