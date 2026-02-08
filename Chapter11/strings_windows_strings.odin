package strings_windows_strings

import "core:fmt"
import "core:sys/windows"

main :: proc() {
	// Say that you want to change the title of a window, You do that using the following procedure from core:sys/windows
	// SetWindowTextW :: proc(hWnd: HWND, lpString: LPCWSTR) -> BOOL
	// The windows API refers to these UTF-16 strings as wide strings, or wstrings.
	// Hence the WSTR in the type name. Also, that's why this is a W at the end of
	// SetWindowTextW
	// lpString is assumed to be one of those zero-terminated UTF-16 strings. Use windows.utf8_to_wstring to convert from an Odin string
	window_title := "My Great Program"
	// utf8_to_wstring does both the coversion to UTF-16 and adds in the zero termination
	windows.SetWindowTextW(hwnd, windows.utf8_to_wstring(window_title))

	// Get current window title

	// stack allocated fixed array of UTF-16 characters
	title_wstr: [128]windows.WCHAR
	// Procedure will fill out title_wstr with the title string and return how many characters it wrote
	title_len := windows.GetWindowTextW(hwnd, raw_data(&title_wstr), len(title_wstr))
	// Covert this UTF-16 to a Odin UTF-8 string
	title_str, title_str_err := windows.wstring_to_utf8(raw_data(&title_wstr), int(title_len))

	if title_str_err == nil {
		fmt.println(title_str)
	}
}
