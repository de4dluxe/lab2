#include <iostream>
#include <string>
#include <vector>
#include <map>
#include <set>

using namespace std;

int main() {
    int n;
    cout << "Введите количество пар городов: ";
    cin >> n;

    vector<pair<string, string>> pairs;
    string a, b;
    for (int i = 0; i < n; ++i) {
        cin >> a >> b;
        pairs.push_back({a, b});
    }

    bool error = false;

    for (const auto& p : pairs) {
        if (p.first == p.second) {
            error = true;
            break;
        }
    }

    map<string, int> startCount;
    for (const auto& p : pairs) {
        startCount[p.first]++;
        if (startCount[p.first] > 1) {
            error = true;
            break;
        }
    }

    map<string, int> endCount;
    for (const auto& p : pairs) {
        endCount[p.second]++;
        if (endCount[p.second] > 1) {
            error = true;
            break;
        }
    }

    if (error) {
        cout << "Ошибка" << endl;
        return 0;
    }

    map<string, string> next;
    for (const auto& p : pairs) {
        next[p.first] = p.second;
    }

    set<string> starts;
    for (const auto& p : pairs) {
        if (endCount.find(p.first) == endCount.end()) {
            starts.insert(p.first);
        }
    }

    if (starts.empty()) {
        cout << "Ошибка" << endl;
        return 0;
    }

    string bestEnd;
    int maxLen = -1;

    for (const string& start : starts) {
        string cur = start;
        int len = 0;
        while (next.find(cur) != next.end()) {
            cur = next[cur];
            len++;
        }
        if (len > maxLen) {
            maxLen = len;
            bestEnd = cur;
        }
    }

    if (maxLen == -1) {
        cout << "Ошибка" << endl;
    } else {
        cout << bestEnd << endl;
    }

    return 0;
}