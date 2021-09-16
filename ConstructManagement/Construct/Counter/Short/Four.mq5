#property strict

#include "../../../../ConstructManagement/Construct/Counter/Short/Four.mqh"

//--- Constructor
FourLevelNetShortCounterConstruct::FourLevelNetShortCounterConstruct(void) {
   Type = new ConstructType(COUNTER_SHORT, FOUR_LEVEL);
}

//--- Destructor
FourLevelNetShortCounterConstruct::~FourLevelNetShortCounterConstruct(void) {

}