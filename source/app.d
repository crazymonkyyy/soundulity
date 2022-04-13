import raylib;
import basic;

void main(){
	InitWindow(400, 400, "Hello, Raylib-D!");
	SetWindowPosition(1800,0);
	InitAudioDevice();
	import footsteps;
	mixin setupsound!"footsteps";
	while (!WindowShouldClose()){
		BeginDrawing();
			ClearBackground(Colors.BLACK);
			playfootsteps;
		EndDrawing();
	}
	CloseWindow();
}