#include <iostream>
using namespace std;


int prime(int a) {
	int res = 0;
	int k = a - 3;
	_asm {
		mov edx, 0// reminder
		mov eax, a// division
		mov ebx, 2
		mov ecx, k;
		mov res, 0;
		jmp here
			yes :
		mov res, 1;
			here:
		div ebx
		    cmp edx, 0;
		    JLE yes
			inc ebx
            dec ecx
            cmp ecx,k
			JG here		
	}
	return res;
}


int main()
{
	int a;
	cout << "enter number:";
	cin >> a;
	int m = prime(a);
	if (m == 1)
		cout << "it is not prime  ";
	else
		cout << "it is prime  ";
	
	system("pause");
	return 0;
}

