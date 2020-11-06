#include"convert.h"
#include<iostream>
#include<vector>
using namespace std;
bool is_prime(int);
int main()
{
	vector<int>num;
	vector<int>::iterator it;
	int count = 0;
	int candicate = 2;
	while (count < 100)
	{
		if (is_prime(candicate))
		{
			num.push_back(candicate);
			count++;
		}
		candicate++;
	}
	for (it = num.begin(); it != num.end(); it++)
	{
		cout << dtoh(*it) << endl;
	}
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