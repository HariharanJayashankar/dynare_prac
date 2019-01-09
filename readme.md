# Dynare Practice

This repo contains some files from practice dynare questions.

This largely follows https://m.tau.ac.il/~zvih/topics/Sargentetal07.pdf

The overall work flow goes like this:
1. Write down all the endogenous variables, exogenous variables, parameters and equilibrium defining equations
2. Make a .m file which defines a function on returning the equations to solve for to get steady state values of our variables
3. Make a .m file which is a script which:
    - Loads the parameter values and saves them in a .mat file
    - Calls the fsolve function to solve the functions defined in the steady state equations defined above
    - Saves steady state values in a .mat file
4. Make the .mod file. Load in the parameter and steady state values from respective .mat files.
5. ???
6. Profit
