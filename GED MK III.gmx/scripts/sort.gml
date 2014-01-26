/*quick insertion sort script*/
listid = argument0 //ds list to sort
comp_script = argument1 //script used to compare elements

for (i = 1; i < ds_list_size(listid); i ++) {
    cur = ds_list_find_value(listid, i)
    j = i - 1
    comp_with = ds_list_find_value(listid, j)
    while (j >= 0 and script_execute(comp_script, cur, comp_with) > 0) {
        j --
        comp_with = ds_list_find_value(listid, j)
    }
    ds_list_delete(listid, i)
    ds_list_insert(listid, j + 1, cur)
}
