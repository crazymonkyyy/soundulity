void foo(ref int i,float f,bool b){}
void foo(int i,ref float f,bool b){assert(0);}
void foo(ref int i,ref float f,bool b){}
void foo(int,float,bool b=true){assert(0);}

void main(){
	int i;
	float f;
	foo(i,f,false);
}