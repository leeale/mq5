#include "ClassInduk.mqh"
class ClassChild
{
private:
    ClassInduk classinduk;

public:
    ClassChild(/* args */)
    {
        classinduk.setmahasiswa("usman", 20);
    }

    // ~ClassChild();

    void init()
    {
        // ClassInduk::setmahasiswa("burhan", 80);

        Print(classinduk.getmahasiswa().nama, "class child");
    }
};
