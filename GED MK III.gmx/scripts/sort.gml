/*quick insertion sort script*/
listid = argument0 //ds list to sort
comp_script = argument1 //script used to compare elements

for (i = 1; i < ds_list_size(listid); i ++) {
    j = i
    left = ds_list_find_value(listid, j - 1)
    right = ds_list_find_value(listid, j)
    while (j > 0 and script_execute(comp_script, left, right) > 0) {
        ds_list_swap(listid, j, j - 1)
        j --
        left = ds_list_find_value(listid, j - 1)
        right = ds_list_find_value(listid, j)
    }
}
