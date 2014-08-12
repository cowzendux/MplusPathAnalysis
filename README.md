#MplusPathAnalysis

Use Mplus to run a Path Analysis from within SPSS

This program allows users to identify a path model that they want to test on an SPSS data set. The program then converts the active data set to Mplus format, writes a program that will perform the path analysis in Mplus, then loads the important parts of the Mplus output into the SPSS output window.

##Usage
**MplusPathAnalysis(impfile, model, corrEndo, corrExo, covar, categorical, censored, count, nominal, cluster, weight, datasetName, datasetLabels, waittime)**
* "impfile" is a string identifying the directory and filename of Mplus input file to be created by the program. This filename must end with .inp . The data file will automatically be saved to the same directory. This argument is required.
* "model" is a list of lists identifying the equations in your path model.  First, you create a set of lists that each have the outcome as the first element and then have the predictors as the following elements. Then you combine these individual equation lists into a larger list identifying the entire path model. This argument is required.
* "covar" is a list of lists identifying covariances with endogenous variables. All exogenous variables are automatically allowed to covary with each other, but covariances of exogenous variables with endogenous variables as well as covariances among endogenous variables must be specified. First, you create a set of lists that identify pairs of variables that are allowed to covary. Then you combine these lists of pairs into a single, overall list. This argument defaults to None, which would indicate that there are no extra covariances allowed with endogenous variables.
* "corrEndo" is a boolean variable that indicates whether you want to automatically correlated all of the endogenous variables in the model. Endogenous variables are those that are used as an outcome at least once in your model. If this variable is set to True, then the program will automatically include covariances among all of the endogenous variables. If this variable is set to False, then it will not, although you can still specify individual covariances between endogenous variables using the "covar" argument described above. By default, the value of corrEndo is False.
* "corrExo" is a boolean variable that indicates whether you want to automatically correlated all of the exogenous variables in the model. Exogenous variables are those that are only used as predictors and never used as outcomes in your model. If this variable is set to True, then the program will automatically include covariances among all of the exogenous variables. If this variable is set to False, then it will not, although you can still specify individual covariances between exogenous variables using the "covar" argument described above. By default, the value for corrExo is True.
* "categorical" is an optional argument that identifies a list of variables that should be treated as categorical by Mplus. Note that what Mplus calls categorical is typically called "ordinal" in other places. Use the "nominal" command described below for true categorical variables.
* "censored" is an optional argument that identifies a list of variables that should be treated as censored by Mplus.
* "count" is an optional argument that identifies a list of variables that should be treated as count variables (i.e., for Poisson regression) by Mplus.
* "nominal" is an optional argument that identifies a list of variables that should be treated as nominal variables by Mplus.
* "cluster" is an optional argument that identifies a cluster variable. This defaults to None, which would indicate that there is no clustering. Clustering is handled using Mplus type = complex.
* "weight" is an optional argument that identifies a sample weight. This defaults to None, which would indicate that there all observations are given equal weight.
* "auxiliary" is an optional argument that identifies a list of variables that are used to assist with estimating missing values but which are not to be included in the model. This defaults to None, which would indicate that there are no auxiliary variables in the analysis.
* "datasetName" is an optional argument that identifies the name of an SPSS dataset that should be used to record the coefficients.
* "datasetLabel" is an optional argument that identifies a list of labels that would be applied to the dataset containing coefficients. This can be useful if you are appending the results from multiple analyses to the same dataset.
* "waittime" is an optional argument that specifies how many seconds the program should wait after running the Mplus program before it tries to read the output file. This defaults to 5. You should be sure that you leave enough time for Mplus to finish the analyses before trying to import them into SPSS.

##Example
**MplusPathAnalysis(inpfile = "C:/users/jamie/workspace/spssmplus/path.inp",  
model = [ ["att_ch", "Tx", "yrs_tch", "age", "gender"],   
["CO", "Tx", "att_ch", "yrs_tch", "age", "gender"],  
["ES", "Tx", "att_ch", "yrs_tch", "age", "gender"],  
["IS", "Tx", "att_ch", "yrs_tch", "age", "gender"] ],  
covar = [ ["CO","ES"], ["CO", "IS"] ],  
corrEndo = False,  
corrExo = True,  
categorical = ["yrs_tch"],  
censored = None,  
count = None,  
nominal = ["Tx", "gender"],  
cluster = "school",  
weight = "demoweight",  
auxiliary = ["grade", "FRLper"],  
bDataset = None,  
betaDataset = "CLASSbeta",  
datasetLabel = ["CLASS", "Mediation"]  
waittime = 10)**
* This would test a model where a Treatment (Tx) is expected to affect attitudes towrd children (att_ch), which in turn is related to be related to three measures assessing classroom interactions (CO, ES, and IS). Years of experience teaching (yrs_tch), teacher age (age), and teacher gender (gender) are included as covariates in all of the models.  Treatment is included as a covariate in the models predicting classroom interactions so that the model can be used to accurately estimate the mediated effect. 
* CO is allowed to covary with both ES and IS. 
* The endogenous variables (which include CO, ES, and IS) are not automatically allowed to covary, although two specific covariances are allowed (CO with ES and CO with IS) as mentioned above. 
* All of the exogenous variables (which include Tx, att_ch, yrs_tch, age, and gender) are allowed to freely covary.
* Yrs_tch is treated as a categorical variable, whereas Tx and gender are treated as nominal variables. 
* The model controls for school as a random clustering factor. 
* The analysis weights the observations using the values in the variable "demoweight." 
* The variables "grade" and "FRLper" will be used to help estimate missing values but will not be included in the analytic model. 
* The standardized regression coefficients will be recorded in the SPSS dataset "CLASSbeta". This dataset would have 
two variables containing labels. All of the results from this run of the program would have the values of "CLASS" and "Mediation" for these two variables. 
* The program will wait 10 seconds after starting to run the Mplus program before it tries  to read the results back into SPSS.
