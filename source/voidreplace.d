import std.meta;
import std.traits;
template replacevoid(alias A,List...){
	template rv(alias A,int i,List...){
		static if(i>List.length){
			alias rv=List;
		} else {
		static if(is(List[i]==void)){
			alias rv=AliasSeq!(List[0..i],A,List[i+1..$]);
		} else {
			alias rv=rv!(A,i+1,List);
		}}
	}
	alias replacevoid=rv!(A,0,List);
}
unittest{
	import basic;
	enum foo=[replacevoid!(2,AliasSeq!(1,void,3))];
	foo.writeln;
}
template replacevoids(alias F,alias G,List...){
	alias locallist=F!G;
	static foreach(A;List){
		locallist=replacevoid!(A,locallist);
	}
	alias replacevoids=locallist;
}
unittest{
	import basic;
	void foo(int,ref bool,float f=4.20){}
	alias bar=replacevoids!(ParameterDefaults,foo,1,true);
	bar.stringof.writeln;
}