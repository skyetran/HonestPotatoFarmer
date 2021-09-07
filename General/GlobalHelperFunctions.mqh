//--- Conversion From Price To Point
int PriceToPointCvt(string CurrencyPair, double Price) {
   return (int) (Price / SymbolInfoDouble(CurrencyPair, SYMBOL_POINT));
}

//--- Conversion From Point to Price
double PointToPriceCvt(string CurrencyPair, int Pts) {
   return (double) (Pts * SymbolInfoDouble(CurrencyPair, SYMBOL_POINT));
}