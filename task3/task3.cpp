#include <cassert>
#include <iostream>
#include <vector>

using namespace std;

int main() {
    int n = 0;
    cin >> n;
    vector<string> numbers;
    for (int i = 0; i < n; ++i) {
        string number = "";
        cin >> number;
        for (auto s : number) {
            assert(isdigit(s));
        }
        numbers.push_back(number);
    }
    for (auto s : numbers) {
        int counter = 0;
        if (s.length() == 1) {
            cout << "-" << " ";
            continue;
        }
        for (auto t : s) {
            if (static_cast<int>(t) % 2 == 0) {
                ++counter;
            }
        }
        cout << counter << " ";
    }
    return 0;
}