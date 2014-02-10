//swaps two elements in a ds_list
listid = argument0
left = argument1
right = argument2

lval = ds_list_find_value(listid, left)
rval = ds_list_find_value(listid, right)
ds_list_replace(listid, left, rval)
ds_list_replace(listid, right, lval)
