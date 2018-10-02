* Encoding: UTF-8.
* Use Mplus to run a Path Analysis from within SPSS
* By Jamie DeCoster

* This program allows users to identify a path model that
* they want to test on an SPSS data set. The program then
* converts the active data set to Mplus format, writes a program
* that will perform the path analysis in Mplus, then loads the important
* parts of the Mplus output into the SPSS output window.

**** Usage: MplusPathAnalysis(inpfile, runModel, viewOutput, suppressSPSS,
latent, model, covar, covEndo, covExo, 
useobservations, indirect, identifiers, wald,
categorical, censored, count, nominal, cluster, weight, 
datasetName, datasetLabels, indDatasetName, indDatasetLabels, waittime)
**** "inpfile" is a string identifying the directory and filename of
* Mplus input file to be created by the program. This filename must end with
* .inp . The data file will automatically be saved to the same directory. This
* argument is required.
**** "latent" is a list of lists identifying the relations between observed and latent 
* variables. This argument is optional, and can be omitted if your model does
* not have any latent variables. When creating this argument, you first create a
* list of strings for each latent variable where the first element is the name of
* the latent variable and the remaining elements are the names of the observed
* variables that load on that latent variable. You then combine these individual
* latent variable lists into a larger list identifying the full measurement model.
**** "runModel" is a boolean argument indicating whether or not you want the 
* program to actually run the program it creates based on the model you define. 
* You may choose to not run the model when you want to use the program to 
* load an existing output file into SPSS. However, when doing this, you should 
* first load the corresponding data set so that the function can determine the 
* appropriate translation between the Mplus variable names and SPSS variable 
* names. By default, the model is run.
**** "viewOutput" is a boolean argument indicating whether or not you want the 
* program to read the created output into SPSS. You may choose not to read 
* the output into SPSS when you know that it will take a very long time to run and
* you do not want to tie up SPSS while you are waiting for Mplus to finish. If you 
* choose not to view the output, then the program will also not create a dataset 
* for the coefficients. By default, the output is read into SPSS.
**** "suppressSPSS" is a boolean argument indicating whether or not you want
* the program to supress SPSS output while running the model. Typically this
* output is not useful and merely clogs up the output window. However, if your
* model is not running correctly, the SPSS output can help you see where
* the errors are. Setting this argument to True will not suppress the Mplus
* output. By default, the SPSS output is not suppressed.
**** "model" is a list of lists identifying the equations in your
* path model.  First, you create a set of lists that each have the outcome as
* the first element and then have the predictors as the following elements.
* Then you combine these individual equation lists 
* into a larger list identifying the entire path model. You can omit this argument
* if you are performing a CFA and don't have any structural equations.
**** "covar" is a list of lists identifying covariances with endogenous variables. 
* First, you create a set of lists that identify pairs of variables that are allowed 
* to covary. Then you combine these lists of pairs into a single, overall list. 
* This argument defaults to None, which would indicate that you are not 
* explicitly identifying covariances among the variables. However, your 
* choices for the "covEndo" and the "covExo" arguments may allow additional 
* covariances.
**** "covEndo" is a boolean variable that indicates whether you want
* to automatically correlated all of the endogenous variables in the model.
* Endogenous variables are those that are used as an outcome at least
* once in your model. If this variable is set to True, then the program will
* automatically include covariances among all of the endogenous 
* variables. If this variable is set to False, then it will not, although
* you can still specify individual covariances between endogenous
* variables using the "covar" argument described above. By default, 
* the value of covEndo is False.
**** "covExo" is a boolean variable that indicates whether you want
* to automatically correlated all of the exogenous variables in the model.
* Exogenous variables are those that are only used as predictors and
* never used as outcomes in your model. If this variable is set to True, 
* then the program will automatically include covariances among all 
* of the exogenous variables. If this variable is set to False, then it 
* will not, although you can still specify individual covariances between 
* exogenous variables using the "covar" argument described above.
* By default, the value for covExo is True.
**** "useobservations" is a string specifying a selection
* criteriion that must be met for observations to be included in the 
* analysis. This is an optional argument that defaults to None, indicating
* that all observations are to be included in the analysis.
**** "indirect" is an optional argument that identifies a set of indirect effects
* that should be tested within the specified model. The argument is provided
* as a list of lists. Each individual list identifies a single indirect effect that
* should be tested. Within each list, the outcome is listed first and the 
* predictor is listed last. If you want to test specific indirect paths, the variables
* in the path are listed following the outcome but before the predictor. 
* This argument defaults to None, which would indicate that 
* you do not want to test indirect effects.
**** "identifiers" is an optional argument provides a list of lists pairing 
* coefficients with identifiers that will be used as part of a Wald Z test. The 
* coefficients part must specifically match a list in the "model" statement.
* To do this, you may need to separate the predictors for a single outcome 
* into different lists. This defaults to None, which does not assign any identifiers. 
**** "wald" is an optional argument that identifies a list of constraints that
* will be tested using a Wald Z test. The constraints will be definted using the
* identifiers specified in the "identifiers" argument. This can be used 
* to create an omnibus test that several coefficients are equal to zero, or it 
* can be used to test the equivalence of different coefficients. This argument 
* defaults to None, which would indicate that you do not want to perform 
* a Wald Z test.
**** "categorical" is an optional argument that identifies a list of variables
* that should be treated as categorical by Mplus. Note that what Mplus
* calls categorical is typically called "ordinal" in other places. Use the
* "nominal" command described below for true categorical variables.
**** "censored" is an optional argument that identifies a list of variables
* that should be treated as censored by Mplus.
**** "count" is an optional argument that identifies a list of variables 
* that should be treated as count variables (i.e., for Poisson regression)
* by Mplus.
**** "nominal" is an optional argument that identifies a list of variables
* that should be treated as nominal variables by Mplus.
**** "cluster" is an optional argument that identifies a cluster variable.
* This defaults to None, which would indicate that there is no clustering.
* Clustering is handled using Mplus type = complex.
**** "weight" is an optional argument that identifies a sample weight.
* This defaults to None, which would indicate that there all observations
* are given equal weight.
**** "auxiliary" is an optional argument that identifies a list of variables
* that are used to assist with estimating missing values but which are
* not to be included in the model. This defaults to None, which would
* indicate that there are no auxiliary variables in the analysis.
**** "datasetName" is an optional argument that identifies the name of
* an SPSS dataset that should be used to record the coefficients.
**** "indDatasetName" is an optional argument that identifies the name of
* an SPSS dataset that should be used to record the tests of the indirect
* effects. This will do nothing if no indirect tests are defined.
**** "datasetLabels" is an optional argument that identifies a list of
* labels that would be applied to the datasets containing coefficients or
* tests of the indirect effects. This can be useful if you are appending 
* the results from multiple analyses to the same dataset.
**** "miThreshold" is an optional argument that identifies the
* minimum chi-square change required for a modificiation index
* to be reported. Omitting this argument uses a default of 10.
**** "waittime" is an optional argument that specifies how many seconds
* the program should wait after running the Mplus program before it 
* tries to read the output file. This defaults to 5. You should be sure that
* you leave enough time for Mplus to finish the analyses before trying
* to import them into SPSS

* Example: 
MplusPathAnalysis(inpfile = "C:/users/jamie/workspace/spssmplus/path.inp",
runModel = True, 
viewOutput = True, 
suppressSPSS = True,
latent = [ ["CHLATENT", "chincome_mean", "chfrl_mean", "chmomed_mean"] ],
model = [ ["att_ch", "Tx", "yrs_tch", "age", "gender", "CHLATENT"], 
["CO", "Tx", "att_ch", "yrs_tch", "age", "gender", "CHLATENT"],
["CO", "Educ"],
["ES", "Tx", "att_ch", "yrs_tch", "age", "gender", "CHLATENT"],
["ES", "Educ"],
["IS", "Tx", "att_ch", "yrs_tch", "age", "gender", "CHLATENT"] 
["IS", "Educ"] ],
covar = [ ["CO","ES"], ["CO", "IS"] ],
covEndo = False,
covExo = True,
useobservations = "p2cond==1",
indirect = [ ["CO", "att_ch", "Tx"],
["ES", "att_ch", "Tx"],
["IS", "att_ch", "Tx"] ],
identifiers = [ [ ["CO", "Educ"], "b1"],
[ ["ES", "Educ"], "b2"],
[ ["IS", "Educ"], "b3"] ],
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
miThreshold = 4,
waittime = 10)
* This would test a model where a Treatment (Tx) is expected to affect 
* attitudes towrd children (att_ch), which in turn is related to be related
* to three measures assessing classroom interactions (CO, ES, and IS).
* The toggles are set so that the program will run the model in Mplus, 
* read the output into SPSS, and suppress the SPSS output.
* Years of experience teaching (yrs_tch), teacher age (age), and teacher
* gender (gender) are included as covariates in all of the models. 
* Treatment is included as a covariate in the models predicting classroom
* interactions so that the model can be used to accurately estimate the
* mediated effect. CO is allowed to covary with both ES and IS.
* The endogenous variables (which include CO, ES, and IS) are not
* automatically allowed to covary, although two specific covariances
* are allowed (CO with ES and CO with IS) as mentioned above. All of the 
* exogenous variables (which include Tx, att_ch, yrs_tch, age, and gender) 
* are allowed to freely covary. The analysis will only include observations 
* where the value of pcond is 1. The program will test the indirect effects 
* of Tx on each of the three outcomes (CO, ES, IS) through att_ch.
* The model will use a Wald Z test to perform an omnibus test that the 
* Educ does not have any influence on any of the three outcomes (CO, ES, IS).
* Yrs_tch is treated as a categorical variable, 
* whereas Tx and gender are treated as nominal variables. 
* The model also controls for school as a random 
* clustering factor. The analysis weights the observations using the 
* values in the variable "demoweight." The variables "grade" and "FRLper"
* will be used to help estimate missing values but will not be included in
* the analytic model. 
* The regression coefficients will be recorded in the SPSS dataset "CLASS",
* and the tests of indirect effects will be recorded in the SPSS dataset
* "CLASSind". Each of these datasets will have 
* two variables containing labels. All of the results from this run of the 
* program would have the values of "CLASS" and "Mediation" for these
* two variables. All modification indices that are greater than 4 will be
* reported in the output. The program will wait 10 seconds after starting to 
* run the Mplus program before it tries  to read the results back into SPSS.

************
* Version History
************
* 2013-09-07 Created
* 2013-09-08 Reordered variables in current data set after
exporting file to Mplus
* 2013-09-09 Fixed missing semicolon in usevariables
    Added 2 sec delay before opening output to give the computer a chance
to save the file.
* 2013-09-12 Converted cluster variable name
* 2013-09-12a Made classes program-specific
* 2013-09-12b Added specification of covariances
* 2013-09-13 Removed effects of capitalization
    Used leading zeroes in renamed variable names
* 2013-09-14 Limited length of exogenous with statements to 75 chars
* 2013-09-14a Program changes variable names back to their original values
after exporting the data set to Mplus
    Fixed an error dropping a variable when equations went over a line
* 2013-09-15 Can read output from models that do not converge
    Added waittime argument
* 2013-12-29 Fixed formatting of coefficients
* 2013-12-31 Separated coefficients, covariances, and 
    descriptives in output
* 2014-01-02 Added weight parameter
* 2014-01-06 Added covEndo and covExo parameters
* 2014-01-07 Reloaded original data file after analysis
* 2014-01-26 Added auxiliary parameter
* 2014-01-29 Removed extra ;
* 2014-02-10 Handles output without Standardized coefficients
* 2014-03-13 Replaces all nonalphanumeric chars in variable names with _
* 2014-03-13a Allows specification of nonnormal variable types:
categorical, censored, count, nominal
* 2014-03-17 No longer reloads original data file
* 2014-03-26 Added missing value statements to original data set
* 2014-03-27 Added options to save coefficients in a dataset
* 2014-03-29 Changed coefficient variable types to f8.3
* 2014-05-15 Changed default for datasetLabels to []
* 2014-05-27 Corrected error when covExo = False
* 2014-06-22 Added option to perform indirect tests
* 2014-06-23 Replaced headers in indirect section
* 2014-06-23a to 2014-06-24 Added option to save indirect tests to a dataset
* 2014-07-09 Added option for Wald Z omnibus test
* 2014-08-15 Added useobservations argument
    No longer prints auxiliary code when argument omitted
* 2014-08-18 Added support for latent variables
* 2014-08-19 Finished implementation of latent variables
* 2014-08-19a Renamed covEndo and covExo arguments
    Fixed documentation
* 2014-08-28 Corrected presentation of latent variables in output
* 2014-09-07 Added runModel and viewOutput arguments
* 2014-11-09 Corrected error when checking model
* 2015-01-19 Suppressed SPSS output
* 2015-02-20 Fixed error with missing indirect output
    Added toggle to suppress or not suppress SPSS output
* 2016-02-06 Corrected error when there are no coefficients to extract
* 2016-02-08 When a variable is missing from the data set, that variable is printed
* 2016-02-09 Replaced variable names in indirect data set
* 2016-02-10 Removed debugging code
* 2016-09-28 Replaced nonalphanumerics before checking for duplicate variable names
* 2018-04-10 Added mithreshold argument
* 2018-04-18 Added titleToPane function
* 2018-10-02 Changed runModel so that it still creates the inp file

set printback = off.
begin program python.
import spss, spssaux, os, sys, time, re, tempfile, SpssClient
from subprocess import Popen, PIPE

def _titleToPane():
    """See titleToPane(). This function does the actual job"""
    outputDoc = SpssClient.GetDesignatedOutputDoc()
    outputItemList = outputDoc.GetOutputItems()
    textFormat = SpssClient.DocExportFormat.SpssFormatText
    filename = tempfile.mktemp() + ".txt"
    for index in range(outputItemList.Size()):
        outputItem = outputItemList.GetItemAt(index)
        if outputItem.GetDescription() == u"Page Title":
            outputItem.ExportToDocument(filename, textFormat)
            with open(filename) as f:
                outputItem.SetDescription(f.read().rstrip())
            os.remove(filename)
    return outputDoc

def titleToPane(spv=None):
    """Copy the contents of the TITLE command of the designated output document
    to the left output viewer pane"""
    try:
        outputDoc = None
        SpssClient.StartClient()
        if spv:
            SpssClient.OpenOutputDoc(spv)
        outputDoc = _titleToPane()
        if spv and outputDoc:
            outputDoc.SaveAs(spv)
    except:
        print "Error filling TITLE in Output Viewer [%s]" % sys.exc_info()[1]
    finally:
        SpssClient.StopClient()

def MplusSplit(splitstring, linelength):
    returnstring = ""
    curline = splitstring
    while (len(curline) > linelength):
        splitloc = linelength
        while (curline[splitloc] == " " or curline[splitloc-1] == " "):
            splitloc = splitloc -1
        returnstring = returnstring + curline[:splitloc] + "\n"
        curline = curline[splitloc:]
    returnstring += curline
    return returnstring

def SPSSspaceSplit(splitstring, linelength):
    stringwords = splitstring.split()
    returnstring = "'"
    curline = ""
    for word in stringwords:
        if (len(word) > linelength):
            break
        if (len(word) + len(curline) < linelength - 1):
            curline += word + " "
        else:
            returnstring += curline + "' +\n'"
            curline = word + " "
    returnstring += curline[:-1] + "'"
    return returnstring

def numericMissing(definition):
    for varnum in range(spss.GetVariableCount()):
        if (spss.GetVariableType(varnum) == 0):
      # for numeric variables
            submitstring = """
missing values %s (%s).""" %(spss.GetVariableName(varnum), definition)
            spss.Submit(submitstring)

def exportMplus(filepath):
######
# Get list of current variables in SPSS data set
######
 SPSSvarlist = []
 for varnum in range(spss.GetVariableCount()):
  SPSSvarlist.append(spss.GetVariableName(varnum))

##########
# Replace non-alphanumeric characters with _ in the variable names
##########
 nonalphanumeric = [".", "@", "#", "$"]
	for t in range(spss.GetVariableCount()):
		oldname = spss.GetVariableName(t)
		newname = ""
		for i in range(len(oldname)):
			if(oldname[i] in nonalphanumeric):
				newname = newname +"_"
			else:
				newname = newname+oldname[i]
		for i in range(t):
			compname = spss.GetVariableName(i)
			if (newname.lower() == compname.lower()):
				newname = "var" + "%05d" %(t+1)
		if (oldname != newname):
			submitstring = "rename variables (%s = %s)." %(oldname, newname)
			spss.Submit(submitstring)
#########
# Rename variables with names > 8 characters
#########
 for t in range(spss.GetVariableCount()):
		if (len(spss.GetVariableName(t)) > 8):
			name = spss.GetVariableName(t)[0:8]
			for i in range(spss.GetVariableCount()):
				compname = spss.GetVariableName(i)
				if (name.lower() == compname.lower()):
					name = "var" + "%05d" %(t+1)
			submitstring = "rename variables (%s = %s)." %(spss.GetVariableName(t), name)
			spss.Submit(submitstring)

# Obtain lists of variables in the dataset
	varlist = []
	numericlist = []
	stringlist = []
	for t in range(spss.GetVariableCount()):
		varlist.append(spss.GetVariableName(t))
		if (spss.GetVariableType(t) == 0):
			numericlist.append(spss.GetVariableName(t))
		else:
			stringlist.append(spss.GetVariableName(t))

###########
# Automatically recode string variables into numeric variables
###########
# First renaming string variables so the new numeric vars can take the 
# original variable names
	submitstring = "rename variables"
	for var in stringlist:
		submitstring = submitstring + "\n " + var + "=" + var + "_str"
	submitstring = submitstring + "."
	spss.Submit(submitstring)

# Recoding variables
 if (len(stringlist) > 0):
 	submitstring = "AUTORECODE VARIABLES="
	 for var in stringlist:
		 submitstring = submitstring + "\n " + var + "_str"
 	submitstring = submitstring + "\n /into"
	 for var in stringlist:
		 submitstring = submitstring + "\n " + var
 	submitstring = submitstring + """
   /BLANK=MISSING
   /PRINT."""
	 spss.Submit(submitstring)
	
# Dropping string variables
	submitstring = "delete variables"
	for var in stringlist:
		submitstring = submitstring + "\n " + var + "_str"
	submitstring = submitstring + "."
	spss.Submit(submitstring)

# Set all missing values to be -999
	submitstring = "RECODE "
	for var in varlist:
		submitstring = submitstring + " " + var + "\n"
	submitstring = submitstring + """ (MISSING=-999).
EXECUTE."""
	spss.Submit(submitstring)

 numericMissing("-999")

########
# Convert date and time variables to numeric
########
# SPSS actually stores dates as the number of seconds that have elapsed since October 14, 1582.
# This syntax takes variables with a date type and puts them in their natural numeric form

 submitstring = """numeric ddate7663804 (f11.0).
alter type ddate7663804 (date11).
ALTER TYPE ALL (DATE = F11.0).
alter type ddate7663804 (adate11).
ALTER TYPE ALL (ADATE = F11.0).
alter type ddate7663804 (time11).
ALTER TYPE ALL (TIME = F11.0).

delete variables ddate7663804."""
 spss.Submit(submitstring)

######
# Obtain list of transformed variables
######
 submitstring = """MATCH FILES /FILE=*
  /keep="""
 for var in varlist:
		submitstring = submitstring + "\n " + var
 submitstring = submitstring + """.
EXECUTE."""
 spss.Submit(submitstring)
 MplusVarlist = []
 for varnum in range(spss.GetVariableCount()):
  MplusVarlist.append(spss.GetVariableName(varnum))

############
# Create data file
############
# Break filename over multiple lines
 splitfilepath = SPSSspaceSplit(filepath, 60)

# Save data as a tab-delimited text file
	submitstring = """SAVE TRANSLATE OUTFILE=
	%s
  /TYPE=TAB
  /MAP
  /REPLACE
  /CELLS=VALUES
	/keep""" %(splitfilepath)
	for var in varlist:
		submitstring = submitstring + "\n " + var
	submitstring = submitstring + "."
	spss.Submit(submitstring)

##############
# Rename variables back to original values
##############
 submitstring = "rename variables"
 for s, m in zip(SPSSvarlist, MplusVarlist):
  submitstring += "\n(" + m + "=" + s + ")"
 submitstring += "."
 spss.Submit(submitstring)

 return MplusVarlist

class MplusPAprogram:
    def __init__(self):
        self.title = "TITLE:\n"
        self.data = "DATA:\n"
        self.variable = "VARIABLE:\n"
        self.define = "DEFINE:\n"
        self.analysis = "ANALYSIS:\n"
        self.model = "MODEL:\n"
        self.output = "OUTPUT:\n"
        self.savedata = "SAVEDATA:\n"
        self.plot = "PLOT:\n"
        self.montecarlo = "MONTECARLO:\n"

    def setTitle(self, titleText):
        self.title += titleText

    def setData(self, filename):
        self.data += "File is\n"
        splitName = MplusSplit(filename, 75)
        self.data += "'" + splitName + "';"

    def setVariable(self, fullList, latent, model, useobservations, 
categorical, censored, count, nominal, cluster, weight, auxiliary):
        self.variable += "Names are\n"
        for var in fullList:
            self.variable += var + "\n"
        self.variable += ";\n\n"

# Determine usevariables
        useList = []
        latentName = []
        if (latent != None):
            for equation in latent:
                latentName.append(equation[0])
                for var in equation[1:]:
                    if (var not in useList):
                        useList.append(var)
        if (model != None):
            for equation in model:
                for var in equation:
                    if (var not in useList and var not in latentName):
                        useList.append(var)
        self.variable += "Usevariables are\n"
        for var in useList:
            self.variable += var + "\n"

# Other variable additions
        if (useobservations != None):
            self.variable += ";\n\nuseobservations are " + useobservations
        if (cluster != None):
            self.variable += ";\n\ncluster is " + cluster
        if (weight != None):
            self.variable += ";\n\nweight is " + weight
        if (auxiliary != []):
            self.variable += ";\n\nauxiliary = (m) " 
            for var in auxiliary:
                self.variable += var + "\n"

        vartypeList = [categorical, censored, count, nominal]
        varnameList = ["categorical", "censored", "count", "nominal"]
        for t in range(len(vartypeList)):
            if (vartypeList[t] != []):
                self.variable += ";\n\n{0} = ".format(varnameList[t])
                for var in vartypeList[t]:
                    self.variable += var + "\n"
        self.variable += ";\n\nMISSING ARE ALL (-999);"

    def setAnalysis(self, cluster):
        if (cluster != None):
            self.analysis += "type = complex;"

    def setModel(self, MplusLatent, MplusModel, MplusCovar, 
cEndo, cExo, MplusIndirect, MplusIdentifiers, wald):
# Latent variable definitions
        if (MplusLatent != None):
            for equation in MplusLatent:
                curline = equation[0] + " by"
                for var in equation[1:]:
                        if (len(curline) + len(var) < 75):
                            curline += " " + var
                        else:
                            self.model += curline + "\n"
                            curline = var
                self.model += curline + ";\n\n"

# Regression equations
        if (MplusModel != None):
            for equation in MplusModel:
                curline = equation[0] + " on"
                for var in equation[1:]:
                        if (len(curline) + len(var) < 75):
                            curline += " " + var
                        else:
                            self.model += curline + "\n"
                            curline = var
                if (MplusIdentifiers != None):
                    for id in MplusIdentifiers:
                        if (equation == id[0]):
                            curline += " (" + id[1] + ")"
                self.model += curline + ";\n"

# Getting lists of endogenous and exogenous variables
            endo = []
            for equation in MplusModel:
                endo.append(equation[0])
            endo = list(set(endo))
            exo = []
            for equation in MplusModel:
                for var in equation:
                    if (var not in endo and var not in exo):
                        exo.append(var)

# Add defined covariances
        if (MplusCovar != None):
            for t in range(len(MplusCovar)):
                self.model += "\n" + MplusCovar[t][0] + " with "  
                self.model += MplusCovar[t][1] + ";"
            self.model += "\n"

# Covariances for all exogenous variables
        if (cExo == True and MplusModel != None):
# Estimate variances for exogenous variables so that they
# will be included in FIML
            if (len(exo) > 0):
                for var in exo:
                    self.model += "\n" + var + ";"
                self.model += "\n"
                for t in range(len(exo)-1):
                    self.model += "\n" 
                    curline = exo[t] + " with"
                    for var in exo[t+1:]:
                        if (len(curline) + len(var) < 75):
                            curline = curline + " " + var
                        else:
                            self.model += curline + "\n"
                            curline = var
                    self.model += curline + ";"

# Covariances for all endgenous variables
        if (cEndo == True and MplusModel != None):
            if (len(endo) > 0):
                self.model += "\n"
                for t in range(len(endo)-1):
                    self.model += "\n" 
                    curline = endo[t] + " with"
                    for var in endo[t+1:]:
                        if (len(curline) + len(var) < 75):
                            curline = curline + " " + var
                        else:
                            self.model += curline + "\n"
                            curline = var
                    self.model += curline + ";"

# Indirect effect tests
        if (MplusIndirect != None):
            self.model += "\n\nMODEL INDIRECT:"
            for t in MplusIndirect:
                if (len(t) == 2):
                    line = t[0] + " ind " + t[1] + ";"
                if (len(t) > 2):
                    line = t[0] + " via"                    
                    for i in t[1:]:
                        line += " " + i
                    line += ";"
                self.model += "\n" + line

# Wald test
        if (MplusIdentifiers != None and wald != None):
            self.model += "\n\nMODEL TEST:"
            for line in wald:
                self.model += "\n" + line + ";"

    def setOutput(self, outputText):
        self.output += outputText

    def write(self, filename):
# Write input file
        sectionList = [self.title, self.data, self.variable, self.define,
self.analysis, self.model, self.output, self.savedata, 
self.plot, self.montecarlo]
        outfile = open(filename, "w")
        for sec in sectionList:
            if (sec[-2:] != ":\n"):
                outfile.write(sec)
                outfile.write("\n\n")
        outfile.close()

def batchfile(directory, filestem):
# Write batch file
    batchFile = open(directory + "/" + filestem + ".bat", "w")
    batchFile.write("cd " + directory + "\n")
    batchFile.write("call mplus \"" + filestem + ".inp" + "\"\n")
    batchFile.close()

# Run batch file
    p = Popen(directory + "/" + filestem + ".bat", cwd=directory)

def removeBlanks(processString):
    if (processString == None):
        return (None)
    else:
        for t in range(len(processString), 0, -1):
                if (processString[t-1] != "\n"):
                    return (processString[0:t])

def getCoefficients(outputBlock):
    if (outputBlock == None):
        return None
    else:
       outputBlock2 = outputBlock.replace("\r", "")
       blockList = outputBlock2.split("\n")
       coefficients = []
       for t in range(len(blockList)):
               values1 = blockList[t].split(" ")
               values2 = []
               for i in values1:
                   if (i != ""):
                       values2.append(i)

               if (len(values2) > 1):
                   if (values2[1] == "ON"):
                       outcome = values2[0]
                   if (len(values2) > 2 and values2[0] != "Estimate"):
                       line = [outcome]
                       line.extend(values2[0:1])
                       for j in values2[1:]:
                           line.append(float(j))
                       coefficients.append(line)
       return coefficients

def getIndirect(outputBlock):
    outputBlock2 = outputBlock.replace("\r", "")
    blockList = outputBlock2.split("\n")
    coefficients = []
    for t in range(len(blockList)):
            values1 = blockList[t].split(" ")
            values2 = []
            for i in values1:
                if (i != ""):
                    values2.append(i)

            if ("Effects from") in blockList[t]:
                effect = " ".join(values2[2:])
            if ("Total" in values2):
                if (values2[1] == "indirect"):
                    line = [effect, "Total indirect", 0]
                    for j in values2[2:]:
                        line.append(float(j))
                    coefficients.append(line)
                else:
                    line = [effect, "Total", 0]
                    for j in values2[1:]:
                        line.append(float(j))
                    coefficients.append(line)
            if ("Specific indirect") in blockList[t]:
                specific = 1
                path = ""
                while (t < len(blockList)-1):
                    t += 1
                    if ("Effects from" in blockList[t]):
                        t += -1
                        break
                    values1 = blockList[t].split(" ")
                    values2 = []
                    for i in values1:
                       if (i != ""):
                           values2.append(i)
                    if (len(values2) == 1):
                        if (values2[0] == "Direct"):
                            specific = 0
                        path += values2[0] + " "
                    if (len(values2) > 1):
                        path += values2[0]
                        line = [effect, path, specific]
                        path = ""
                        for j in values2[1:]:
                            line.append(float(j))
                        coefficients.append(line)
    return coefficients

class MplusPAoutput:
    def __init__(self, filename, Mplus, SPSS):
        infile = open(filename, "rb")
        fileText = infile.read()
        infile.close()
        outputList = fileText.split("\n")

        self.header = """                                                                   Two-Tailed 
                                   Estimate       S.E.  Est./S.E.    P-Value"""
        self.summary = None
        self.warnings = None
        self.fit = None
        self.measurement = None
        self.coefficients = None
        self.covariances = None
        self.descriptives = None
        self.Zmeasurement = None
        self.Zcoefficients = None
        self.Zcovariances = None
        self.Zdescriptives = None
        self.r2 = None
        self.indirect = None
        self.Zindirect = None
        self.mi = None

# Summary
        for t in range(len(outputList)):
            if ("SUMMARY OF ANALYSIS" in outputList[t]):
                start = t
            if ("Number of continuous latent variables" in outputList[t]):
                end = t
        self.summary = "\n".join(outputList[start:end+1])
# Warnings
        for t in range(len(outputList)):
            if ("Covariance Coverage" in outputList[t]):
                covcov = t
        blank = 0
        for t in range(covcov, len(outputList)):
            if (len(outputList[t]) < 2):
                blank = 1
            if (blank == 1 and len(outputList[t]) > 1):
                start = t
                break
        for t in range(start, len(outputList)):
            if ("MODEL FIT INFORMATION" in outputList[t] or
"MODEL RESULTS" in outputList[t]):
                end = t
                break
        self.warnings = "\n".join(outputList[start:end])
        self.warnings = removeBlanks(self.warnings)

        if ("MODEL ESTIMATION TERMINATED NORMALLY" in self.warnings):
# Fit statistics
            start = end
            for t in range(start, len(outputList)):
                if ("MODEL RESULTS" in outputList[t]):
                    end = t
                    break
            self.fit = "\n".join(outputList[start:end])
            self.fit = removeBlanks(self.fit)

# Unstandardized measurement model
        start = end
        secexists = 0
        for t in range(start, len(outputList)):
            if (re.search(r"\bBY\b", outputList[t])):
                start = t
                secexists = 1
                break
        if (secexists == 1):
            for t in range(start, len(outputList)):
                if (re.search(r"\bON\b", outputList[t]) or
    re.search(r"\bWITH\b", outputList[t]) or
    re.search(r"\bMeans\b", outputList[t])):
                    end = t
                    break
            self.measurement = "\n".join(outputList[start:end])
            self.measurement = removeBlanks(self.measurement)

# Unstandardized coefficients
        start = end
        secexists = 0
        for t in range(start, len(outputList)):
            if (re.search(r"\bON\b", outputList[t])):
                start = t
                secexists = 1
                break
        if (secexists == 1):
            for t in range(start, len(outputList)):
                if (re.search(r"\bWITH\b", outputList[t]) or
    re.search(r"\bMeans\b", outputList[t])):
                    end = t
                    break
            self.coefficients = "\n".join(outputList[start:end])
            self.coefficients = removeBlanks(self.coefficients)

# Unstandardized covariances
        start = end
        secexists = 0
        for t in range(start, len(outputList)):
            if (re.search(r"\bWITH\b", outputList[t])):
                start = t
                secexists = 1
                break
        if (secexists == 1):
            for t in range(start, len(outputList)):
                if (re.search(r"\bMeans\b", outputList[t])):
                    end = t
                    break
            self.covariances = "\n".join(outputList[start:end])
            self.covariances = removeBlanks(self.covariances)

# Unstandardized Descriptives
        start = end
        for t in range(start, len(outputList)):
            if ("STANDARDIZED MODEL RESULTS" in outputList[t] or
"MODEL COMMAND" in outputList[t]):
                end = t
                break
        self.descriptives = "\n".join(outputList[start:end])
        self.descriptives = removeBlanks(self.descriptives)

# Standardized measurement model
        if ("MODEL ESTIMATION TERMINATED NORMALLY" in self.warnings):
            start = end
            secexists = 0
            for t in range(start, len(outputList)):
                if (re.search(r"\bBY\b", outputList[t])):
                    start = t
                    secexists = 1
                    break
            if (secexists == 1):
                for t in range(start, len(outputList)):
                    if (re.search(r"\bON\b", outputList[t]) or
    re.search(r"\bWITH\b", outputList[t]) or
    re.search(r"\bMeans\b", outputList[t])):
                        end = t
                        break
                self.Zmeasurement = "\n".join(outputList[start:end])
                self.Zmeasurement = removeBlanks(self.Zmeasurement)

# Standardized coefficients
            start = end
            secexists = 0
            for t in range(end, len(outputList)):
                if (re.search(r"\bON\b", outputList[t])):
                    start = t
                    secexists = 1
                    break
            if (secexists == 1):
                for t in range(start, len(outputList)):
                    if (re.search(r"\bWITH\b", outputList[t]) or
    re.search(r"\bMeans\b", outputList[t])):
                        end = t
                        break
                self.Zcoefficients = "\n".join(outputList[start:end])
                self.Zcoefficients = removeBlanks(self.Zcoefficients)

# Standardized covariances
            start = end
            secexists = 0
            for t in range(start, len(outputList)):
                if (re.search(r"\bWITH\b", outputList[t])):
                    start = t
                    secexists = 1
                    break
            if (secexists == 1):
                for t in range(start, len(outputList)):
                    if (re.search(r"\bMeans\b", outputList[t])):
                        end = t
                        break
                self.Zcovariances = "\n".join(outputList[start:end])
                self.Zcovariances = removeBlanks(self.Zcovariances)

# Standardized descriptives
            start = end
            for t in range(start, len(outputList)):
                if ("R-SQUARE" in outputList[t]):
                    end = t
                    break
            self.Zdescriptives = "\n".join(outputList[start:end])
            self.Zdescriptives = removeBlanks(self.Zdescriptives)

# R squares
            start = end
            for t in range(start, len(outputList)):
                if ("QUALITY OF NUMERICAL RESULTS" in outputList[t]):
                    end = t
                    break
            self.r2 = "\n".join(outputList[start:end])
            self.r2 = removeBlanks(self.r2)

# Indirect effects
            stest = 0
            for t in range(end, len(outputList)):
                if ("INDIRECT" in outputList[t]):
                    start = t
                    stest = 1
                    break
            if (stest == 1):
                for t in range(start, len(outputList)):
                    if ("STANDARDIZED TOTAL" in outputList[t]):
                        end = t-1
                        break        
                self.indirect = "\n".join(outputList[start:end])
                self.indirect = removeBlanks(self.indirect)
                start = end
                for t in range(start, len(outputList)):
                    if ("Beginning Time" in outputList[t] 
or "TECHNICAL" in outputList[t]
or "MODIFICATION" in outputList[t]):
                        end = t-1
                        break
                self.Zindirect = "\n".join(outputList[start:end])
                self.Zindirect = removeBlanks(self.Zindirect)
    
# Modification indices
            for t in range(end, len(outputList)):
                stest = 0
                if ("MODEL MODIFICATION INDICES" in outputList[t]):
                    start = t
                    mitest = 1
                    break
            if (stest == 1):
                for t in range(start, len(outputList)):
                    if ("Beginning Time" in outputList[t] or "TECHNICAL" in outputList[t]):
                        end = t-1
                        break
                self.mi = "\n".join(outputList[start:end])
                self.mi = removeBlanks(self.mi)

# Replacing variable names
# In the Coefficients section, initially room for 17
#    A) Increasing overall width from 61 to 75 = gain of 14
# In the Modification indices section, 
# there is initially room for 2 vars X 10 characters
#    A) Increasing overall width from 67 to 77 = gain of 5 for each var
#    B) Drop STD EPC = gain of 6 for each var
#    C) Change "StdYX E.P.C." to "StdYX EPC" = gain of 2 for each var
# Making all variables length of 23

# Variables
        for var1, var2 in zip(Mplus, SPSS):
            var1 += " "*(8-len(var1))
            var1 = " " + var1 + " "
            if (len(var2) < 23):
                var2 += " "*(23-len(var2))
            else:
                var2 = var2[:23]
            var2 = " " + var2 + " "

            if (self.measurement != None):
                self.measurement = self.measurement.replace(var1.upper(), var2)
            if (self.coefficients != None):
                self.coefficients = self.coefficients.replace(var1.upper(), var2)
            if (self.covariances != None):
                self.covariances = self.covariances.replace(var1.upper(), var2)
            if (self.descriptives != None):
                self.descriptives = self.descriptives.replace(var1.upper(), var2)
            if (self.Zmeasurement != None):
                self.Zmeasurement = self.Zmeasurement.replace(var1.upper(), var2)
            if (self.Zcoefficients != None):
                self.Zcoefficients = self.Zcoefficients.replace(var1.upper(), var2)
            if (self.Zcovariances != None):
                self.Zcovariances = self.Zcovariances.replace(var1.upper(), var2)
            if (self.Zdescriptives != None):
                self.Zdescriptives = self.Zdescriptives.replace(var1.upper(), var2)
            if (self.r2 != None):
                self.r2 = self.r2.replace(var1.upper(), var2)
            if (self.indirect != None):
                self.indirect = self.indirect.replace(var1.upper(), var2)
                self.indirect = re.sub(r"\b"+var1.upper().strip()+r"\b", r"\b"+var2.strip() + r"\b", self.indirect)
            if (self.Zindirect != None):
                self.Zindirect = self.Zindirect.replace(var1.upper(), var2)
                self.Zindirect = re.sub(r"\b"+var1.upper().strip()+r"\b", r"\b"+var2.strip() + r"\b", self.Zindirect)

# R2 section
        if (self.r2 != None):
            self.r2 = self.r2.replace("Variable        Estimate       S.E.  Est./S.E.    P-Value", 
"Variable                       Estimate       S.E.  Est./S.E.    P-Value")
            self.r2 = self.r2.replace("Two-Tailed", "              Two-Tailed")

# Indirect section
        if (self.indirect != None):
            self.indirect = self.indirect.replace("Estimate       S.E.  Est./S.E.    P-Value", 
"               Estimate       S.E.  Est./S.E.    P-Value")
            self.indirect = self.indirect.replace("Two-Tailed", "              Two-Tailed")
            self.indirect = self.indirect.replace("Total   ", 
"Total                  ")
            self.indirect = self.indirect.replace("Total indirect       ",
"Total indirect                      ")
            self.indirect = self.indirect.replace("Sum of indirect      ",
"Sum of indirect                    ")
        if (self.Zindirect != None):
            self.Zindirect = self.Zindirect.replace("Estimate       S.E.  Est./S.E.    P-Value", 
"               Estimate       S.E.  Est./S.E.    P-Value")
            self.Zindirect = self.Zindirect.replace("Two-Tailed", "              Two-Tailed")
            self.Zindirect = self.Zindirect.replace("Total   ", 
"Total                  ")
            self.Zindirect = self.Zindirect.replace("Total indirect       ",
"Total indirect                      ")
            self.Zindirect = self.Zindirect.replace("Sum of indirect      ",
"Sum of indirect                    ")

# MI section
        if (self.mi != None and
not ("THE STANDARD ERRORS OF THE MODEL PARAMETER ESTIMATES COULD NOT" 
in self.warnings)):
            for var1, var2 in zip(Mplus, SPSS):
                if (len(var2) > 23):
                    var2 = var2[:23]
                else:
                    var1 = var1 + " "
                    var2 = var2 + " "
                self.mi = self.mi.replace(var1.upper(), var2)
            self.mi = self.mi.replace("""M.I.     E.P.C.  Std E.P.C.  StdYX E.P.C.""",
"""                          MI         EPC   StdYX EPC""")
            newMI = []
            miLines = self.mi.split("\n")
            for line in miLines:
                if (" ON " in line or " BY " in line or " WITH " in line):
                    miWords = line.split()
                    newLine = miWords[0] + " "*(23-len(miWords[0]))
                    newLine += " " + miWords[1] + " "*(5-len(miWords[1]))
                    newLine += miWords[2] + " "*(23-len(miWords[2]))
                    newLine += " "*(8-len(miWords[3])) + miWords[3] + "  "
                    newLine += " "*(8-len(miWords[4])) + miWords[4] + "  "
                    newLine += " "*(8-len(miWords[6])) + miWords[6] + "  "
                    newMI.append(newLine)
                else:
                    newMI.append(line)
            self.mi = "\n".join(newMI)

# Print function
    def toSPSSoutput(self):

        spss.Submit("title 'SUMMARY'.")
        print self.summary
        spss.Submit("title 'WARNINGS'.")
        print self.warnings
        if ("MODEL ESTIMATION TERMINATED NORMALLY" in self.warnings):
            spss.Submit("title 'FIT STATISTICS'.")
            print self.fit
        if (self.measurement != None):
            spss.Submit("title 'UNSTANDARDIZED MEASUREMENT MODEL'.")
            print "Unstandardized"
            print self.header
            print self.measurement
        if (self.coefficients != None):
            spss.Submit("title 'UNSTANDARDIZED COEFFICIENTS'.")
            print "Unstandardized"
            print self.header
            print self.coefficients
        if (self.covariances != None):
            spss.Submit("title 'UNSTANDARDIZED COVARIANCES'.")
            print "Unstandardized"
            print self.header
            print self.covariances
        spss.Submit("title 'UNSTANDARDIZED DESCRIPTIVES'.")
        print "Unstandardized"
        print self.header
        print self.descriptives

        if (self.Zmeasurement != None):
            spss.Submit("title 'STANDARDIZED MEASUREMENT MODEL'.")
            print "Standardized"
            print self.header
            print self.Zmeasurement
        if (self.Zcoefficients != None):
            spss.Submit("title 'STANDARDIZED COEFFICIENTS'.")
            print "Standardized"
            print self.header
            print self.Zcoefficients
        if (self.Zcovariances != None):
            spss.Submit("title 'STANDARDIZED COVARIANCES'.")
            print "Standardized"
            print self.header
            print self.Zcovariances
        if (self.Zdescriptives != None):
            spss.Submit("title 'STANDARDIZED DESCRIPTIVES'.")
            print "Standardized"
            print self.header
            print self.Zdescriptives
        if (self.r2 != None):
            spss.Submit("title 'R-SQUARES'.")
            print self.r2
        if (self.indirect != None):
            spss.Submit("title 'INDIRECT EFFECTS'.")
            print self.indirect
        if (self.Zindirect != None):
            spss.Submit("title 'STANDARDIZED INDIRECT EFFECTS'.")
            print self.Zindirect
        if (self.mi != None):
            spss.Submit("title 'MODIFICATION INDICES'.")
            print self.mi     

# Save coefficients to dataset
    def toSPSSdata(self, datasetName = "MPAcoefs", labelList = []):
# Determine active data set so we can return to it when finished
        activeName = spss.ActiveDataset()
# Set up data set if it doesn't already exist
        tag,err = spssaux.createXmlOutput('Dataset Display',
omsid='Dataset Display', subtype='Datasets')
        datasetList = spssaux.getValuesFromXmlWorkspace(tag, 'Datasets')

        if (datasetName not in datasetList):
            spss.StartDataStep()
            datasetObj = spss.Dataset(name=None)
            dsetname = datasetObj.name
            datasetObj.varlist.append("Outcome", 50)
            datasetObj.varlist.append("Predictor", 50)
            datasetObj.varlist.append("b_Coefficient", 0)
            datasetObj.varlist.append("b_SE", 0)
            datasetObj.varlist.append("b_Ratio", 0)
            datasetObj.varlist.append("b_p", 0)
            datasetObj.varlist.append("beta_Coefficient", 0)
            datasetObj.varlist.append("beta_SE", 0)
            datasetObj.varlist.append("beta_Ratio", 0)
            datasetObj.varlist.append("beta_p", 0)
            spss.EndDataStep()
            submitstring = """dataset activate {0}.
dataset name {1}.""".format(dsetname, datasetName)
            spss.Submit(submitstring)

        spss.StartDataStep()
        datasetObj = spss.Dataset(name = datasetName)
        spss.SetActive(datasetObj)

# Label variables
        variableList =[]
        for t in range(spss.GetVariableCount()):
            variableList.append(spss.GetVariableName(t))
        for t in range(len(labelList)):
            if ("label{0}".format(str(t)) not in variableList):
                datasetObj.varlist.append("label{0}".format(str(t)), 50)
        spss.EndDataStep()

# Set variables to f8.3
        submitstring = "alter type b_Coefficient to beta_p (f8.3)."
        spss.Submit(submitstring)

# Get coefficients
        bCoef = getCoefficients(self.coefficients)
        zCoef = getCoefficients(self.Zcoefficients)
        
# Determine values for dataset
        dataValues = []
        for t in range(len(bCoef)):
            rowList = bCoef[t]
            rowList.extend(zCoef[t][2:])
            rowList.extend(labelList)
            dataValues.append(rowList)

# Put values in dataset
        spss.StartDataStep()
        datasetObj = spss.Dataset(name = datasetName)
        for t in dataValues:
            datasetObj.cases.append(t)
        spss.EndDataStep()

# Return to original data set
        spss.StartDataStep()
        datasetObj = spss.Dataset(name = activeName)
        spss.SetActive(datasetObj)
        spss.EndDataStep()

# Save indirect tests to dataset
    def indirectToSPSSdata(self, datasetName = "MPAindirect", labelList = []):

# Determine active data set so we can return to it when finished
        activeName = spss.ActiveDataset()
# Set up data set if it doesn't already exist
        tag,err = spssaux.createXmlOutput('Dataset Display',
omsid='Dataset Display', subtype='Datasets')
        datasetList = spssaux.getValuesFromXmlWorkspace(tag, 'Datasets')

        if (datasetName not in datasetList):
            spss.StartDataStep()
            datasetObj = spss.Dataset(name=None)
            dsetname = datasetObj.name
            datasetObj.varlist.append("IndirectTest", 200)
            datasetObj.varlist.append("Path", 200)
            datasetObj.varlist.append("SpecificEffect", 0)
            datasetObj.varlist.append("b_Coefficient", 0)
            datasetObj.varlist.append("b_SE", 0)
            datasetObj.varlist.append("b_Ratio", 0)
            datasetObj.varlist.append("b_p", 0)
            datasetObj.varlist.append("beta_Coefficient", 0)
            datasetObj.varlist.append("beta_SE", 0)
            datasetObj.varlist.append("beta_Ratio", 0)
            datasetObj.varlist.append("beta_p", 0)
            spss.EndDataStep()
            submitstring = """dataset activate {0}.
dataset name {1}.""".format(dsetname, datasetName)
            spss.Submit(submitstring)

        spss.StartDataStep()
        datasetObj = spss.Dataset(name = datasetName)
        spss.SetActive(datasetObj)

# Label variables
        variableList =[]
        for t in range(spss.GetVariableCount()):
            variableList.append(spss.GetVariableName(t))
        for t in range(len(labelList)):
            if ("label{0}".format(str(t)) not in variableList):
                datasetObj.varlist.append("label{0}".format(str(t)), 50)
        spss.EndDataStep()

# Set types for numeric vars
        submitstring = """alter type b_Coefficient to beta_p (f8.3).
alter type SpecificEffect (f8.0)."""
        spss.Submit(submitstring)

# Get coefficients
        bCoef = getIndirect(self.indirect)
        zCoef = getIndirect(self.Zindirect)

# Determine values for dataset
        dataValues = []
        for t in range(len(bCoef)):
            rowList = bCoef[t]
            rowList.extend(zCoef[t][3:])
            rowList.extend(labelList)
            dataValues.append(rowList)

# Put values in dataset
        spss.StartDataStep()
        datasetObj = spss.Dataset(name = datasetName)
        for t in dataValues:
            datasetObj.cases.append(t)
        spss.EndDataStep()

# Return to original data set
        spss.StartDataStep()
        datasetObj = spss.Dataset(name = activeName)
        spss.SetActive(datasetObj)
        spss.EndDataStep()

def MplusPathAnalysis(inpfile, runModel = True, viewOutput = True,
suppressSPSS = False, latent = None, model = None, covar = None, 
covEndo = False, covExo = True, 
useobservations = None, indirect = None, identifiers = None, wald = None,
categorical = None, censored = None, count = None, nominal = None,
cluster = None, weight = None, auxiliary = None, 
datasetName = None, indDatasetName = None, datasetLabels = [], 
miThreshold = 10, waittime = 5):

    spss.Submit("display scratch.")

# Redirect output
    if (suppressSPSS == True):
        submitstring = """OMS /SELECT ALL EXCEPT = [WARNINGS] 
    /DESTINATION VIEWER = NO 
    /TAG = 'NoJunk'."""
        spss.Submit(submitstring)

# Find directory and filename
    for t in range(len(inpfile)):
        if (inpfile[-t] == "/"):
            break
    outdir = inpfile[:-t+1]
    fname, fext = os.path.splitext(inpfile[-(t-1):])

# Obtain list of variables in data set
    SPSSvariables = []
    SPSSvariablesCaps = []
    for varnum in range(spss.GetVariableCount()):
        SPSSvariables.append(spss.GetVariableName(varnum))
        SPSSvariablesCaps.append(spss.GetVariableName(varnum).upper())

# Restore output
    if (suppressSPSS == True):
        submitstring = """OMSEND TAG = 'NoJunk'."""
        spss.Submit(submitstring)

# Check for errors
    error = 0
    if (fext.upper() != ".INP"):
        print ("Error: Input file specification does not end with .inp")
        error = 1
    if (not os.path.exists(outdir)):
        print("Error: Output directory does not exist")
        error = 1
    if (latent != None):
        variableError = 0
        for equation in latent:
            if (equation[0].upper() in SPSSvariablesCaps):
                variableError = 1
                break
            if (variableError == 1):
                print "Error: Latent variable name overlaps with existing variable name"
                error = 1
    if (latent != None):
        variableError = 0
        for equation in latent:
            for var in equation[1:]:
                if (var.upper() not in SPSSvariablesCaps):
                    variableError = 1
                    print "Missing " + var
        if (variableError == 1):
            print("Error: Variable listed in latent variable definition not in current data set")
            error = 1
    if (model != None):
        variableError = 0
        for equation in model:
            for var in equation:
                if (var.upper() not in SPSSvariablesCaps):
                    variableError = 1
                    if (latent != None):
                        for latentvar in latent:
                            if (var.upper() == latentvar[0].upper()):
                                variableError = 0
                    if variableError == 1:
                        print "Missing " + var
                                
        if (variableError == 1):
            print("Error: Variable listed in model not in current data set")
            error = 1

    if (error == 0):
# Redirect output
        if (suppressSPSS == True):
            submitstring = """OMS /SELECT ALL EXCEPT = [WARNINGS] 
    /DESTINATION VIEWER = NO 
    /TAG = 'NoJunk'."""
            spss.Submit(submitstring)

# Export data
        dataname = outdir + fname + ".dat"
        MplusVariables = exportMplus(dataname)

# Define latent variables using Mplus variables
        if (latent == None):
            MplusLatent = None
        else:
            MplusLatent = []
            for t in latent:
                MplusLatent.append([i.upper() for i in t])
            for t in range(len(MplusLatent)):
                for i in range(len(MplusLatent[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if (MplusLatent[t][i] == s):
                            MplusLatent[t][i] = m

# Define model using Mplus variables
        if (model == None):
            MplusModel = None
        else:
            MplusModel = []
            for t in model:
                MplusModel.append([i.upper() for i in t])
            for t in range(len(MplusModel)):
                for i in range(len(MplusModel[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if (MplusModel[t][i] == s):
                            MplusModel[t][i] = m

# Convert variables in covariance list to Mplus
        if (covar == None):
            MplusCovar = None
        else:
            MplusCovar = []
            for t in covar:
                MplusCovar.append([i.upper() for i in t])
            for t in range(len(MplusCovar)):
                for i in range(2):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if (MplusCovar[t][i] == s):
                            MplusCovar[t][i] = m

# Define indirect effects using Mplus variables
        if (indirect == None):
            MplusIndirect = None
        else:
            MplusIndirect = []
            for t in indirect:
                MplusIndirect.append([i.upper() for i in t])
            for t in range(len(MplusIndirect)):
                for i in range(len(MplusIndirect[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if (MplusIndirect[t][i] == s):
                            MplusIndirect[t][i] = m

# Convert identifiers to Mplus
        if (identifiers == None):
            MplusIdentifiers = None
        else:
            MplusIdentifiers = []
            idEquations = []
            for t in identifiers:
                j = []
                for i in t[0]:
                    j.append(i.upper())
                idEquations.append(j)
            for t in range(len(idEquations)):
                for i in range(len(idEquations[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if (idEquations[t][i] == s):
                            idEquations[t][i] = m
                MplusIdentifiers.append([idEquations[t], identifiers[t][1]])

# Convert useobservations to Mplus
        if (useobservations == None):
            MplusUseobservations = None
        else:
            MplusUseobservations = useobservations
            for s, m in zip(SPSSvariablesCaps, MplusVariables):
                z = re.compile(s, re.IGNORECASE)
                MplusUseobservations = z.sub(m, MplusUseobservations)

# Convert cluster variable to Mplus
        if (cluster == None):
            MplusCluster = None
        else:
            for s, m in zip(SPSSvariablesCaps, MplusVariables):
                if (cluster.upper() == s):
                    MplusCluster = m

# Convert variable list arguments to Mplus
        lvarList = [auxiliary, categorical, censored, count, nominal]
        MplusAuxiliary = []
        MplusCategorical = []
        MplusCensored = []
        MplusCount = []
        MplusNominal = []
        lvarMplusList = [MplusAuxiliary, MplusCategorical, MplusCensored,
MplusCount, MplusNominal]
        for t in range(len(lvarList)):
            if (lvarList[t] == None):
                lvarMplusList[t] = None
            else:
                for i in lvarList[t]:
                    lvarMplusList[t].append(i.upper())
                for i in range(len(lvarMplusList[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if (lvarMplusList[t][i] == s):
                            lvarMplusList[t][i] = m

# Convert weight variable to Mplus
        if (weight == None):
            MplusWeight = None
        else:
            for s, m in zip(SPSSvariablesCaps, MplusVariables):
                if (weight.upper() == s):
                    MplusWeight = m

# Create input program
        pathProgram = MplusPAprogram()
        pathProgram.setTitle("Created by MplusPathAnalysis")
        pathProgram.setData(dataname)
        pathProgram.setVariable(MplusVariables, MplusLatent, MplusModel, 
MplusUseobservations,
MplusCategorical, MplusCensored, MplusCount, MplusNominal,
MplusCluster, MplusWeight, MplusAuxiliary)
        pathProgram.setAnalysis(MplusCluster)
        pathProgram.setModel(MplusLatent, MplusModel, MplusCovar, 
covEndo, covExo, MplusIndirect, MplusIdentifiers, wald)
        pathProgram.setOutput("stdyx;\nmodindices({0});".format(miThreshold))
        pathProgram.write(outdir + fname + ".inp")

# Add latent variables to SPSSvariables lists
        if (latent != None):
            for equation in latent:
                SPSSvariables.append(equation[0])
                SPSSvariablesCaps.append(equation[0].upper())

# Add latent variables to MplusVariable list
        if (latent != None):
    	       for equation in latent:
                MplusVariables.append(equation[0].upper())

        if (runModel == True):
    # Run input program
            batchfile(outdir, fname)
            time.sleep(waittime)

# Restore output
        if (suppressSPSS == True):
            submitstring = """OMSEND TAG = 'NoJunk'."""
            spss.Submit(submitstring)

        if (viewOutput == True):
    # Parse output
            pathOutput = MplusPAoutput(outdir + fname + ".out", 
    MplusVariables, SPSSvariables)
            pathOutput.toSPSSoutput()

# Redirect output
            if (suppressSPSS == True):
                submitstring = """OMS /SELECT ALL EXCEPT = [WARNINGS] 
    /DESTINATION VIEWER = NO 
    /TAG = 'NoJunk'."""
                spss.Submit(submitstring)

    # Create coefficient dataset
            if (datasetName != None):
                pathOutput.toSPSSdata(datasetName, datasetLabels)

    # Create indirect effects dataset
            if (indDatasetName != None):
                if (pathOutput.indirect != None):
                    pathOutput.indirectToSPSSdata(indDatasetName, datasetLabels)

# Restore output
            if (suppressSPSS == True):
                submitstring = """OMSEND TAG = 'NoJunk'."""
                spss.Submit(submitstring)

# Replace titles
    titleToPane()
end program python.
set printback = on.
