#property strict

#include "../../../../ConstructManagement/Construct/Counter/Short/Three.mqh"

//--- Constructor
ThreeLevelNetShortCounterConstruct::ThreeLevelNetShortCounterConstruct(void) {
   Type = new ConstructType(COUNTER_SHORT, THREE_LEVEL);
}

//--- Destructor
ThreeLevelNetShortCounterConstruct::~ThreeLevelNetShortCounterConstruct(void) {

}