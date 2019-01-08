#define USE_STRLEN 0                                    ; //Use strlen to find string length?


//#include "stdafx.h"
#include <iostream>
#include <cstdlib>
#include <string>
#include <vector>
#include <sstream>
using namespace std;


void reverse(string word) {
	int n = word.length();
		char *arr = new char[n];
	for (int i = 0; i < n; i++) {
		arr[i] = word[i];
	}
	__asm
	{
		mov ecx, n
		mov eax, arr
		mov esi, eax; 
		add eax, ecx
		mov edi, eax
		dec edi; 
		shr ecx, 1; 
		jz done; //len =0 or 1
		Loopqh :
		mov al, [esi]; load characters
			mov bl, [edi]
			mov[esi], bl; 
			mov[edi], al
			inc esi; 
			dec edi
			dec ecx; 
			jnz Loopqh
			done:
	}
	string res;
	for (int i = 0; i < n; i++) {
		cout<< arr[i];
	}
	cout << " ";
	
}
int main() {
	string line, mid;;
	getline(cin, line);
	vector <string> words;
	stringstream stream(line);
	while (getline(stream, mid, ' ')) {
		words.push_back(mid);
	}
	for (int i = 0; i < words.size(); i++) {
		 reverse(words[i]);
	}

	system("pause");
	return 0;
}