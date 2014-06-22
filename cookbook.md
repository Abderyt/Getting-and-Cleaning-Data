# Data sets used

## Human Activity Recognition Using Smartphones Dataset
### Version 1.0

Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Universitŕ degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws



# Feature Selection 

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc.XYZ and tGyro.XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc.XYZ and tGravityAcc.XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk.XYZ and tBodyGyroJerk.XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc.XYZ, fBodyAccJerk.XYZ, fBodyGyro.XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'.XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The set of variables that were estimated from these signals and was used in resulting data set are: 
mean: Mean value
std: Standard deviation

Moreover there are 3 additional variables:
* Set: factor variable, indicate from which data set come given record. Possible values:
+ test
+ training
* Activity.label: factor variable that describe activity. It has six levels:
  + STANDING
  + SITTING
  + LAYING
  + WALKING
  + WALKING_DOWNSTAIRS
  + WALKING_UPSTAIRS
* Subject- factor variable decribing person related with observation. There are 30 people.
