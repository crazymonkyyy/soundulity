import std.traits;
import std.meta;
template OverloadsOf(alias sym)
{
	enum getOverloadsExpr =
		`__traits(getOverloads,__traits(parent, sym), __traits(identifier, sym), true)`;
	static if (__traits(compiles, mixin(getOverloadsExpr))) {
		alias OverloadsOf = mixin(getOverloadsExpr);
	} else {
		alias OverloadsOf = sym;
	}
}
template deconstuctoverloads(alias F){
	alias overloadlist=AliasSeq!(OverloadsOf!F);
	static foreach(i,G;overloadlist){
		//alias types=Parameters!G;
		//alias values=ParameterDefaults!G;
		static foreach(j,T_;Parameters!G){
			//enum v_=values[j];
			template store(int x:i,int y:j){
				alias T=T_;
				alias v=ParameterDefaults!G[j];
			}
		}
	}
	//template store(){
	//	template paralength(alias G){
	//		enum int paplength=Parameters!G.length;
	//	}
	//	template min(int a){
	//		enum min=a;}
	//	template min(int a, int b, A...){
	//		static if(a<b){
	//			enum min=min!(a,A);
	//		} else {
	//			enum min=min!(b,A);
	//		}
	//	}
	//	enum lengthmin=min!(staticMap!(paralength,overloadlist));
	//	enum count=overloadlist.length;
	//}
	alias deconstuctoverloads=store;
}
void bar(int i=1,float f=2.0){}

unittest{
	void bar(float,int){}
	import basic;
	alias foo=deconstuctoverloads!bar;
	foo!(0,0).T.stringof.writeln;
	foo!(0,1).T.stringof.writeln;
	//foo!(1,0).T.stringof.writeln;
	//foo!(1,1).T.stringof.writeln;
	foo!(0,0).v.stringof.writeln;
	foo!(0,1).v.stringof.writeln;
	//foo!(1,0).v.stringof.writeln;
	//foo!(1,1).v.stringof.writeln;
	
	//foo!().lengthmin.writeln;
	//foo!().count.writeln;
}
//template overloadpara(alias F){
	