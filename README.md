#YARROWIA MEDIA OPTIMIZER

## General studies testing 96 vs 24, human vs AI pipetting tests on Yarrowia growth profiles

Uses results from a Growth Profiler. 

Thet tests were primarily for understanding growth profile data from different experimental setups
including pipelining with Julia code and Julia generated inputs and outputs

The primary purpose was to (in python) principley cluster media components, generate a clustering
object that specifies cluster components, ratios between components, and for easy transformation
to and from log10 so that cluster ratios remain consistent, while allowing for log10 values fed 
into bayesian optimiser or other machine learning models.

A large part of work just documents various received Julia outputs, and integrating with Julia

However there are general integration code for Bayesian Optimisation and the cluster object creator.

Proprietary version available @ IDEA Bio
