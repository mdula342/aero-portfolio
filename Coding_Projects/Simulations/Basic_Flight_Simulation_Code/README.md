# Rocket Flight Monte Carlo Simulation

This project is a numerical simulation of a model rocket flight developed as a
final project for a Numerical Methods course. The simulation applies classical
physics, numerical integration, and Monte Carlo analysis to study rocket
trajectory behavior under parameter uncertainty.

## Overview

The model simulates the two-dimensional flight of a rocket powered by a single
stage booster. The equations of motion are integrated using a fourth-order
Runge–Kutta (RK4) method, accounting for thrust, gravity, drag, and propellant
mass depletion. Key orbital parameters are evaluated at apogee to assess whether
the resulting trajectory is suborbital or bound.

A Monte Carlo analysis is then performed to evaluate how uncertainty in physical
parameters affects trajectory outcomes, particularly apoapsis height.

## Methods

- Fourth-order Runge–Kutta (RK4) numerical integration
- Interpolation of discrete thrust curve data to form a continuous thrust model
- Monte Carlo simulation using Latin Hypercube sampling
- Analysis of specific orbital energy and angular momentum at apogee
- Statistical analysis of trajectory dispersion and apoapsis distribution

## Simulation Details

- Thrust data is derived from a single-stage booster thrust curve and scaled to
  produce a realistic trajectory.
- Propellant mass and integration step size were adjusted to balance numerical
  stability, accuracy, and computational expense.
- A constant launch angle is assumed throughout the flight.
- Atmospheric drag and density are modeled using simplified equations.

## Files

- IMPORTANT NOTE:
  In order for the notebook to run correctly, the thrust curve CSV must be downloaded into the same folder as the notebook
  
- `Rocket notebook with mc.ipynb`  
  Jupyter notebook containing the full simulation, numerical methods, plots, and
  Monte Carlo analysis.

- `stage1_boost_thrust.csv`  
  Discrete thrust curve data used as input for the simulation.

- `Rocket Project Report with Monte Carlo.pdf`  
  Written project report describing the model assumptions, numerical methods,
  results, and limitations.



## Results

The nominal trajectory produced by the simulation is suborbital, with apoapsis
and periapsis calculated relative to the Earth’s center of mass. Monte Carlo
results show the expected variance in trajectory outcomes due to uncertainty in
model parameters, with distributions of possible apoapses visualized through
trajectory plots and histograms.

## Limitations

- Simplified atmospheric and drag models
- No Earth rotation or staging effects
- Constant launch angle throughout ascent
- Single-stage booster attempting orbital flight (not physically realistic)

Despite these limitations, the project serves as a pedagogical introduction to
rocket trajectory modeling and uncertainty analysis using numerical methods.

## Tools & Libraries

- Python
- NumPy
- SciPy
- Matplotlib
- Jupyter Notebook
