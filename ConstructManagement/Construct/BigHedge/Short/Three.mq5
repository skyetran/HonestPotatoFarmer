#property strict

#include "../../../../ConstructManagement/Construct/BigHedge/Short/Three.mqh"

//--- Constructor
ThreeLevelNetShortBigHedgeConstruct::ThreeLevelNetShortBigHedgeConstruct(void) {
   Type = new ConstructType(BIG_HEDGE_SHORT, THREE_LEVEL);
}

//--- Destructor
ThreeLevelNetShortBigHedgeConstruct::~ThreeLevelNetShortBigHedgeConstruct(void) {

}