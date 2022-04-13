import basic;
import std.meta;
import std.traits;
enum name=cleanupname2(__FILE__);
string cleanupname(string s){//I was getting the path dispite what the spec says
	import std.string;
	return s[
		lastIndexOf(s,'/')+1..
		lastIndexOf(s,'.')];
}
string cleanupname2(string s){
	string s_=cleanupname(s);
	assert(s_[$-4..$]=="test");
	return s_[0..$-4];
}
void main(){
	import raylib;
	InitWindow(400, 400, "Hello, Raylib-D!");
	SetWindowPosition(1800,0);
	InitAudioDevice();
	mixin("import "~name~";");
	mixin setupsound!name;
	int which;
	int vol=100;
	int returnindex(Parameters!randomindex args){
		return which;
	}
	float minpitch_(Parameters!randompitch args){
		return args[0];
	}
	float maxpitch_(Parameters!randompitch args){
		return args[1];
	}
	float flatpitch(Parameters!randompitch args){
		return 1.0;
	}
	while (!WindowShouldClose()){
		BeginDrawing();
			ClearBackground(Colors.BLACK);
			if(IsKeyPressed(KeyboardKey.KEY_M)){
				play!(returnindex,minpitch_);
			}
			if(IsKeyPressed(KeyboardKey.KEY_N)){
				play!(returnindex,maxpitch_);
			}
			if(IsKeyPressed(KeyboardKey.KEY_B)){
				play!(returnindex,flatpitch);
			}
			if(IsKeyPressed(KeyboardKey.KEY_UP)){
				vol+=5;
				setvolume(float(vol)/100);
			}
			if(IsKeyPressed(KeyboardKey.KEY_Q)){
				PlaySound(soundbank[which]);
			}
			if(IsKeyPressed(KeyboardKey.KEY_DOWN)){
				vol-=5;
				setvolume(float(vol)/100);
			}
			if(IsKeyPressed(KeyboardKey.KEY_LEFT)){
				which+=soundbank.length-1;
				which%=soundbank.length;
			}
			if(IsKeyPressed(KeyboardKey.KEY_RIGHT)){
				which+=soundbank.length+1;
				which%=soundbank.length;
			}
			if(IsKeyPressed(KeyboardKey.KEY_SPACE) || IsKeyDown(KeyboardKey.KEY_ENTER)){
				play;
			}
			DrawText(which.to!string.toStringz,0,0,40,Colors.WHITE);
			DrawText(vol.to!string.toStringz,0,100,40,Colors.WHITE);
			EndDrawing();
		}
	CloseWindow();
}
