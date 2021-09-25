#property strict

#include "../../../../ConstructManagement/Construct/Counter/Short/Seven.mqh"

//--- Constructor
SevenLevelNetShortCounterConstruct::SevenLevelNetShortCounterConstruct(void) {
   Type = new ConstructType(COUNTER_SHORT, SEVEN_LEVEL);
}

//--- Destructor
SevenLevelNetShortCounterConstruct::~SevenLevelNetShortCounterConstruct(void) {

}