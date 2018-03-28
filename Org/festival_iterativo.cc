#include <iostream>
#include <vector>
#include <cstring>
using namespace std;
const int INF = 1 << 30;

//vector<vector<int>> cache;
int cache[1000001][26];
int blocos[25];

int solve2(int n, int m) {
  for(int i = 0; i<n; ++i) cache[0][i] = 0;
  for(int i = 0; i<=m; ++i) cache[i][0] = i;

  for(int i = 1; i <= m; ++i) {
    for(int j = 1; j < n; ++j) {
      int b = cache[i][j-1];
      int a = INF;
      if (i >= blocos[j]) {
         a = 1 + cache[i - blocos[j]][j];
      }
      cache[i][j] = min(a, b);
    }
  }

  return cache[m][n-1];
}

int main() {
  std::ios::sync_with_stdio(false);
  int t;
  cin >> t;

  for(int i = 0; i < t; ++i ) {
    int n, m;
    cin >> n >> m;
    for(int i = 0; i < n; ++i) 
      cin >> blocos[i];

    cout << solve2(n, m) << '\n';
  }
  return 0;
}
