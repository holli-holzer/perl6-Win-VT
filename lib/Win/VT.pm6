unit module Win::VT;

use NativeCall;

constant STD_INPUT_HANDLE                   = -0xA;
constant STD_OUTPUT_HANDLE                  = -0xB;
constant ENABLE_VIRTUAL_TERMINAL_INPUT      = 0x0200;
constant ENABLE_PROCESSED_INPUT             = 0x0001;
constant ENABLE_PROCESSED_OUTPUT            = 0x0001;
constant ENABLE_VIRTUAL_TERMINAL_PROCESSING = 0x0004;
constant DWORD  := uint32;
constant BOOL   := int32;
constant HANDLE := Pointer[void];

sub GetConsoleMode(HANDLE, DWORD is rw) is native('Kernel32')  is export returns BOOL { * };
sub SetConsoleMode(HANDLE, DWORD) is native('Kernel32')  is export returns BOOL { * };
sub GetStdHandle(DWORD) is native('Kernel32')  is export returns Pointer[void]  { * };

my HANDLE $input-handle  = GetStdHandle( STD_INPUT_HANDLE );
my HANDLE $output-handle = GetStdHandle( STD_OUTPUT_HANDLE );
my DWORD $output-mode;
my DWORD $input-mode;

our sub vt-on(Bool :$vt-input=True, Bool :$vt-output=True ) returns Bool is export {
	GetConsoleMode($input-handle,  $input-mode);
	GetConsoleMode($output-handle, $output-mode);
	say ($input-mode, $output-mode);

	my $new-input-mode  = $input-mode  +| ENABLE_PROCESSED_INPUT  +| ENABLE_VIRTUAL_TERMINAL_INPUT;
	my $new-output-mode = $output-mode +| ENABLE_PROCESSED_OUTPUT +| ENABLE_VIRTUAL_TERMINAL_PROCESSING;
	say ($new-input-mode, $new-output-mode);
	return (
			( $vt-input  ?? SetConsoleMode($input-handle, $new-input-mode)  !! 1 ) &&
					( $vt-output ?? SetConsoleMode($output-handle, $new-output-mode) !! 1 )
			).Bool;
}

our sub vt-off() returns Bool is export {
	return (
			SetConsoleMode($output-handle, $output-mode) &&
					SetConsoleMode($input-handle, $input-mode)
			).Bool;
}

our sub cls() is export {
	vt-on;
	say chr(27) ~ '[2J' ~ chr(27) ~ '[;H';
	vt-off;
}