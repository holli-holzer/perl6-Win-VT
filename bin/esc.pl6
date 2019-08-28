# perl6 -MWin::VT::Auto bin\esc.pl6
print chr(27) ~ '[2J' ~ chr(27) ~ '[;H';
#uncomment to test sigint handler
#$*IN.read;