#property strict

#include "../../../../ConstructManagement/Construct/Counter/Long/Three.mqh"

//--- Constructor
ThreeLevelNetLongCounterConstruct::ThreeLevelNetLongCounterConstruct(void) {
   Type = new ConstructType(COUNTER_LONG, THREE_LEVEL);
}

//--- Destructor
ThreeLevelNetLongCounterConstruct::~ThreeLevelNetLongCounterConstruct(void) {

}