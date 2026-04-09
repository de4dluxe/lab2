#include <iostream>
#include <string>

using namespace std;

string checkCyclicShift(string S, string T) {
    if (S == T) {
        return "Yes";
    }
    for (int i = 0; i < S.length(); ++i) {
        rotate(S.begin(),S.begin()+(S.length()-1),S.end());
        if (S == T) {
            return "Yes";
        }
    }
    return "No";
}

int main() {
    cout << "Введите строку S: ";
    string S = "";
    cin >> S;
    cout << "Введите строку T: ";
    string T = "";
    cin >> T;
    cout << checkCyclicShift(S,T);
    return 0;
}