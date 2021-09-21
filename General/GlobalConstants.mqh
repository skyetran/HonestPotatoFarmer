#define PIP_TO_PTS_SCALE 10
#define PTS_TO_PIP_SCALE 0.1

#define LESS_THAN    -1
#define EQUAL         0
#define GREATER_THAN  1

#define CURRENT_BAR   0
#define LAST_BAR      1
#define LAST_LAST_BAR 2

#define THREE_LEVEL  3
#define FOUR_LEVEL   4
#define FIVE_LEVEL   5
#define SIX_LEVEL    6
#define SEVEN_LEVEL  7

enum ENUM_CONSTRUCT_CLASS {
   FREE_STYLING_LONG  = 0,
   FREE_STYLING_SHORT = 1,
   COUNTER_LONG       = 2,
   COUNTER_SHORT      = 3,
   BIG_HEDGE_LONG     = 4,
   BIG_HEDGE_SHORT    = 5,
};

//--- Error Message
string CONSTRUCT_TYPE_DOES_NOT_EXIST = "Construct Type Does Not Exist";