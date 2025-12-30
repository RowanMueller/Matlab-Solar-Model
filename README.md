# MATLAB Orbital System Simulation

## Overview
This project is a MATLAB simulation of a gravitational orbital system. It models the motion of celestial bodies over time using numerical computation and renders the system dynamically for visualization and analysis.

The project is structured to separate system definition, physics computation, and rendering, making it easy to modify, extend, and experiment with different system configurations.

## File Structure
```
.
├── main.m           % Entry point; runs the simulation
├── sys.m            % Defines system parameters and initial conditions
├── computations.m  % Physics and numerical calculations
├── rendersystem.m  % Visualization and animation of the system
└── README.md        % Project documentation
```

## How It Works
1. **System Setup (`sys.m`)**
   - Defines bodies, masses, initial positions, and velocities
   - Establishes simulation constants and time parameters

2. **Computation (`computations.m`)**
   - Computes gravitational interactions
   - Updates positions and velocities using numerical integration

3. **Rendering (`rendersystem.m`)**
   - Visualizes the system in 2D/3D space
   - Animates orbital motion over time

4. **Execution (`main.m`)**
   - Orchestrates the simulation loop
   - Calls computation and rendering functions in sequence

## Requirements
- MATLAB R20XXa or later
- No additional toolboxes required unless specified in the code

## How to Run
1. Open MATLAB
2. Set the project directory as the working directory
3. Run:
   ```matlab
   main
   ```
4. The simulation will begin automatically and display the rendered system

## Customization
You can modify the simulation by editing:
- `sys.m` → number of bodies, masses, initial conditions
- `computations.m` → numerical method or timestep behavior
- `rendersystem.m` → visualization style, scaling, or animation settings

## Output
- Animated visualization of orbital motion
- Numerical state evolution computed at each timestep

## Limitations
- Uses simplified gravitational models
- Not intended for high-precision astrophysical prediction
- Performance may degrade with a large number of bodies

## Author
**Rowan Mueller**  
University of Virginia  
Computer / Electrical Engineering
