#property strict

#include "../../../../ConstructManagement/Construct/Counter/Long/Five.mqh"

//--- Constructor
FiveLevelNetLongCounterConstruct::FiveLevelNetLongCounterConstruct(void) {
   Type = new ConstructType(COUNTER_LONG, FIVE_LEVEL);
}

//--- Destructor
FiveLevelNetLongCounterConstruct::~FiveLevelNetLongCounterConstruct(void) {

}