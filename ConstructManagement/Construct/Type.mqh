#ifndef CONSTRUCT_TYPE_H
#define CONSTRUCT_TYPE_H

#include "../../General/GlobalConstants.mqh"

#include <Generic/Interfaces/IComparable.mqh>

class ConstructType : public IComparable<ConstructType*>
{
public:
   //--- Default Constructor
   ConstructType(void);
   
   //--- Main Constructor
   ConstructType(const ENUM_CONSTRUCT_CLASS InputClass, const int InputLevel);
   
   //--- Getters
   ENUM_CONSTRUCT_CLASS GetClass(void) const;
   int                  GetLevel(void) const;
   
   //--- Required ADT Functions
   int  Compare(ConstructType* Other) override;
   bool Equals(ConstructType* Other) override;
   int  HashCode() override;

private:
   string ConstructTypeStr;
   
   //--- Core Information
   ENUM_CONSTRUCT_CLASS Class;
   int                  Level;
};

#endif