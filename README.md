# Cavalier Autonoymous Racing : Modular Simulation Testing

This is a proof of concept built to show one application of how a modular, representative simulation could help Cavalier Autonoymous Racing catch more defects in simulation.

## Motivation

Simulation is cheap. The cost of catching an error in simulation before a crash can literally be 4-6 orders of magnitude cheaper. 


## Data Logging

Data is logged to CSV file `experiment_data.csv` which has the following schema:

```
Time, HInput, VInput, Distance
0, 0.4250759, 0.1, 108.57
0.02, 0.4250759, 0.1, 108.5695
0.0246751, 0.4250759, 0.1, 108.5695
0.02985616, 0.4250759, 0.1, 108.5695
0.04638254, 0.4250759, 0.1, 108.5688
0.0633712, 0.4250759, 0.1, 108.5679
0.07980626, 0.4250759, 0.1, 108.5679
0.09639099, 0.4250759, 0.1, 108.5667
0.1132991, 0.4250759, 0.1, 108.5653
0.1299241, 0.4250759, 0.1, 108.5636
0.1463752, 0.4250759, 0.1, 108.5617
0.1632183, 0.4250759, 0.1, 108.5596
0.1800144, 0.4250759, 0.1, 108.5573
0.1968554, 0.4250759, 0.1, 108.5573
0.2135489, 0.4250759, 0.1, 108.5548
0.2302007, 0.4250759, 0.1, 108.5521
0.2467145, 0.4250759, 0.1, 108.5491
0.2634279, 0.4250759, 0.1, 108.546
0.2800636, 0.4250759, 0.1, 108.5426
0.2966016, 0.4250759, 0.1, 108.5426
0.3134222, 0.4250759, 0.1, 108.5391
```

## Failure

The goal with the simulator was to create a "hello world" simulation which is a car model which follows a line. However, I was unable to get the line follower working. 

The key factor was the use of the Spline library in Unity.

```c#

```

## Future Work

This project was built as a proof of concept. However, I see expansion into two main categories:

- Sensitivity Analysis:
- University Compute Resources: Running a single on a single node can be quite slow. A custom server 

