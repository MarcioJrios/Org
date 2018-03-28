#include <iostream>
#include <vector>
#include <cstring>
using namespace std;
const int INF = 1 << 30;

int cache[26][1000001];
int blocos[25];

int solve(int n, int m) {
    int & r = cache[n][m];
    if(r != -1) return r;

    if(m == 0) return 0;
    if(n == 0) return m;

    int b = solve(n-1, m);
    int a = INF;
    if(m >= blocos[n]) {
        a = 1 + solve(n, m - blocos[n]);
    }

    r = min(a, b);

    return r;
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

    //memset(cache, -1, n*m*sizeof(int));
    for(int i = 0; i < n; ++i) {
        for(int j = 0; j <= m; ++j) {
            cache[i][j] = -1;
        }
    }

    cout << solve(n-1, m) << '\n';
  }
  return 0;
}
