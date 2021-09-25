#property strict

#include "../../../../ConstructManagement/Construct/BigHedge/Short/Two.mqh"

//--- Constructor
TwoLevelNetShortBigHedgeConstruct::TwoLevelNetShortBigHedgeConstruct(void) {
   Type = new ConstructType(BIG_HEDGE_SHORT, TWO_LEVEL);
}

//--- Destructor
TwoLevelNetShortBigHedgeConstruct::~TwoLevelNetShortBigHedgeConstruct(void) {

}