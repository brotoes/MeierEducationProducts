/* accepts a string, and returns a list of strings, 
 *each of length less than or equal to w
 *will also split at a new line
 */
str = string_copy(argument0, 1, string_length(argument0))
w = argument1

str_listid = ds_list_create()
while (string_width(str) > w) {
    next_str = ""
    found_newline = false
    while (string_width(next_str) < w and not found_newline) {
        next_char = string_char_at(str, 1)
        str = string_delete(str, 1, 1)
        next_str += next_char
    }
    if (string_width(next_str) > w) {
        str = string_char_at(next_str, string_length(next_str)) + str
        next_str = string_delete(next_str, string_length(next_str), 1)
    }
    ds_list_add(str_listid, next_str)
}

if (string_length(str) > 0) {
    ds_list_add(str_listid, str)
}

return str_listid
