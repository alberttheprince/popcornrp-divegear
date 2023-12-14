![image](https://github.com/alberttheprince/popcornrp-divegear/assets/85725579/14888a73-61a3-487f-bc0c-b53007c39c03)


# popcornrp-divegear

A QBCore conversion of the qbx_core diving resource that enables the functionality of diving and air tank items. 

Works with [qbx_diving](https://github.com/Qbox-project/qbx_diving/), a coral diving and collection resource, also developed by the Qbox community!

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

![diving_gear](https://github.com/Qbox-project/popcornrp-divegear/assets/85725579/739d847c-1b49-4c20-9578-6e5ec8eac179)
![diving_fill](https://github.com/Qbox-project/popcornrp-divegear/assets/85725579/62c9057d-9412-4256-aab4-59cfe015e90b)
