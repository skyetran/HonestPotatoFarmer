#ifndef CONSTRUCT_KEY_H
#define CONSTRUCT_KEY_H

#include "Type.mqh"
#include "Parameters.mqh"

class ConstructKey
{
public:
   //--- Default Constructor
   ConstructKey(void);
   
   //--- Main Constructor
   ConstructKey(ConstructType *InputType, ConstructParameters *InputParameters, const int InputEntryPositionID);
   
   //--- Getters
   ConstructType *GetConstructType(void)              const;
   ConstructParameters *GetConstructParameters(void)  const;
   int GetEntryPositionID(void)                       const;
   
private:
   ConstructType       *Type;
   ConstructParameters *Parameters;
   int                  EntryPositionID;
};

#endif