#ifndef Example1_mqh
#define Example1_mqh

#ifdef __INTELLISENSE__
#pragma diag_suppress 11, 70, 98, 120, 137, 144, 153, 167, 250, 251, 304, 310, 349, 413, 415, 513, 2140
#endif

#define __DATETIME__ __DATE__ " " __TIME__
#define sinput extern
#define input extern
#define NULL '\0'
#define C +
#define D +
#define False false
#define FALSE false
#define True true
#define TRUE true
typedef unsigned long long int size_t;

class StringSumHelper;

class string
{
    typedef void (string::*StringIfHelperType)() const;
    void StringIfHelper() const {}

public:
    string(const char *cstr = "");
    string(const string &str);
#if __cplusplus >= 201103L || defined(__GXX_EXPERIMENTAL_CXX0X__)
    string(string &&rval);
    string(StringSumHelper &&rval);
#endif
    explicit string(char c);
    explicit string(unsigned char, unsigned char base = 10);
    explicit string(int, unsigned char base = 10);
    explicit string(unsigned int, unsigned char base = 10);
    explicit string(long, unsigned char base = 10);
    explicit string(unsigned long, unsigned char base = 10);
    explicit string(float, unsigned char decimalPlaces = 2);
    explicit string(double, unsigned char decimalPlaces = 2);
    explicit operator int() {}
    ~string(void);

    unsigned char reserve(unsigned int size);
    inline unsigned int length(void) const { return len; }

    string &operator=(const string &rhs);
    string &operator=(const char *cstr);
#if __cplusplus >= 201103L || defined(__GXX_EXPERIMENTAL_CXX0X__)
    string &operator=(string &&rval);
    string &operator=(StringSumHelper &&rval);
#endif

    unsigned char concat(const string &str);
    unsigned char concat(const char *cstr);
    unsigned char concat(char c);
    unsigned char concat(unsigned char c);
    unsigned char concat(int num);
    unsigned char concat(unsigned int num);
    unsigned char concat(long num);
    unsigned char concat(unsigned long num);
    unsigned char concat(float num);
    unsigned char concat(double num);

    string &operator+=(const string &rhs)
    {
        concat(rhs);
        return (*this);
    }
    string &operator+=(const char *cstr)
    {
        concat(cstr);
        return (*this);
    }
    string &operator+=(char c)
    {
        concat(c);
        return (*this);
    }
    string &operator+=(unsigned char num)
    {
        concat(num);
        return (*this);
    }
    string &operator+=(int num)
    {
        concat(num);
        return (*this);
    }
    string &operator+=(unsigned int num)
    {
        concat(num);
        return (*this);
    }
    string &operator+=(long num)
    {
        concat(num);
        return (*this);
    }
    string &operator+=(unsigned long num)
    {
        concat(num);
        return (*this);
    }
    string &operator+=(float num)
    {
        concat(num);
        return (*this);
    }
    string &operator+=(double num)
    {
        concat(num);
        return (*this);
    }

    friend StringSumHelper &operator+(const StringSumHelper &lhs, const string &rhs);
    friend StringSumHelper &operator+(const StringSumHelper &lhs, const char *cstr);
    friend StringSumHelper &operator+(const StringSumHelper &lhs, char c);
    friend StringSumHelper &operator+(const StringSumHelper &lhs, unsigned char num);
    friend StringSumHelper &operator+(const StringSumHelper &lhs, int num);
    friend StringSumHelper &operator+(const StringSumHelper &lhs, unsigned int num);
    friend StringSumHelper &operator+(const StringSumHelper &lhs, long num);
    friend StringSumHelper &operator+(const StringSumHelper &lhs, unsigned long num);
    friend StringSumHelper &operator+(const StringSumHelper &lhs, float num);
    friend StringSumHelper &operator+(const StringSumHelper &lhs, double num);
    friend StringSumHelper &operator+(const StringSumHelper &lhs, datetime num);

    operator StringIfHelperType() const { return buffer ? &string::StringIfHelper : 0; }
    int compareTo(const string &s) const;
    unsigned char equals(const string &s) const;
    unsigned char equals(const char *cstr) const;
    unsigned char operator==(const string &rhs) const { return equals(rhs); }
    unsigned char operator==(const char *cstr) const { return equals(cstr); }
    unsigned char operator!=(const string &rhs) const { return !equals(rhs); }
    unsigned char operator!=(const char *cstr) const { return !equals(cstr); }
    unsigned char operator<(const string &rhs) const;
    unsigned char operator>(const string &rhs) const;
    unsigned char operator<=(const string &rhs) const;
    unsigned char operator>=(const string &rhs) const;
    unsigned char equalsIgnoreCase(const string &s) const;
    unsigned char startsWith(const string &prefix) const;
    unsigned char startsWith(const string &prefix, unsigned int offset) const;
    unsigned char endsWith(const string &suffix) const;

protected:
    char *buffer;
    unsigned int capacity;
    unsigned int len;
};

class StringSumHelper : public string
{
public:
    StringSumHelper(const string &s) : string(s) {}
    StringSumHelper(const char *p) : string(p) {}
    StringSumHelper(char c) : string(c) {}
    StringSumHelper(unsigned char num) : string(num) {}
    StringSumHelper(int num) : string(num) {}
    StringSumHelper(unsigned int num) : string(num) {}
    StringSumHelper(long num) : string(num) {}
    StringSumHelper(unsigned long num) : string(num) {}
    StringSumHelper(float num) : string(num) {}
    StringSumHelper(double num) : string(num) {}
    // explicit operator int() {}
};

class datetime
{
public:
    datetime() {};
    datetime(int val) : val(val) {}
    datetime(string str) : str(str) {}

    datetime &operator+=(const datetime &other)
    {
        val += other.val;
        return *this;
    }
    datetime &operator-=(const datetime &other)
    {
        val -= other.val;
        return *this;
    }

    int getValue() const { return val; }

    string getString() const { return str; }

    operator int() const { return val; }

    datetime(int val) : val(val) {}

private:
    int val;
    string str;
};

typedef string group;
typedef char uchar;
typedef int uint;
typedef long ulong;
typedef short ushort;
typedef int DXVector;
typedef int color;

class scalar
{
public:
    scalar() {}
    scalar(int val) : intValue(val) {}
    scalar(double val) : doubleValue(val) {}
    scalar(string val) : stringValue(val) {}
    scalar(bool val) : boolValue(val) {}
    scalar(long val) : longValue(val) {}
    scalar(short val) : shortValue(val) {}
    scalar(float val) : floatValue(val) {}
    scalar(uchar val) : ucharValue(val) {}
    scalar(uint val) : uintValue(val) {}
    scalar(ulong val) : ulongValue(val) {}
    scalar(ushort val) : ushortValue(val) {}

    int intValue;
    double doubleValue;
    string stringValue;
    bool boolValue;
    long longValue;
    short shortValue;
    float floatValue;
    uchar ucharValue;
    uint uintValue;
    ulong ulongValue;
    ushort ushortValue;

    scalar &operator=(int val)
    {
        intValue = val;
        return *this;
    }
    scalar &operator=(double val)
    {
        doubleValue = val;
        return *this;
    }
    scalar &operator=(string val)
    {
        stringValue = val;
        return *this;
    }
    scalar &operator=(bool val)
    {
        boolValue = val;
        return *this;
    }
    scalar &operator=(long val)
    {
        longValue = val;
        return *this;
    }
    scalar &operator=(short val)
    {
        shortValue = val;
        return *this;
    }
    scalar &operator=(float val)
    {
        floatValue = val;
        return *this;
    }
    scalar &operator=(uchar val)
    {
        ucharValue = val;
        return *this;
    }
    scalar &operator=(uint val)
    {
        uintValue = val;
        return *this;
    }
    scalar &operator=(ulong val)
    {
        ulongValue = val;
        return *this;
    }
    scalar &operator=(ushort val)
    {
        ushortValue = val;
        return *this;
    }
};

#endif
