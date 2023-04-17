#include <windows.h>

int WINAPI WinMain(HINSTANCE hInstance, HINSTANCE hPrevInstance, PSTR lpCmdLine, int nCmdShow){
    LPWSTR lpwCmdLine = GetCommandLineW();
    int argc;
    LPWSTR* argv = CommandLineToArgvW(lpwCmdLine, &argc);
    return wmain(argc, argv);
}
