import basic;
import std.traits;

struct defualtcall(alias F){
	alias T=Parameters!F;
	T store=ParameterDefaults!F;
	auto call(){
		return F(store);
	}
	auto call(alias G)(){
		return G(store);
	}
}
//unittest{
//	defualtcall!((int i=42)=>i.writeln) foo;
//	foo.call;
//	foo.call!((ref i){i=1337; return true;}).writeln;
//	foo.call;
//}

void foo(alias F)(){
	Parameters!F.stringof.writeln;
	ParameterDefaults!F.writeln;
}

void bar(int i=0,float f=4.20){}
void bar(ref float f,ref int i){}

void faz(alias F)(){
	foreach(i,f;
		__traits(getOverloads, __traits(parent, F), __traits(identifier, F))){
		
		
		
	//__traits(getParameterStorageClasses,F,0).stringof.writeln;
}
unittest{
	faz!bar;
}