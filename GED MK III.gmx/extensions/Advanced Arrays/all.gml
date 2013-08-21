#define array_print
//array_print(array)
//show_message's all the data in the array (usefull for debugging)
var test, arrayID;

arrayID = argument[0];
global.buff = "Dumping data in array with id\# "+string(arrayID)+"###Array#(#";
global.pad = "     ";

sym_print_climb(arrayID);

global.buff += ")";

message_text_font("arial",9,c_white,0);
show_message(global.buff);

test = file_text_open_write("Array_print.txt");
global.buff=string_replace_all(global.buff,"#","
")
file_text_write_string(test,global.buff)
file_text_close(test);

#define array_get
// array_get(array, key)

var keys, arrayID, n;
arrayID = argument[0];

for(n=1;n<=15;n+=1) {
	if (is_string(argument[n])) {
		keys[n-1] = argument[n];
	} else {
		if (argument[n] != 0) {
			keys[n-1] = argument[n];
		} else {
			totalKeys = n-1;
			break;
		}
	}
}

currMap = arrayID;
for(n=0;n<totalKeys;n+=1) {
	//if not last key
	if (n != (totalKeys-1)) {
		if (ds_map_exists(global.arrayMap, string(currMap)+'>'+string(keys[n]))) {
			currMap = ds_map_find_value(global.arrayMap, string(currMap)+'>'+string(keys[n]));
		} else {
			show_error("Key '"+string(keys[n])+"' does not exist in array", false);
		}
	} else {
		//if last key
		//if set to an array (to have more children), return array ID
		if (ds_map_exists(global.arrayMap, string(currMap)+'>'+string(keys[n]))) {
			return ds_map_find_value(global.arrayMap, string(currMap)+'>'+string(keys[n]));
		}
		if (ds_map_exists(currMap,keys[n])) {
			return ds_map_find_value(currMap, keys[n]);
		} else {
			show_error("Key '"+string(keys[n])+"' does not exist in array", false);
		}
	}
}

#define array_destroy2
// array_destroy(array)

var arrayID;

arrayID = argument[0];

var current, currentVal, size, parentID, parentKey;

current = ds_map_find_first(global.arrayMap);
currentVal = ds_map_find_value(global.arrayMap, current);
if (currentVal == arrayID) {
	ds_map_delete(global.arrayMap,current);
	parentID = real( string_copy(current,1, string_pos(">",current)-1) );
	parentKey = string_replace( current, string_copy(current,1, string_pos(">",current)), "" );
	ds_map_delete(parentID,parentKey);
}
	
size = ds_map_size(global.arrayMap)-1;

repeat(size) {
	current = ds_map_find_next(global.arrayMap, current);
	currentVal = ds_map_find_value(global.arrayMap, current);
	if (currentVal == arrayID) {
		ds_map_delete(global.arrayMap,current);
		parentID = real( string_copy(current,1, string_pos(">",current)-1) );
		parentKey = string_replace( current, string_copy(current,1, string_pos(">",current)), "" );
		ds_map_delete(parentID,parentKey);
	}
}

sym_destroy_climb(arrayID);

#define array_destroy
// array_destroy(array)

var arrayID, keys, deleteStart, n;

arrayID = argument[0];

for(n=1;n<=15;n+=1) {
	if (is_string(argument[n])) {
		keys[n-1] = argument[n];
	} else {
		if (argument[n] != 0) {
			keys[n-1] = argument[n];
		} else {
			totalKeys = n-1;
			break;
		}
	}
}

deleteStart = false;
currMap = arrayID;
for(n=0;n<totalKeys;n+=1) {
	//if not last key
	if (n != (totalKeys-1)) {
		if (ds_map_exists(global.arrayMap, string(currMap)+'>'+string(keys[n]))) {
			currMap = ds_map_find_value(global.arrayMap, string(currMap)+'>'+string(keys[n]));
		} else {
			show_error("Key '"+string(keys[n])+"' does not exist in array", false);
		}
	} else {
		//if last key
		//if set to an array (to have more children), fix it
		if (ds_map_exists(global.arrayMap, string(currMap)+'>'+string(keys[n]))) {
			deleteStart = true;
			arrayID = ds_map_find_value(global.arrayMap, string(currMap)+'>'+string(keys[n]));
			ds_map_delete(global.arrayMap, string(currMap)+'>'+string(keys[n]));
		}
		ds_map_delete(currMap, keys[n]);
	}
}
if ((totalKeys = 0) || (deleteStart)) {
	sym_destroy_climb(arrayID);
}


#define array_create
// array_create()

return ds_map_create();

#define array_copy
//array_copy(array)

arrayID = argument[0];

copyID = ds_map_create();

sym_copy_climb(arrayID, copyID);

return copyID;

#define sym_print_climb
//used for array_print
var arrayID, currentVal, current, size, key, n;
arrayID = argument[0];


size = ds_map_size(arrayID);

current = ds_map_find_first(arrayID);
global.buff += global.pad+"["+string(current)+"] => ";

for(n=1; n<=size; n+=1) {

	if (!ds_map_exists(global.arrayMap, string(arrayID)+'>'+string(current))) {
		currentVal = ds_map_find_value(arrayID,current);
		global.buff += string(currentVal)+"#";
	} else {
		currentVal = ds_map_find_value(global.arrayMap,string(arrayID)+'>'+string(current));
		global.buff += "Array#"+global.pad+"(#";
		global.pad += "     ";
		sym_print_climb(currentVal);
		global.pad = string_replace(global.pad,"     ","");
		global.buff += global.pad+")#"
	}
	if (n != size) {
 		current = ds_map_find_next(arrayID,current);
		global.buff += global.pad+"["+string(current)+"] => ";
	}
}



#define sym_destroy_climb
var arrayID, current, size, mapKey;

arrayID = argument[0];

size = ds_map_size(arrayID);

current = ds_map_find_first(arrayID);
mapKey = string(arrayID)+'>'+string(current);

repeat(size) {
	if (ds_map_exists(global.arrayMap, mapKey)) {
		sym_destroy_climb( ds_map_find_value(global.arrayMap,mapKey) );
		ds_map_delete(global.arrayMap,mapKey);
	}
 	current = ds_map_find_next(arrayID, current);
	mapKey = string(arrayID)+'>'+string(current);
}

ds_map_destroy(arrayID);

#define sym_copy_climb
var arrayID, copyID currentVal, current, size, fromMap, newMap;

arrayID = argument[0];
copyID = argument[1];


size = ds_map_size(arrayID);

current = ds_map_find_first(arrayID);
currentVal = ds_map_find_value(arrayID,current);
ds_map_add(copyID,current,currentVal);

for(n=1; n<=size; n+=1) {

	if (ds_map_exists(global.arrayMap, string(arrayID)+'>'+string(current))) {
		fromMap = ds_map_find_value(global.arrayMap, string(arrayID)+'>'+string(current));
		newMap = ds_map_create();
		ds_map_add(global.arrayMap, string(copyID)+'>'+string(current), newMap);
		sym_copy_climb(fromMap, newMap);
	}
 	if (n != size) {
 		current = ds_map_find_next(arrayID,current);
		currentVal = ds_map_find_value(arrayID,current);
		ds_map_add(copyID,current,currentVal);
	}
}


#define array_size
// array_size(array)

return ds_map_size(argument[0]);


#define array_set2
// array_set(array, array2, key1, key2, key3...)

var keys, n;

for(n=2;n<=16;n+=1) {
	if (is_string(argument[n])) {
		keys[n-2] = argument[n];
	} else {
		if (argument[n] != 0) {
			keys[n-2] = argument[n];
		} else {
			totalKeys = n-2;
			break;
		}
	}
}

arrayID = argument[0];
value = argument[1];

currMap = arrayID;
for(n=0;n<totalKeys;n+=1) {
	//if not last key
	if (n != (totalKeys-1)) {
		if (ds_map_exists(global.arrayMap, string(currMap)+'>'+string(keys[n]))) {
			currMap = ds_map_find_value(global.arrayMap, string(currMap)+'>'+string(keys[n]));
		} else {
			newMap = ds_map_create();
			keyStr = string(currMap)+'>'+string(keys[n]);
			ds_map_add(global.arrayMap, keyStr, newMap);
			//Set it to Array, so we don't have to loop through global.arrayMap on array_copy or array_print
			if (ds_map_exists(currMap,keys[n])) {
				ds_map_replace(currMap, keys[n], "Array")
			} else {
				ds_map_add(currMap, keys[n], "Array");
			}

			currMap = newMap;
		}
	} else {
		//if last key
		//if set to an array (to have more children), fix it
		if (ds_map_exists(global.arrayMap, string(currMap)+'>'+string(keys[n]))) {
			sym_destroy_climb( ds_map_find_value(global.arrayMap, string(currMap)+'>'+string(keys[n])) );
   			ds_map_replace(global.arrayMap, string(currMap)+'>'+string(keys[n]), value);
		} else {
			if is_string(keys[n]) if (keys[n] == "[]") {keys[n] = array_size(currMap)+1;}
			ds_map_add(global.arrayMap, string(currMap)+'>'+string(keys[n]), value);

			//replace value if it already exists, otherwise just add it
			if (ds_map_exists(currMap,keys[n])) {
				ds_map_replace(currMap, keys[n], "Array")
			} else {
				ds_map_add(currMap, keys[n], "Array");
			}
		}
	}
}

#define array_set
// array_set(array, value, key1, key2, key3...)
//LIMITATION: you can not pass 0 to this script. But you may pass "0" (string)

var keys, n, arrayID, currMap, totalKeys, keyStr, newMap;

for(n=2;n<=16;n+=1) {
	if (is_string(argument[n])) {
		keys[n-2] = argument[n];
	} else {
		if (argument[n] != 0) {
			keys[n-2] = argument[n];
		} else {
			totalKeys = n-2;
			break;
		}
	}
}

arrayID = argument[0];
value = argument[1];

currMap = arrayID;
for(n=0;n<totalKeys;n+=1) {
	//if not last key
	if (n != (totalKeys-1)) {
		if (ds_map_exists(global.arrayMap, string(currMap)+'>'+string(keys[n]))) {
			currMap = ds_map_find_value(global.arrayMap, string(currMap)+'>'+string(keys[n]));
		} else {
			newMap = ds_map_create();
			keyStr = string(currMap)+'>'+string(keys[n]);
			ds_map_add(global.arrayMap, keyStr, newMap);
			//Set it to Array, so we don't have to loop through global.arrayMap on array_copy
			if (ds_map_exists(currMap,keys[n])) {
				ds_map_replace(currMap, keys[n], "Array")
			} else {
				ds_map_add(currMap, keys[n], "Array");
			}

			currMap = newMap;
		}
	} else {
		//if last key
		//if set to an array (to have more children), fix it
		if (ds_map_exists(global.arrayMap, string(currMap)+'>'+string(keys[n]))) {
			sym_destroy_climb( ds_map_find_value(global.arrayMap, string(currMap)+'>'+string(keys[n])) );
			ds_map_delete(global.arrayMap, string(currMap)+'>'+string(keys[n]));
		}
		//replace value if it already exists, otherwise just add it
		if (ds_map_exists(currMap,keys[n])) {
			if is_string(keys[n]) if (keys[n] == "[]") {keys[n] = array_size(currMap);}
			ds_map_replace(currMap, keys[n], value)
		} else {
			if is_string(keys[n]) if (keys[n] == "[]") {keys[n] = array_size(currMap)+1;}
			ds_map_add(currMap, keys[n], value);
		}
	}
}

#define array_isSet

// array_get(array, key)

var keys, arrayID, n;
arrayID = argument[0];

for(n=1;n<=15;n+=1) {
	if (is_string(argument[n])) {
		keys[n-1] = argument[n];
	} else {
		if (argument[n] != 0) {
			keys[n-1] = argument[n];
		} else {
			totalKeys = n-1;
			break;
		}
	}
}

currMap = arrayID;
for(n=0;n<totalKeys;n+=1) {
	//if not last key
	if (n != (totalKeys-1)) {
		if (ds_map_exists(global.arrayMap, string(currMap)+'>'+string(keys[n]))) {
			currMap = ds_map_find_value(global.arrayMap, string(currMap)+'>'+string(keys[n]));
		} else {
			return false;
		}
	} else {
		//if last key
		//if set to an array (to have more children), return true
		if (ds_map_exists(global.arrayMap, string(currMap)+'>'+string(keys[n]))) {
			return true;
		}
		if (ds_map_exists(currMap,keys[n])) {
			return true;
		} else {
			return false;
		}
	}
}


#define arrays_init

//array engine initiation
global.arrayMap = ds_map_create();
//end initiation