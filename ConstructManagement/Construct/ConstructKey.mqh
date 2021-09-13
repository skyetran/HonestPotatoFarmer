#ifndef CONSTRUCT_KEY_H
#define CONSTRUCT_KEY_H

#include "ConstructType.mqh"
#include "ConstructParameters.mqh"

class ConstructKey
{
public:
   //--- Default Constructor
   ConstructKey(void);
   
   //--- Main Constructor
   ConstructKey(ConstructType *InputType, ConstructParameters *InputParameters, const int &EntryPositionID);
   
   //--- Getters
   string GetConstructKeyStr(void)                    const;
   ConstructType *GetConstructType(void)              const;
   ConstructParameters *GetConstructParameters(void)  const;
   int GetEntryPositionID(void)                       const;
   
private:
   string               ConstructKeyStr;
   ConstructType       *Type;
   ConstructParameters *Parameters;
   int                  EntryPositionID;
};

#endif