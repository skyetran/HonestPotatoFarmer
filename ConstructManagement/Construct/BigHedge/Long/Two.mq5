#property strict

#include "../../../../ConstructManagement/Construct/BigHedge/Long/Two.mqh"

//--- Constructor
TwoLevelNetLongBigHedgeConstruct::TwoLevelNetLongBigHedgeConstruct(void) {
   Type = new ConstructType(BIG_HEDGE_LONG, TWO_LEVEL);
}

//--- Destructor
TwoLevelNetLongBigHedgeConstruct::~TwoLevelNetLongBigHedgeConstruct(void) {

}