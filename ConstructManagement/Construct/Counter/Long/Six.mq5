#property strict

#include "../../../../ConstructManagement/Construct/Counter/Long/Six.mqh"

//--- Constructor
SixLevelNetLongCounterConstruct::SixLevelNetLongCounterConstruct(void) {
   Type = new ConstructType(COUNTER_LONG, SIX_LEVEL);
}

//--- Destructor
SixLevelNetLongCounterConstruct::~SixLevelNetLongCounterConstruct(void) {

}