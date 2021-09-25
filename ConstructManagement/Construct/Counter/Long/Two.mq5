#property strict

#include "../../../../ConstructManagement/Construct/Counter/Long/Two.mqh"

//--- Constructor
TwoLevelNetLongCounterConstruct::TwoLevelNetLongCounterConstruct(void) {
   Type = new ConstructType(COUNTER_LONG, TWO_LEVEL);
}

//--- Destructor
TwoLevelNetLongCounterConstruct::~TwoLevelNetLongCounterConstruct(void) {

}