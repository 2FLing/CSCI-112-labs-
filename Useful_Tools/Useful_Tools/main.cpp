#include"convert.h"
#include<iostream>
#include<vector>
using namespace std;
bool is_prime(int);
int main()
{
	string str;
	cin >> str;
	cout << btod(str) << endl;
	return 0;
}
bool is_prime(int num)
{
	bool prime = true;
	for (int i = 2; i < num; i++)
	{
		if (num % i == 0)
			prime = false;
	}
	return prime;
}