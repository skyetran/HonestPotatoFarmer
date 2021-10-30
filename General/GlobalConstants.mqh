#define PIP_TO_PTS_SCALE      10
#define PTS_TO_PIP_SCALE      0.1

#define LESS_THAN             -1
#define EQUAL                 0
#define GREATER_THAN          1

#define CURRENT_BAR           0
#define LAST_BAR              1
#define LAST_LAST_BAR         2

#define ZERO_LEVEL            0
#define ONE_LEVEL             1
#define TWO_LEVEL             2
#define THREE_LEVEL           3
#define FOUR_LEVEL            4
#define FIVE_LEVEL            5
#define SIX_LEVEL             6
#define SEVEN_LEVEL           7

#define LEVEL_ZERO            0
#define LEVEL_ONE             1
#define LEVEL_TWO             2
#define LEVEL_THREE           3
#define LEVEL_FOUR            4
#define LEVEL_FIVE            5
#define LEVEL_SIX             6
#define LEVEL_SEVEN           7
#define LEVEL_OUT_OF_BOUND    9999

#define MIN_CONSTRUCT_LEVEL   3
#define MAX_CONSTRUCT_LEVEL   7

#define INVALID               -1

#define MIN_LOT_SIZE          0.01
#define LOT_SIZE_DIGITS       2

enum ENUM_CONSTRUCT_CLASS {
   FREE_STYLING_LONG  = 0,
   FREE_STYLING_SHORT = 1,
   COUNTER_LONG       = 2,
   COUNTER_SHORT      = 3,
   BIG_HEDGE_LONG     = 4,
   BIG_HEDGE_SHORT    = 5,
};

#define BOOMERANG_ALLOWED     true
#define BOOMERANG_NOT_ALLOWED false

#define NOT_APPLICABLE        0

string EMPTY_COMMENT    = "";

//--- Error Message
string CONSTRUCT_TYPE_DOES_NOT_EXIST = "Construct Type Does Not Exist";