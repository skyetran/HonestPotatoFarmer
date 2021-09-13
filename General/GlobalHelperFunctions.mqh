//--- Conversion From Price To Point
int PriceToPointCvt(double Price) {
   return (int) (Price / SymbolInfoDouble(Symbol(), SYMBOL_POINT));
}

//--- Conversion From Point to Price
double PointToPriceCvt(int Pts) {
   return (double) (Pts * SymbolInfoDouble(Symbol(), SYMBOL_POINT));
}