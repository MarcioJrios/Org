#include <iostream>
#include <vector>
#include <cstring>
using namespace std;
const int INF = 1 << 30;

int cache[26][1000001];
int blocos[25];

int solve2(int n, int m) {
  for(int i = 0; i<n; ++i) cache[i][0] = 0;
  for(int i = 0; i<=m; ++i) cache[0][i] = i;

  for(int i = 1; i <= m; ++i) {
    for(int j = 1; j < n; ++j) {
      int b = cache[j-1][i];
      int a = INF;
      if (i >= blocos[j]) {
         a = 1 + cache[j][i - blocos[j]];
      }
      cache[j][i] = min(a, b);
    }
  }

  return cache[n-1][m];
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

    /*for(int i = 0; i < n; ++i) {
        for(int j = 0; j <= m; ++j) {
            cache[i][j] = -1;
        }
    }*/

    cout << solve2(n, m) << '\n';
  }
  return 0;
}
