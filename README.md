# Seizure-prediction
Seizure prediction contains innovative methods using adaptive filtering for detecting epileptic seizures based on energy signals. 
The paper was part of the final project submitted for the course, ECE 251B on Digital Signal Processing II, at UC San Diego during Spring 2017.

The curated and trained data is available at `x_dir_new.mat`, which is used by the predicting functions

# Types of results
* Use `kf_predict.m` for prediction using kalman filtering
* Use `myparticle.m` for prediction using particle filtering
* Use `rls_predict.m` for prediction using RLS filtering

The description of the code and the results are available in the attached paper - "Seizure Prediction using Serial-Parallel Block Concatenated Adaptive Filters"

The data is downloaded from 2 sources :
1. Sleep activity eye-tracking [dataset](http://www2.hu-berlin.de/eyetracking-eeg/testdata.html) (avaiable in data folder)
2. The [Bern-Barcelona EEG database](http://ntsa.upf.edu/downloads/andrzejak-rg-schindler-k-rummel-c-2012-nonrandomness-nonlinear-dependence-and), and it is huge and is not included in the repo.

The [Test](Data/Test) folder contains the sleep activity [dataset](http://www2.hu-berlin.de/eyetracking-eeg/testdata.html) which is used as the test data.

The file [`Data_N_Ind2261.txt`](Data/Data_N_Ind2261.txt) is provided as an example of the training data used.
