
#include "conio.h"
#include <iostream>
#include <cstdlib>
#include <string>
#include <vector>
#include <sstream>

using namespace std;

void replace()
{ // change here  input
	char original[1024] = "im gonna change this to that\n";
	cout << "first st : " << original<<"\n";
	char find[] = "this";
	cout << "second st : "<<find <<"\n";
	char subst[] = "that";
	cout << "thrd st : " << subst<<"\n";
	//
	char result[1024] = { 0 };
	

	_asm { 
		
		LEA esi, result
		PUSH esi                
		LEA esi, original       
		LEA edi, find           

		Search :
		mov AL, [edi]
			CMP AL, 0           
			JE Match          
			CMP[esi], 0         
			JE Mismatch        
			CMP[esi], al       
			JNE Mismatch    
			INC esi            
			INC edi
			INC ecx           
			JMP Search

			Match :
		INC EBX                
			TEST EBX, 00000001h
			JZ Mismatch         
			LEA edi, subst      
			MOV EDX, esi      
			POP esi            

			Replacement :
		MOV AL, [edi]           
			CMP AL, 0
			JE SetRegister      
			MOV[esi], AL        
			INC esi
			INC edi
			JMP Replacement

			Mismatch :
		POP edi                
			SUB esi, ECX        
			INC ECX            
			REP MOVSB          
			PUSH edi
			CMP[esi], 0       
			JZ Fine
			DEC esi
			XOR ECX, ECX       
			JMP Next            

			SetRegister :
		PUSH esi                
			MOV esi, EDX
			DEC esi
			XOR ECX, ECX

			Next :
		LEA edi, find           
			INC esi
			CMP[esi], 0
			JNE Search

			Fine :
		POP edi
			MOV[edi], 0         
	}
	
	cout <<"result : "<< result;
}
int main() {
	
	cout << "***please enter strings in the main code , in replace function\n\n";
	replace();
	system("pause");
	return 0;
}

