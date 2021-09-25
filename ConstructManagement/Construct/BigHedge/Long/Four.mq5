#property strict

#include "../../../../ConstructManagement/Construct/BigHedge/Long/Four.mqh"

//--- Constructor
FourLevelNetLongBigHedgeConstruct::FourLevelNetLongBigHedgeConstruct(void) {
   Type = new ConstructType(BIG_HEDGE_LONG, FOUR_LEVEL);
}

//--- Destructor
FourLevelNetLongBigHedgeConstruct::~FourLevelNetLongBigHedgeConstruct(void) {

}