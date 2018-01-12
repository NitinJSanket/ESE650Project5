# Feasible Path Planning for Cars and Pedestrians using Imitation Learning

## Problem Statement
Given data from a LIDAR make a 2D map of the environment using particle filter. Also use the RGBD data to obtain a birds eye view of the texture and 3D map.

## Usage Guide:
1. Run `WrapperCar.m` for running Test Script for Car Planner.
2. Run `WrapperPedestrian.m` for running Test Script for Pedestrian Planner.
3. The training Codes for `Car` and `Pedestrian` are named `TrainCar.m` and `TrainPredestrian.m` respectively.
4.  The `.mat` file with CostMap for Car and Pedestrain are called `CarModel.mat` and `PedestrainModel.mat`.

## Report:
You can find the report [here](Report/ESE650Project5.pdf).

## Sample Outputs:
Pedestrian Paths:

<img src="TestPathsPedestrain.jpg" width="480">

Car Paths:

<img src="TestPathsCar.jpg" width="480">


## References:
1. Ratliff, Nathan D., David Silver, and J. Andrew Bagnell. "Learning to search: Functional gradient techniques for imitation learning." Autonomous Robots 27.1 (2009): 25-53.
