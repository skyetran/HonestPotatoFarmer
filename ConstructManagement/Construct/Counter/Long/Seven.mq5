#property strict

#include "../../../../ConstructManagement/Construct/Counter/Long/Seven.mqh"

//--- Constructor
SevenLevelNetLongCounterConstruct::SevenLevelNetLongCounterConstruct(void) {
   Type = new ConstructType(COUNTER_LONG, SEVEN_LEVEL);
}

//--- Destructor
SevenLevelNetLongCounterConstruct::~SevenLevelNetLongCounterConstruct(void) {

}