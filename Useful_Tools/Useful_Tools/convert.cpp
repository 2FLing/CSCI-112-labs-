#include"convert.h"
using namespace std;
//convert decimal to byte
string dtob(int num)
{
	if (num <2)
		return to_string(num);
	else
	{
		return dtob(num / 2) + to_string(num % 2);
	}
}
//convert decimal to octal
string dtoo(int num)
{
	if (num < 8)
		return to_string(num);
	else
	{
		return dtoo(num / 8) + to_string(num % 8);
	}
}
//convert decimal to hex
string dtoh(int num)
{
	if (num < 16)
	{
		if (num < 10)
		{
			return to_string(num);
		}
		else
		{
			string hex_nums[6] = { "A","B","C","D","E","F" };
			return hex_nums[num - 10];
		}
	}
	else
	{
		return dtoh(num / 16) + dtoh(num % 16);
	}
}
//convert binary to decimal
int btod(string num)
{
	if (num=="1" or num=="0")
	{
		return (int(num.at(0))-48)*pow(2, num.length() - 1);
	}
	else
	{

		return (int(num.at(0)) - 48) * pow(2, num.length() - 1)+btod(num.substr(1,num.length()-1));
	}
}
//assembly language
//; Convert ascii to dword
//atohProc	PROC
//push	ebp
//mov		ebp, esp
//push	eax
//push	ebx
//push	esi
//push	edx
//mov		esi, [ebp + 8]; string
//mov		edx, [ebp + 12]; num
//mov		eax, 0
//whileloop:
//cmp		BYTE PTR[esi], '0'
//jl		endloop
//cmp		BYTE PTR[esi], '9'
//jg		endloop
//mov		bl, BYTE PTR[esi]
//and ebx, 00000000Fh
//imul	eax, 10h
//add		eax, ebx
//inc		esi
//jmp		whileloop
//endloop :
//mov		DWORD PTR[edx], eax
//pop		edx
//pop		esi
//pop		ebx
//pop		eax
//pop		ebp
//ret
//atohProc	ENDP