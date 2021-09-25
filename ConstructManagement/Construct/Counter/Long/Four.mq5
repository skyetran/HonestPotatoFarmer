#property strict

#include "../../../../ConstructManagement/Construct/Counter/Long/Four.mqh"

//--- Constructor
FourLevelNetLongCounterConstruct::FourLevelNetLongCounterConstruct(void) {
   Type = new ConstructType(COUNTER_LONG, FOUR_LEVEL);
}

//--- Destructor
FourLevelNetLongCounterConstruct::~FourLevelNetLongCounterConstruct(void) {

}