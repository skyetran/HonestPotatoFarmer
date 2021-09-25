#property strict

#include "../../../../ConstructManagement/Construct/BigHedge/Short/Six.mqh"

//--- Constructor
SixLevelNetShortBigHedgeConstruct::SixLevelNetShortBigHedgeConstruct(void) {
   Type = new ConstructType(BIG_HEDGE_SHORT, SIX_LEVEL);
}

//--- Destructor
SixLevelNetShortBigHedgeConstruct::~SixLevelNetShortBigHedgeConstruct(void) {

}