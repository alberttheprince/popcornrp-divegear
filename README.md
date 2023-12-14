![image](https://github.com/alberttheprince/popcornrp-divegear/assets/85725579/8fe625ff-f02f-4d7b-8a63-15d463df893f)



# popcornrp-divegear

A QBCore conversion of the QBox diving resource that enables the functionality of diving and air tank items. 


# Dependencies
- QBCore
- Ox_inventory
- Ox_lib

# Features

- Able to set the length of time an air tank will refill your tank
- Limitations for refilling underwater (to limit endless use of air tanks)
- animations and timers during refill
- Text that displays current air time at the bottom of the player's screen when underwater and wearing gear

# ox_inventory items

Place these items in ox_inventory's item.lua if you don't have them already:

```
    ['diving_fill'] = {
        label = 'Diving Tube',
        weight = 3000,
        stack = false,
        close = true,
        description = "used to refill your diving gear's oxygen supply."
    },

    ['diving_gear'] = {
        label = 'Diving Gear',
        weight = 30000,
        stack = false,
        close = true,
        description = "A diving set that let's swim underwater. Blub blub!"
    },

```

# ox_inventory images

Missing images for your items? Here are some free-to-use images!

![diving_fill](https://github.com/alberttheprince/popcornrp-divegear/assets/85725579/1d2cb995-507e-4e2b-aadb-f8b73caa65c3)
![diving_gear](https://github.com/alberttheprince/popcornrp-divegear/assets/85725579/1e7db9a9-0f78-46f4-aa41-939907bd1406)

