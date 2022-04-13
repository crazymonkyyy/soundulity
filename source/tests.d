import raylib;
import basic;
import std.file;

void main(){
	InitWindow(400, 400, "Hello, Raylib-D!");
	SetWindowPosition(1800,0);
	InitAudioDevice(); 
	Sound[] s;
	foreach(f;dirEntries("assets/footsteps",SpanMode.depth)){
		s~=LoadSound(f.toStringz);
	}
	while (!WindowShouldClose()){
		BeginDrawing();
			ClearBackground(Colors.BLACK);
			PlaySoundMulti(s[uniform(0,3)]);
			EndDrawing();
		}
	CloseWindow();
}
