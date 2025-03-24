[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/rXX1_Uiw)
## Project 00
### NeXTCS
### Period: 9
## Name0: Brian Oo
## Name1: Mustafa Abdullah
---

This project will be completed in phases. The first phase will be to work on this document. Use github-flavoured markdown. (For more markdown help [click here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) or [here](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax) )

All projects will require the following:
- Researching new forces to implement.
- Method for each new force, returning a `PVector`  -- similar to `getGravity` and `getSpring` (using whatever parameters are necessary).
- A distinct demonstration for each individual force (including gravity and the spring force).
- A visual menu at the top providing information about which simulation is currently active and indicating whether movement is on or off.
- The ability to toggle movement on/off
- The ability to toggle bouncing on/off
- The user should be able to switch _between_ simluations using the number keys as follows:
  - `1`: Gravity
  - `2`: Spring Force
  - `3`: Drag
  - `4`: Custom Force
  - `5`: Combination


## Phase 0: Force Selection, Analysis & Plan
---------- 

#### Custom Force: BUOYANT FORCE

### Forumla
What is the formula for your force? Including descriptions/definitions for the symbols. (You may include a picture of the formula if it is not easily typed.)

F<sub>b</sub> = pVg
p = density of the fluid (constant, unless changed by user input)
V = volume displaced by the orb
g = acceleration due to gravity

### Custom Force
- What information that is already present in the `Orb` or `OrbNode` classes does this force use?
  - it uses bsize, which will be used to calculate "volume" (or rather area) of the Orb
  - note that mass will NOT be used, as we are looking at the density of the *fluid*, not the Orb

- Does this force require any new constants, if so what are they and what values will you try initially?
  - p, density. Trying a number between 0 and 1.
  - g, acceleration due to gravity, will be calculated based on the mass of some large fixedOrb.

- Does this force require any new information to be added to the `Orb` class? If so, what is it and what data type will you use?
  - nah.

- Does this force interact with other `Orbs`, or is it applied based on the environment?
  - applied based on the environment: deeper Orbs will be slightly more affected by this force due to g increasing.

- In order to calculate this force, do you need to perform extra intermediary calculations? If so, what?
  - Yeah.
   - calculate g (F<sub>g</sub> / m)
   - calculate V (PI * bsize^2)

--- 

### Simulation 1: Gravity
Describe how you will attempt to simulate orbital motion.
Orbs have a fixed starting velocity, proportional to their distance from the FixedOrb and perpendicular to the line connecting them.
FixedOrb has a very large mass, Orbs have small, mayhaps negligible mass (so as to not interfere with each others' orbit).

--- 

### Simulation 2: Spring
Describe what your spring simulation will look like. Explain how it will be setup, and how it should behave while running.

YOUR ANSWER HERE

--- 

### Simulation 3: Drag
Describe what your drag simulation will look like. Explain how it will be setup, and how it should behave while running.

YOUR ANSWER HERE

--- 

### Simulation 4: Custom force
Describe what your Custom force simulation will look like. Explain how it will be setup, and how it should behave while running.

YOUR ANSWER HERE

--- 

### Simulation 5: Combination
Describe what your combination simulation will look like. Explain how it will be setup, and how it should behave while running.
