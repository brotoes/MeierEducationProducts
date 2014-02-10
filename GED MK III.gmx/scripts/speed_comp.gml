left = argument0
right = argument1

left_speed = left.speed_stat
right_speed = right.speed_stat

if (left_speed > right_speed) {
    return 1
} else if (left_speed < right_speed) {
    return -1
} else {
    return 0
}
