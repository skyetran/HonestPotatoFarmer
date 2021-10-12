//--- Conversion From Price To Point
int PriceToPointCvt(const double Price) {
   return (int) (Price / SymbolInfoDouble(Symbol(), SYMBOL_POINT));
}

//--- Conversion From Point to Price
double PointToPriceCvt(const int Pts) {
   return (double) (Pts * SymbolInfoDouble(Symbol(), SYMBOL_POINT));
}

double GetPointValuePerStandardLot(void) {
   return (SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_VALUE) / SymbolInfoDouble(Symbol(), SYMBOL_TRADE_TICK_SIZE)) * SymbolInfoDouble(Symbol(), SYMBOL_POINT);
}

double GetPointValuePerMinStandardLot(void) {
   return NormalizeDouble(MathCeil(GetPointValuePerStandardLot()) / 100, 2);
}

double GetMinLotSize(void) {
   return SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_MIN);
}