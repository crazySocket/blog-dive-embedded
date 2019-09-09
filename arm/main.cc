#include <array>

extern "C" int f();

int main(void)
{
    std::array<int, 3> v = {1,2,3};

    int i=0;
    while(2)
    {
        i++;
        int j=1;
        f();
        auto it = v.begin();
        while(j<v.size())
        {
            j++;
            it++;
        }
    }
}
