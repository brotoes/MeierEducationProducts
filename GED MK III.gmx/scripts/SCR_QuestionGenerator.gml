Number1 = floor((2*random(20)));
Number2 = floor((4*random(20)));

string1 = string(Number1);
string2 = string(Number2);
string3 = "What is ";
string4 = "plus ";
string5 = "?";
string6 = " ";
SCR_DrawQuestion();
global.CorrectAnswer = string(Number1 + Number2);

