# Grappling-Hook-2

A possible solution to creating a grapplig hook mechanic for a game. 

This solution uses physics only for contact detection and all bodies are 
dynamic false. So physics is not used in the example. I setup physics 
bodies for possible future use. 
 
The example presented here uses actions to move the rope target aand player object 
to a target position on the screen. Using Actions provides a few advantages
 
  1. Actions are easily configured to set the time/speed and easing. 
  2. You could easily add other actions add other features to the animation. 
  3. Using actions allows the player easily follow the hook. In other words the 
    hook moves to the target before the player starts to follow. This may or may not 
    be a desired effect, using Actions gives great control here.
 
The possible downsides to this system:
  1. Since objects are animated outside of physics you can not use physics collisions
    and "natural" physics motions. You can however use physics contacts. 
  2. To attach the hook to a moving target would difficult or impossible.
  3. 

![screenshot](screenshot.gif)
