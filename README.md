------------------------------------------------------------------------------
# Magical Vision
------------------------------------------------------------------------------
Creates visual effects when certain magical effects are active on the player, using dynamic post-processing shaders.

The blur/sharpen effects for blind/paralyze is derived from a kawase blur method ported to openMW by Epoch.

Tested using the OpenMW dev build v0.49.

------------------------------------------------------------------------------
## Configurable Variables
------------------------------------------------------------------------------
**Enable Invisibility**: (default: ON) Enable/Disable Sobel invisibility effect. 
**Enable Chameleon**:    (default: ON) Enable/Disable Sobel chameleon effect.  
**Enable Blind**:        (default: ON) Enable/Disable Blur blind effect.
**Enable Paralyze**:     (default: ON) Enable/Disable Sharpen paralyze effect. 

------------------------------------------------------------------------------
## Installing (OpenMW)
------------------------------------------------------------------------------
*Ensure that you have the [latest development build](https://openmw.org/downloads/) of OpenMW.

1. Extract the archive to the path you keep your OpenMW mods.
2. Add the path to the folder you extracted to your openmw.cfg file, load order doesn't matter:
```
data = "path/MagicalVision"
```
3. Add MagicalVision.omwscripts to the content in your openmw.cfg file, load order doesn't matter:
```
content = MagicalVision.omwscripts
```
3. Enable post-processing shaders in your `settings.cfg`.
4. Open the in-game 'Options' menu and enable 'Post Processing' in the 'Video' tab.

