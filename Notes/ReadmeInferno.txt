Here's the changes:
- The injection is now MUCH faster. It basically hooks straight ot a part of the code that reads the variables, and when the one we modify is read, it saves its address until it changes (changes every level).
- The effect package now gets injected automatically when connected, and reinjected when necessary (which is basically when you exit a level. Restarting or advancing to the next level does not overwrite the injections, just the values they store).
- The effect package also updates any variable location when changing levels so you don't have to worry about it.
- The package still does not recognize if you are on the main menu or paused. But worse case scenario, you get a few exceptions in the log without anything breaking.
-I added another script file, timedCCEffects.hsc. Instead of numbering effects from 0 to 788 like the first one, this one uses flags. This way we can have multiple effects run at the same time. Each frame checks if the flags changed. If they changed, a 1 runs the effect code, a 0 runs the undo effect code. Remember to move the ccBitOperator 1 bit to the left after each new effect you add, like in the examples.

If you need to add more "slots", on the .cs file you just have to copy paste the entries on line 70 for one-shot effects, or line 81 for timed effects, just changing the number.
Feel free to change the contents of the .hsc files, since you are way more experience with it than me. The only things that cannot change are the crowd control communicaion variable + the two landmarks, and the fact that scripts read said variable to know if they have to run. 

If something fails or you think should be done differently, hit me up.
