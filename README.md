# Relative acoustic localization with USBL (Ultra-Short Baseline)
September 2020

Robotic programmable devices such as Autonomous Underwater Vehicles (AUVs) are great means for underwater exploration, as they are capable of executing long term missions with many possible applications and goals. In this regard, the concept of using AUVs as "mules" for data transport appeared as a way to anticipate the access to collected data during autonomous missions of long duration.

The present dissertation focuses on the study of mechanisms that lead to a flexibility and precision improvement of an experimental USBL system to be used in an AUV with small dimensions, intended to operate for short and long range. Firstly, it is described the architecture design of a module that is capable of improving the precision of the time of arrival measurement of signals sent by an acoustic transmitter. Then, a study is conducted on possible methods for evaluating sensor configuration performance, as it consists on a crucial factor in estimation precision. Lastly, the adaptive configuration selection method is presented, which serves as a tool that reconfigures the set of active hydrophones, from a discrete group in fixed known positions, depending on the estimated transmitter location. This method intends to achieve a higher localization precision and rectify issues that arise from classic USBL systems.

After implementation, all developed mechanism were subjected to comprehensive simulated tests that validate its function and demonstrate promising results in controlled conditions. Additionally, preliminary tests were performed in laboratory environment, however the field tests were not executed as intended due to the current pandemic situation.

This repository contains all the research work developed for my master's dissertation. It includes:

- Developed digital signal processing module (Verilog)
- Implementation of two position estimators (MATLAB)
- Implementation of Crámer- Rao Lower Bound (MATLAB)
- Adaptive Configuration Selection Method through Monte Carlo simulations (MATLAB)
- Files for the final dissertation report (LaTeX)

