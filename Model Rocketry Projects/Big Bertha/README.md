Monte Carlo Analysis of Model Rocket Trajectories Using a Deterministic Baseline

Author: Matthew Dula
Date: January 6, 2026

Overview

This project analyzes the safety of model rocket launches using a combination of deterministic simulation and Monte Carlo methods. OpenRocket is used to simulate rocket trajectories under varying wind conditions, and Python is used to process and analyze the resulting data.

The objective is to determine a maximum allowable average wind speed for which the probability of a rocket landing outside a defined launch field remains acceptably low, subject to a specified confidence bound.

Methodology

Deterministic Wind Sweep:
OpenRocket simulations were run with fixed wind speeds and no turbulence to establish a baseline relationship between wind speed and horizontal drift.

Monte Carlo Simulation:
A Monte Carlo analysis was performed at the highest viable deterministic wind speed, incorporating turbulence to model real-world variability.

Statistical Evaluation:
Results were analyzed using an empirical cumulative distribution function (CDF). The rule of three was applied to estimate an upper confidence bound on the true violation probability.

Tools Used:
1. OpenRocket (trajectory simulation)
2. Python
3. NumPy
4. Pandas
5. Matplotlib

Key Limitations:
1. Wind direction is fixed due to OpenRocket constraints
2. Variability is limited to wind speed only
3. Other uncertainties (mass variation, drag coefficient, launch angle, etc.) are not modeled

These limitations are acknowledged, and the project is intended as a pedagogical demonstration of Monte Carlo methods rather than a fully realistic safety certification.

Conclusion

The analysis indicates that launching the Estes Big Bertha under the specified conditions is safe at wind speeds up to 4 m/s, with an estimated violation probability below approximately 3% at 95% confidence.