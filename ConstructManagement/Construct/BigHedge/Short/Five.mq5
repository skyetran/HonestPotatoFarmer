#property strict

#include "../../../../ConstructManagement/Construct/BigHedge/Short/Five.mqh"

//--- Constructor
FiveLevelNetShortBigHedgeConstruct::FiveLevelNetShortBigHedgeConstruct(void) {
   Type = new ConstructType(BIG_HEDGE_SHORT, FIVE_LEVEL);
}

//--- Destructor
FiveLevelNetShortBigHedgeConstruct::~FiveLevelNetShortBigHedgeConstruct(void) {

}