//returns the id of a list of children to the object passed in argument 0
index = 0
children_listid = ds_list_create()
while (object_exists(index)) {
    if (object_get_name(argument[0]) == object_get_name(object_get_parent(index))) {
        ds_list_add(children_listid, index)
    }
    index ++
}

return children_listid
