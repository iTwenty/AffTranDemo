iOS app for playing around with affine transforms.

### Usage
- On launching the app, you should see three draggable crosshairs. Red is for origin, yellow for iHat and Green for jHat.
- Slider along the bottom controls transform from identity to values denoted by dragged crosshairs.
- Play button in bottom right advances the slider automatically from start to end over fixed period.
- Clear button next to it sets slider to zero, resetting the transform.

### TODO
- Modifying both origin and unit vectors together results in weird behaviour
- Snap to grid for draggable crosshairs
- Labelling of axes, info on current crosshair values etc