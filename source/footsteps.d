import basic;
import std.meta;
private enum name=cleanupname(__FILE__);
string cleanupname(string s){//I was getting the path dispite what the spec says
	import std.string;
	return s[
		lastIndexOf(s,'/')+1..
		lastIndexOf(s,'.')];
}
enum minpitch=.9;
enum maxpitch=1.1;
enum range=.05;
alias pitchdefualt=AliasSeq!(0.0);
float randompitch(float min,float max,ref float last){
	float avoidlast(float max, float range, float last){
		auto max_=max-range;
		auto x=uniform(0,max_/2)+uniform(0,max_/2);
		if(x>=last-range/2){
			x+=range;
		}
		return x;
	}
	float x=avoidlast(max-min,range,last);
	last=x;
	return x+min;
}
//int randomindex(int max,int last=0){assert(0);}
//int randomindex(int max,ref int last){
//	int i=uniform(0,max-1);
//	if(i<=last){i++;}
//	last=i;
//	return i;
//}
alias indexdefualt=AliasSeq!(0);
int randomindex(int max,ref int last){
	auto x=uniform(0,max-1);
	if(x>=last){
		x++;
	}
	last=x;
	x.writeln;
	return x;
}
bool shouldplay(int num){
	return num<1;
}

mixin template setupsound(string name_:name){
	Sound[] soundbank=(){
		Sound[] o;
		import std.file;
		foreach(f;dirEntries("assets/"~name_,SpanMode.depth)){
			o~=LoadSound(f.toStringz);
		}
		return o;
	}();
	import std.traits;
	struct workaround_{//https://issues.dlang.org/show_bug.cgi?id=23010
		Parameters!randomindex[1..$] indexmeta=indexdefualt;
		Parameters!randompitch[2..$] pitchmeta=pitchdefualt;
	}
	workaround_ workaround;
	void play(){
		int index=randomindex(cast(int)soundbank.length,workaround.indexmeta);
		float pitch=randompitch(minpitch,maxpitch,workaround.pitchmeta);
		if( ! IsSoundPlaying(soundbank[index])){
			SetSoundPitch(soundbank[index],pitch);
			PlaySound(soundbank[index]);
		}else if(shouldplay(GetSoundsPlaying)){
			PlaySoundMulti(soundbank[index]);
		}
	}
	void play(alias replaceindex,alias replacepitch)(){
		int index=replaceindex(cast(int)soundbank.length,workaround.indexmeta);
		float pitch=replacepitch(cast(float)minpitch,cast(float)maxpitch,workaround.pitchmeta);
		pitch.writeln;
		SetSoundPitch(soundbank[index],pitch);
		PlaySound(soundbank[index]);
	}
	void setvolume(float f){
		foreach(ref e;soundbank){
			SetSoundVolume(e,f);
	}}
	mixin("void play"~name_~"(T...)(T args){play(args);}");
	mixin("void setvolume"~name_~"(T...)(T args){setvolume(args);}");
}