# MplusPathAnalysis

SPSS Python Extension function to use Mplus to run a path analysis from within SPSS

This program allows users to identify a path model that they want to test on an SPSS data set. The program then converts the active data set to Mplus format, writes a program that will perform the path analysis in Mplus, then loads the important parts of the Mplus output into the SPSS output window.

This and other SPSS Python Extension functions can be found at http://www.stat-help.com/python.html

##Usage
**MplusPathAnalysis(inpfile, runModel, viewOutput, latent, model, covar, covEndo, covExo, useobservations, indirect, identifiers, wald, categorical, censored, count, nominal, cluster, weight, datasetName, datasetLabels, indDatasetName, waittime)**
* "inpfile" is a string identifying the directory and filename of Mplus input file to be created by the program. This filename must end with .inp . The data file will automatically be saved to the same directory. This argument is required.
* "runModel" is a boolean argument indicating whether or not you want the program to actually run the program it creates based on the model you define. You may choose to not run the model when you want to use the program to load an existing output file into SPSS. However, when doing this, you should first load the corresponding data set so that the function can determine the appropriate translation between the Mplus variable names and SPSS variable names. By default, the model is run.
* "viewOutput" is a boolean argument indicating whether or not you want the program to read the created output into SPSS. You may choose not to read the output into SPSS when you know that it will take a very long time to run and you do not want to tie up SPSS while you are waiting for Mplus to finish. If you choose not to view the output, then the program will also not create a dataset for the coefficients. By default, the output is read into SPSS.
* "suppressSPSS" is a boolean argument indicating whether or not you want the program to supress SPSS output while running the model. Typically this output is not useful and merely clogs up the output window. However, if your model is not running correctly, the SPSS output can help you see where the errors are. Setting this argument to True will not suppress the Mplus output. By default, the SPSS output is not suppressed.
* "latent" is a list of lists identifying the relations between observed and latent variables. This argument is optional, and can be omitted if your model does not have any latent variables. When creating this argument, you first create a list of strings for each latent variable where the first element is the name of the latent variable and the remaining elements are the names of the observed variables that load on that latent variable. You then combine these individual latent variable lists into a larger list identifying the full measurement model.
* "model" is a list of lists identifying the equations in your path model.  First, you create a set of lists that each have the outcome as the first element and then have the predictors as the following elements. Then you combine these individual equation lists into a larger list identifying the entire path model. 
* "covar" is a list of lists identifying covariances with endogenous variables. First, you create a set of lists that identify pairs of variables that are allowed to covary. Then you combine these lists of pairs into a single, overall list. This argument defaults to None, which would indicate that you are not explicitly identifying covariances among the variables. However, your choices for the "covEndo" and the "covExo" arguments may allow additional covariances.
* "covEndo" is a boolean variable that indicates whether you want to automatically correlated all of the endogenous variables in the model. Endogenous variables are those that are used as an outcome at least once in your model. If this variable is set to True, then the program will automatically include covariances among all of the endogenous variables. If this variable is set to False, then it will not, although you can still specify individual covariances between endogenous variables using the "covar" argument described above. By default, the value of covEndo is False.
* "covExo" is a boolean variable that indicates whether you want to automatically correlated all of the exogenous variables in the model. Exogenous variables are those that are only used as predictors and never used as outcomes in your model. If this variable is set to True, then the program will automatically include covariances among all of the exogenous variables. If this variable is set to False, then it will not, although you can still specify individual covariances between exogenous variables using the "covar" argument described above. By default, the value for covExo is True.
* "useobservations" is a string specifying a selection criteriion that must be met for observations to be included in the analysis. This is an optional argument that defaults to None, indicating that all observations are to be included in the analysis.
* "indirect" is an optional argument that identifies a set of indirect effects that should be tested within the specified model. The argument is provided as a list of lists. Each individual list identifies a single indirect effect that should be tested. Within each list, the outcome is listed first and the predictor is listed last. If you want to test specific indirect paths, the variables in the path are listed following the outcome but before the predictor. This argument defaults to None, which would indicate that you do not want to test indirect effects.
* "identifiers" is an optional argument provides a list of lists pairing coefficients with identifiers that will be used as part of a Wald Z test. The coefficients part must specifically match an entry in the model statement. This defaults to None, which does not assign any identifiers.
* "wald" is an optional argument that identifies a list of constraints that will be tested using a Wald Z test. The constraints will be definted using the identifiers specified in the "identifiers" argument. This can be used to create an omnibus test that several coefficients are equal to zero, or it can be used to test the equivalence of different coefficients. This argument defaults to None, which would indicate that you do not want to perform a Wald Z test.
* "categorical" is an optional argument that identifies a list of variables that should be treated as categorical by Mplus. Note that what Mplus calls categorical is typically called "ordinal" in other places. Use the "nominal" command described below for true categorical variables.
* "censored" is an optional argument that identifies a list of variables that should be treated as censored by Mplus.
* "count" is an optional argument that identifies a list of variables that should be treated as count variables (i.e., for Poisson regression) by Mplus.
* "nominal" is an optional argument that identifies a list of variables that should be treated as nominal variables by Mplus.
* "cluster" is an optional argument that identifies a cluster variable. This defaults to None, which would indicate that there is no clustering. Clustering is handled using Mplus type = complex.
* "weight" is an optional argument that identifies a sample weight. This defaults to None, which would indicate that there all observations are given equal weight.
* "auxiliary" is an optional argument that identifies a list of variables that are used to assist with estimating missing values but which are not to be included in the model. This defaults to None, which would indicate that there are no auxiliary variables in the analysis.
* "datasetName" is an optional argument that identifies the name of an SPSS dataset that should be used to record the coefficients.
* "indDatasetName" is an optional argument that identifies the name of an SPSS dataset that should be used to record the tests of the indirect effects. This will do nothing if no indirect tests are defined.
* "datasetLabels" is an optional argument that identifies a list of labels that would be applied to the dataset containing coefficients. This can be useful if you are appending the results from multiple analyses to the same dataset.
* "waittime" is an optional argument that specifies how many seconds the program should wait after running the Mplus program before it tries to read the output file. This defaults to 5. You should be sure that you leave enough time for Mplus to finish the analyses before trying to import them into SPSS.

##Example 1 - Simple specification
**MplusPathAnalysis(inpfile = "C:/users/jamie/workspace/spssmplus/path.inp",  
model = [ ["att_ch", "Tx", "yrs_tch", "age", "gender"] ],  
cluster = "school")**
* This would test a model where attitudes towrd children (att_ch) is predicted by Treatment (Tx), Years of experience teaching (yrs_tch), teacher age (age), and teacher gender (gender).
* All of the exogenous variables (which include Tx, att_ch, yrs_tch, age, and gender) are allowed to freely covary. This is not specified explicitly, but is the default.
* The model controls for school as a random clustering factor. 

##Example 2 - Full specification
**MplusPathAnalysis(inpfile = "C:/users/jamie/workspace/spssmplus/path.inp",  
runModel = True,  
veiwOutput = True,   
latent = [ ["CHLATENT", "chincome_mean", "chfrl_mean", "chmomed_mean"] ],  
model = [ ["att_ch", "Tx", "yrs_tch", "age", "gender", "CHLATENT"],   
&nbsp;&nbsp;&nbsp;&nbsp;["CO", "Tx", "att_ch", "yrs_tch", "age", "gender", "CHLATENT"],  
&nbsp;&nbsp;&nbsp;&nbsp;["ES", "Tx", "att_ch", "yrs_tch", "age", "gender", "CHLATENT"],  
&nbsp;&nbsp;&nbsp;&nbsp;["IS", "Tx", "att_ch", "yrs_tch", "age", "gender", "CHLATENT"],  
&nbsp;&nbsp;&nbsp;&nbsp;["CO", "Educ"],  
&nbsp;&nbsp;&nbsp;&nbsp;["ES", "Educ"],  
&nbsp;&nbsp;&nbsp;&nbsp;["IS", "Educ"] ],  
covar = [ ["CO","ES"], ["CO", "IS"] ],  
covEndo = False,  
covExo = True,  
useobservations = "p2cond==1",  
indirect = [ ["CO", "att_ch", "Tx"],  
&nbsp;&nbsp;&nbsp;&nbsp;["ES", "att_ch", "Tx"],  
&nbsp;&nbsp;&nbsp;&nbsp;["IS", "att_ch", "Tx"] ],  
identifiers = [ [ ["CO", "Educ"], "b1"],  
&nbsp;&nbsp;&nbsp;&nbsp;[ ["ES", "Educ"], "b2"],  
&nbsp;&nbsp;&nbsp;&nbsp;[ ["IS", "Educ"], "b3"] ],  
wald = [ "b1 = 0", "b2 = 0", "b3 = 0" ],  
categorical = ["yrs_tch"],  
censored = None,  
count = None,  
nominal = ["Tx", "gender"],  
cluster = "school",  
weight = "demoweight",  
auxiliary = ["grade", "FRLper"],  
datasetName = "CLASS",  
indDatasetName = "CLASSind",  
datasetLabels = ["CLASS", "Mediation"],  
waittime = 10)**
* This would test a model where a Treatment (Tx) is expected to affect attitudes towrd children (att_ch), which in turn is related to be related to three measures assessing classroom interactions (CO, ES, and IS). Years of experience teaching (yrs_tch), teacher age (age), and teacher gender (gender) are included as covariates in all of the models.  Treatment is included as a covariate in the models predicting classroom interactions so that the model can be used to accurately estimate the mediated effect. 
* The program will both run the model and load the program into SPSS.
* A latent variable "CHLATENT" is created to represent the characteristics of the children in the classroom, based on child income (chincome_mean), child free and reduced lunch status (chfrl_mean), and mother education (chmomed_mean).
* CO is allowed to covary with both ES and IS. 
* The endogenous variables (which include CO, ES, and IS) are not automatically allowed to covary, although two specific covariances are allowed (CO with ES and CO with IS) as mentioned above. 
* All of the exogenous variables (which include Tx, att_ch, yrs_tch, age, and gender) are allowed to freely covary.
* The analysis will only include observations where the value of pcond is 1.
* The program will test the indirect effects of Tx on each of the three outcomes (CO, ES, IS) through att_ch.
* The model will use a Wald Z test to perform an omnibus test that the Educ does not have any influence on any of the three outcomes (CO, ES, IS).
* Yrs_tch is treated as a categorical variable, whereas Tx and gender are treated as nominal variables. 
* The model controls for school as a random clustering factor. 
* The analysis weights the observations using the values in the variable "demoweight." 
* The variables "grade" and "FRLper" will be used to help estimate missing values but will not be included in the analytic model. 
* The regression coefficients will be recorded in the SPSS dataset "CLASS", and the tests of indirect effects will be recorded in the SPSS dataset "CLASSind".
* Both of these datasets will have two variables containing labels, wich would have the values of "CLASS" and "Mediation" for all of the results generated by this analysis.
* The program will wait 10 seconds after starting to run the Mplus program before it tries  to read the results back into SPSS.

##Example 3 - Only reading output
**MplusPathAnalysis(inpfile = "C:/users/jamie/workspace/spssmplus/path.inp",  
runModel = False,  
model = [ ["att_ch", "Tx", "yrs_tch", "age", "gender"] ],  
cluster = "school")**
* This is the model listed in the simple specification, except that now choose to not run the model but only read its output into SPSS.
* It is not necessary to actually report the model with the withinModel, betweenModel, etc. statements. However, you can leave them in without any problems.
* Before running this command you should have loaded the appropriate data set so that the function can determine the appropriate translation between the Mplus and SPSS variables.
