* Use Mplus to run a Path Analysis from within SPSS
* By Jamie DeCoster

* This program allows users to identify a path model that
* they want to test on an SPSS data set. The program then
* converts the active data set to Mplus format, writes a program
* that will perform the path analysis in Mplus, then loads the important
* parts of the Mplus output into the SPSS output window.

**** Usage: MplusPathAnalysis(impfile, model, corrEndo, corrExo, 
covar, categorical, censored, count, nominal, cluster, weight, 
datasetName, datasetLabels, waittime)
**** "impfile" is a string identifying the directory and filename of
* Mplus input file to be created by the program. This filename must end with
* .inp . The data file will automatically be saved to the same directory. This
* argument is required.
**** "model" is a list of lists identifying the equations in your
* path model.  First, you create a set of lists that each have the outcome as
* the first element and then have the predictors as the following elements.
* Then you combine these individual equation lists 
* into a larger list identifying the entire path model. This argument 
* is required.
**** "covar" is a list of lists identifying covariances with 
* endogenous variables. All exogenous variables are automatically 
* allowed to covary with each other, but covariances of exogenous 
* variables with endogenous variables as well as covariances 
* among endogenous variables must be specified. First, you create
* a set of lists that identify pairs of variables that are allowed to covary.
* Then you combine these lists of pairs into a single, overall list. 
* This argument defaults to None, which would indicate that there are 
* no extra covariances allowed with endogenous variables.
**** "corrEndo" is a boolean variable that indicates whether you want
* to automatically correlated all of the endogenous variables in the model.
* Endogenous variables are those that are used as an outcome at least
* once in your model. If this variable is set to True, then the program will
* automatically include covariances among all of the endogenous 
* variables. If this variable is set to False, then it will not, although
* you can still specify individual covariances between endogenous
* variables using the "covar" argument described above. By default, 
* the value of corrEndo is False.
**** "corrExo" is a boolean variable that indicates whether you want
* to automatically correlated all of the exogenous variables in the model.
* Exogenous variables are those that are only used as predictors and
* never used as outcomes in your model. If this variable is set to True, 
* then the program will automatically include covariances among all 
* of the exogenous variables. If this variable is set to False, then it 
* will not, although you can still specify individual covariances between 
* exogenous variables using the "covar" argument described above.
* By default, the value for corrExo is True.
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
**** "datasetLabel" is an optional argument that identifies a list of
* labels that would be applied to the dataset containing coefficients.
* This can be useful if you are appending the results from multiple analyses 
* to the same dataset.
**** "waittime" is an optional argument that specifies how many seconds
* the program should wait after running the Mplus program before it 
* tries to read the output file. This defaults to 5. You should be sure that
* you leave enough time for Mplus to finish the analyses before trying
* to import them into SPSS

* Example: 
MplusPathAnalysis(inpfile = "C:/users/jamie/workspace/spssmplus/path.inp",
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
waittime = 10)
* This would test a model where a Treatment (Tx) is expected to affect 
* attitudes towrd children (att_ch), which in turn is related to be related
* to three measures assessing classroom interactions (CO, ES, and IS).
* Years of experience teaching (yrs_tch), teacher age (age), and teacher
* gender (gender) are included as covariates in all of the models. 
* Treatment is included as a covariate in the models predicting classroomo
* interactions so that the model can be used to accurately estimate the
* mediated effect. CO is allowed to covary with both ES and IS.
* The endogenous variables (which include CO, ES, and IS) are not
* automatically allowed to covary, although two specific covariances
* are allowed (CO with ES and CO with IS) as mentioned above. All of the 
* exogenous variables (which include Tx, att_ch, yrs_tch, age, and gender) 
* are allowed to freely covary. Yrs_tch is treated as a categorical variable, 
* whereas Tx and gender are treated as nominal variables. 
* The model also controls for school as a random 
* clustering factor. The analysis weights the observations using the 
* values in the variable "demoweight." The variables "grade" and "FRLper"
* will be used to help estimate missing values but will not be included in
* the analytic model. The standardized regression coefficients will be
* recorded in the SPSS dataset "CLASSbeta". This dataset would have 
* two variables containing labels. All of the results from this run of the 
* program would have the values of "CLASS" and "Mediation" for these
* two variables. The program will wait 10 seconds after starting to 
*run the Mplus program before it tries  to read the results back into SPSS.

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
* 2014-01-06 Added corrEndo and corrExo parameters
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
* 2014-05-27 Corrected error when corrExo = False

set printback = off.
begin program python.
import spss, spssaux, os, time, re
from subprocess import Popen, PIPE

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
				newname = "var" + str(t+1)
		if (oldname != newname):
			submitstring = "rename variables (%s = %s)." %(oldname, newname)
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

    def setVariable(self, fullList, model, categorical, censored, count,
nominal, cluster, weight, auxiliary):
        self.variable += "Names are\n"
        for var in fullList:
            self.variable += var + "\n"
        self.variable += ";\n\n"

# Determine usevariables
        useList = []
        for equation in model:
            for var in equation:
                if (var not in useList):
                    useList.append(var)
        self.variable += "Usevariables are\n"
        for var in useList:
            self.variable += var + "\n"

# Other variable additions
        if (cluster != None):
            self.variable += ";\n\ncluster is " + cluster
        if (weight != None):
            self.variable += ";\n\nweight is " + weight
        if (auxiliary != None):
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

    def setModel(self, MplusModel, MplusCovar, cEndo, cExo):
# Regression equations
        for equation in MplusModel:
            curline = equation[0] + " on"
            for var in equation[1:]:
                    if (len(curline) + len(var) < 75):
                        curline += " " + var
                    else:
                        self.model += curline + "\n"
                        curline = var
            self.model += curline + ";\n"

# Getting lists of endogenous and exogenous variables
        endo = []
        for equation in MplusModel:
            endo.append(equation[0])
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
        if (cExo == True):
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
        if (cEndo == True):
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
    for t in range(len(processString), 0, -1):
            if (processString[t-1] != "\n"):
                return (processString[0:t])

def getCoefficients(outputBlock):
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

class MplusPAoutput:
    def __init__(self, filename, Mplus, SPSS):
        infile = open(filename, "rb")
        fileText = infile.read()
        infile.close()
        outputList = fileText.split("\n")

        self.summary = None
        self.warnings = None
        self.fit = None
        self.coefficients = None
        self.covariances = None
        self.descriptives = None
        self.Zcoefficients = None
        self.Zcovariances = None
        self.Zdescriptives = None
        self.r2 = None
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

# Unstandardized coefficients
        start = end
        for t in range(start, len(outputList)):
            if (re.search(r"\bWITH\b", outputList[t]) or
re.search(r"\bMeans\b", outputList[t])):
                end = t
                break
        self.coefficients = "\n".join(outputList[start:end])
        self.coefficients = removeBlanks(self.coefficients)

# Unstandardized covariances
        start = end
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

# Standardized coefficients
        if ("MODEL ESTIMATION TERMINATED NORMALLY" in self.warnings):
            for t in range(end, len(outputList)):
                if ("STDYX" in outputList[t]):
                    start = t
                    break
            for t in range(start, len(outputList)):
                if (re.search(r"\bWITH\b", outputList[t]) or
re.search(r"\bMeans\b", outputList[t])):
                    end = t
                    break
            self.Zcoefficients = "\n".join(outputList[start:end])
            self.Zcoefficients = removeBlanks(self.Zcoefficients)

# Standardized covariances
            start = end
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

# Modification indices
            for t in range(end, len(outputList)):
                if ("MODEL MODIFICATION INDICES" in outputList[t]):
                    start = t
                    break
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

# Coefficients sections
# Variables
        for var1, var2 in zip(Mplus, SPSS):
            var1 += " "*(8-len(var1))
            var1 = " " + var1 + " "
            if (len(var2) < 23):
                var2 += " "*(23-len(var2))
            else:
                var2 = var2[:23]
            var2 = " " + var2 + " "

            if (self.coefficients != None):
                self.coefficients = self.coefficients.replace(var1.upper(), var2)
            if (self.covariances != None):
                self.covariances = self.covariances.replace(var1.upper(), var2)
            if (self.descriptives != None):
                self.descriptives = self.descriptives.replace(var1.upper(), var2)
            if (self.Zcoefficients != None):
                self.Zcoefficients = self.Zcoefficients.replace(var1.upper(), var2)
            if (self.Zcovariances != None):
                self.Zcovariances = self.Zcovariances.replace(var1.upper(), var2)
            if (self.Zdescriptives != None):
                self.Zdescriptives = self.Zdescriptives.replace(var1.upper(), var2)

# Headers
        oldheader = "Two-Tailed"
        newheader = "               Two-Tailed"
        if (self.coefficients != None):
            self.coefficients = self.coefficients.replace(oldheader, newheader)
        if (self.Zcoefficients != None):
            self.Zcoefficients = self.Zcoefficients.replace(oldheader, newheader)
        oldheader = "Estimate       S.E.  Est./S.E.    P-Value"
        newheader = "               Estimate       S.E.  Est./S.E.    P-Value"""
        if (self.coefficients != None):
            self.coefficients = self.coefficients.replace(oldheader, newheader)
        if (self.Zcoefficients != None):
            self.Zcoefficients = self.Zcoefficients.replace(oldheader, newheader)

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
        spss.Submit("title 'UNSTANDARDIZED COEFFICIENTS'.")
        print self.coefficients
        spss.Submit("title 'UNSTANDARDIZED COVARIANCES'.")
        print self.covariances
        spss.Submit("title 'UNSTANDARDIZED DESCRIPTIVES'.")
        print self.descriptives

        if ("MODEL ESTIMATION TERMINATED NORMALLY" in self.warnings):
            spss.Submit("title 'STANDARDIZED COEFFICIENTS'.")
            print self.Zcoefficients
            spss.Submit("title 'STANDARDIZED COVARIANCES'.")
            print self.Zcovariances
            spss.Submit("title 'STANDARDIZED DESCRIPTIVES'.")
            print self.Zdescriptives
            spss.Submit("title 'R-SQUARES'.")
            print self.r2
            spss.Submit("title 'MODIFICATION INDICES'.")
            print self.mi     

# Save to dataset
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

def MplusPathAnalysis(inpfile, model, covar = None, 
corrEndo = False, corrExo = True,
categorical = None, censored = None, count = None, nominal = None,
cluster = None, weight = None, auxiliary = None, 
datasetName = None, datasetLabels = [], waittime = 5):

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

# Check for errors
    error = 0
    if (fext.upper() != ".INP"):
        print ("Error: Input file specification does not end with .inp")
        error = 1
    if (not os.path.exists(outdir)):
        print("Error: Output directory does not exist")
        error = 1
    variableError = 0
    for equation in model:
        for var in equation:
            if (var.upper() not in SPSSvariablesCaps):
                variableError = 1
    if (variableError == 1):
        print("Error: Variable listed in model not in current data set")
        error = 1
    outcomes = []
    for equation in model:
        if (equation[0].upper() in outcomes):
            print("Error: Same variable used as outcome in multiple equations")
            error = 1
        else:
            outcomes.append(equation[0].upper())

    if (error == 0):
# Export data
        dataname = outdir + fname + ".dat"
        MplusVariables = exportMplus(dataname)

# Define model using Mplus variables
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
        pathProgram.setVariable(MplusVariables, MplusModel, 
MplusCategorical, MplusCensored, MplusCount, MplusNominal,
MplusCluster, MplusWeight, MplusAuxiliary)
        pathProgram.setAnalysis(MplusCluster)
        pathProgram.setModel(MplusModel, MplusCovar, corrEndo, corrExo)
        pathProgram.setOutput("stdyx;\nmodindices;")
        pathProgram.write(outdir + fname + ".inp")

# Run input program
        batchfile(outdir, fname)
        time.sleep(waittime)

# Parse output
        pathOutput = MplusPAoutput(outdir + fname + ".out", 
MplusVariables, SPSSvariables)
        pathOutput.toSPSSoutput()

# Create coefficient dataset
        if (datasetName != None):
            pathOutput.toSPSSdata(datasetName, datasetLabels)

end program python.
set printback = on.
COMMENT BOOKMARK;LINE_NUM=535;ID=1.
