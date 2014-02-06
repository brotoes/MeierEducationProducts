dmg = argument0

if (dmg > 0) {
    dmg = floor(dmg)
    dmg = max(dmg, 1)
} else {
    dmg = ceil(dmg)
    dmg = min(dmg, -1)
}

return dmg
