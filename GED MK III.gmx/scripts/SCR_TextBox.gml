draw_sprite(SPR_TextBox,0,732,480);

if keyboard_check(vk_enter) {
showText = "";
}
showText = string_replace_all(inputText,"#","\#");
draw_text(732,484,showText);


