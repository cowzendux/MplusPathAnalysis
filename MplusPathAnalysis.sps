* Encoding: UTF-8.
* Use Mplus to run a Path Analysis from within SPSS
* By Jamie DeCoster

* This program allows users to identify a path model that
* they want to test on an SPSS data set. The program then
* converts the active data set to Mplus format, writes a program
* that will perform the path analysis in Mplus, then loads the important
* parts of the Mplus output into the SPSS output window.

**** Usage: MplusPathAnalysis(modellabel, inpfile, inpShow, runModel, viewOutput, suppressSPSS,
latent, latentFixed, latentIdentifiers, model, xwith, means, covar, covEndo, covExo, estimator, starts,
useobservations, subpopulation, indirect, identifiers, meanIdentifiers, covIdentifiers,
wald, constraint, montecarlo, bootstrap, repse,
categorical, censored, count, nominal, idvariable, cluster, grouping, weight, 
datasetName, datasetIntercepts, indDatasetName, newDatasetName,
datasetLabels, miThreshold,
savedata, saveFscores, processors, waittime)
**** "modellabel" is a string that indicates what label should be added to the output at the
* top of your model. If this is not specified, the label defaults to "MplusPathAnalysis"
**** "inpfile" is a string identifying the directory and filename of
* Mplus input file to be created by the program. This filename must end with
* .inp . The data file will automatically be saved to the same directory. This
* argument defaults to "Mplus/model.inp", assuming there is an "Mplus" subdirectory
* off of the analysis directory.
**** "inpShow" is a boolean argument indicating whether you want a copy of the Mplus .inp
* file to be included in the SPSS output log. By default the .inp is not included.
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
**** "latent" is a list of lists identifying the relations between observed and latent 
* variables. This argument is optional, and can be omitted if your model does
* not have any latent variables. When creating this argument, you first create a
* list of strings for each latent variable where the first element is the name of
* the latent variable and the remaining elements are the names of the observed
* variables that load on that latent variable. You then combine these individual
* latent variable lists into a larger list identifying the full measurement model.
**** "latentFixed" is a list of lists identifying any values of latent variable links 
* that are fixed to constant values. Each entry in this list pairs a within latent 
* coefficient with its constant value. The coefficients part must 
* specifically match an element of
* the latent statement. To do this, you may need to separate the 
* observed values for a single latent variable into different lists. This defaults to None, 
* which does not assign any fixed latent coefficients. 
**** "latentIdentifiers" is an optional argument provides a list of lists pairing 
,* latent coefficients with identifiers that can be used as part of a Wald Z test or
* a Model Constraint calculation, or a model with parameters forced to be equal.
* The coefficients part must specifically match a list in the "latent" statement.
* To do this, you may need to separate the predictors for a single latent variable 
* into different lists. This defaults to None, which does not assign any identifiers. 
**** "model" is a list of lists identifying the equations in your
* path model.  First, you create a set of lists that each have the outcome as
* the first element and then have the predictors as the following elements.
* Then you combine these individual equation lists 
* into a larger list identifying the entire path model. You can omit this argument
* if you are performing a CFA and don't have any structural equations.
**** "xwith" is a list of lists identifying a set of interactions between latent 
* variables. The first element of each list is the name of the interaction that
* you want to create. The next two elements define the variables in the interaction.
**** "means" is a list of variables indicating which means you want 
* estimated in the model. 
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
**** "estimator" is a string specifying the estimation method to be used. 
* Valid values are ML, MLM, MLMV, MLR, MLF, MUML, WLS, WLSM,
* WLSMV, ULS, ULSMV, GLS, and BAYES. If this argument is omitted,
* the Mplus default will be used, which depends on the data and model
* types you are using (most commonly MLR).
**** "starts" is number specifying the number of random starts to be used.
* Omitting this value has Mplus use the default number of random starts,
* which depends on the exact analysis you are doing.
**** "useobservations" is a string specifying a selection
* criterion that must be met for observations to be included in the 
* analysis. This is an optional argument that defaults to None, indicating
* that all observations are to be included in the analysis. This should not be
* used if you have a cluster variable - in that case, use "subpopulation".
**** "subpopulation" is a string specifying a selection
* criterion that must be met for observations to be included in the 
* analysis. This is an optional argument that defaults to None, indicating
* that all observations are to be included in the analysis. This should only be
* used if you have a cluster variable. If you do not, use "useobservations".
**** "indirect" is an optional argument that identifies a set of indirect effects
* that should be tested within the specified model. The argument is provided
* as a list of lists. Each individual list identifies a single indirect effect that
* should be tested. Within each list, the outcome is listed first and the 
* predictor is listed last. If you want to test specific indirect paths, the variables
* in the path are listed following the outcome but before the predictor. 
* This argument defaults to None, which would indicate that 
* you do not want to test indirect effects.
**** "identifiers" is an optional argument provides a list of lists pairing 
,* coefficients with identifiers that will be used as part of a Wald Z test or
* a Model Constraint calculation, or a model with parameters forced to be equal.
* The coefficients part must specifically match a list in the "model" statement.
* To do this, you may need to separate the predictors for a single outcome 
* into different lists. This defaults to None, which does not assign any identifiers. 
**** "meanIdentifiers" is an optional argument that provides a list of lists
* pairing means with identifiers that will be used as part of a Wald Z test,
* a Model Constraint calculation, or a model with parameters forced to be equal.
* This defaults to None, which does not assign any identifiers.
**** "covIdentifiers" is an optional argument that provides a list of lists
* pairing covariances with identifiers that will be used as part of a Wald Z test,
* a Model Constraint calculation, or a model with parameters forced to be equal.
* This defaults to None, which does not assign any identifiers. Warning! If you
* set either covExo or covEndo to true, this may redefine the covariances 
* that you explicitly define using the covar statment, removing the identifier
* you define here from memory. Avoid using covExo or covEndo if you want
* to constrain the values of your covariances.
**** "wald" is an optional argument that identifies a list of constraints that
* will be tested using a Wald Z test. The constraints will be definted using the
* identifiers specified in the "identifiers" argument. This can be used 
* to create an omnibus test that several coefficients are equal to zero, or it 
* can be used to test the equivalence of different coefficients. This argument 
* defaults to None, which would indicate that you do not want to perform 
* a Wald Z test.
**** "constraint" is an optional argument that identifies a string
* to be included in the Model Constraint section, allowing you to estimate
* linear combinations of means and coefficients from your model. 
**** "montecarlo" is an optional argument that allows you to specify Monte
* Carlo integration. If you omit this argument, Mplus will not use Monte Carlo
* integration. If you want to use Monte Carlo integration, you set this argument
* to a number that is the number of integration points you want to use. The
* default used by Mplus is 2000.
**** "bootstrap" is an optional argument that allows you to request bootstrap
* confidence intervals. If you want to obtain bootstrap CIs, you set this
* argument equal to the number of bootstrap samples you want to use. This
* number should be at least 1000, but can go notably higher. Researchers
* typically use 5000, but it's not unheard of to use 20000 or more.
**** "repse" is an optional argument that allows you to identify the resampling
* method used to create replicate weights. Valid options are bootstrap, 
* jackknife, jackknife1, jackknife2, brr, and fay(#)
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
**** "idvariable" is an optional argument that identifies an identifier variable
* for your data set. This is needed if you are saving latent scores and want
* to merge them into another data set.
**** "cluster" is an optional argument that identifies a cluster variable.
* This defaults to None, which would indicate that there is no clustering.
* Clustering is handled using Mplus type = complex.
**** "grouping" is an optional argument that defines the groups for a
* multigroup analysis. This defaults to None, which would indicate that
* you don't want to perform a multigroup analysis. If you want to perform
* a multigroup analysis, set this to a string of the form 
* "variable (value1 = label1 value2 = label2)". You can 
* have more than two value/label pairs if you want.
**** "weight" is an optional argument that identifies a sample weight.
* This defaults to None, which would indicate that there all observations
* are given equal weight. Note that not all estimators can make use of
* weights. MLR is typically a good option.
**** "auxiliary" is an optional argument that identifies a list of variables
* that are used to assist with estimating missing values but which are
* not to be included in the model. This defaults to None, which would
* indicate that there are no auxiliary variables in the analysis.
**** "datasetName" is an optional argument that identifies the name of
* an SPSS dataset that should be used to record the coefficients.
**** "datasetIntercepts" is an optional argument indicating whether you
* want intercepts included in the saved dataset. This defaults to True.
**** "indDatasetName" is an optional argument that identifies the name of
* an SPSS dataset that should be used to record the tests of the indirect
* effects. This will do nothing if no indirect tests are defined.
**** "newDatasetName" is an optional argument that identifiers the name of
* an SPSS dataset that should be used to record the tests of new/additional
* parameters created using the "model contrast" command.
**** "datasetLabels" is an optional argument that identifies a list of
* labels that would be applied to the datasets containing coefficients 
* or tests of the indirect effects. This can be useful if you are appending 
* the results from multiple analyses to the same dataset.
**** "miThreshold" is an optional argument that identifies the
* minimum chi-square change required for a modificiation index
* to be reported. Omitting this argument uses a default of 10.
**** "savedata" is an optional argument that allows you to save the data file 
* used in analysis to a file. The value of
* this argument should be set to the name of the data file that should be created.
* The saved file will be placed in the same directory as the .inp file. This defaults to
* None, which does not save the data file.
**** "saveFscores" is an optional boolean argument that allows you to indicate whether 
* latent scores should be included in the savedata file. This defaults to False. The
* value of this argument does nothing if savedata = None.
**** "processors" is an optional argument that specifies how many logical processors 
* Mplus should use when running the analysis. You should not specify more 
* processors than are available in your machine. If this argument is omitted, Mplus will
* use 1 processor. 
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
means = ["CO"],
["ES", "Tx", "att_ch", "yrs_tch", "age", "gender", "CHLATENT"],
["ES", "Educ"],
["IS", "Tx", "att_ch", "yrs_tch", "age", "gender", "CHLATENT"] 
["IS", "Educ"] ],
covar = [ ["CO","ES"], ["CO", "IS"] ],
covEndo = False,
covExo = True,
subpopulation = "p2cond==1",
indirect = [ ["CO", "att_ch", "Tx"],
["ES", "att_ch", "Tx"],
["IS", "att_ch", "Tx"] ],
identifiers = [ [ ["CO", "Educ"], "b1"],
[ ["ES", "Educ"], "b2"],
[ ["IS", "Educ"], "b3"] ],
meanIdentifiers = [ ["CO", "COint"] ],
wald = [ "b1 = 0", "b2 = 0", "b3 = 0" ],
constraint = """new loCO medCO hiCO;
loCO = COint + b1*12;
medCO = COint + b1*14;
hiCO = COint + b1*16;""",
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
* mediated effect. The mean of CO is estimated. CO is allowed to covary with both ES and IS.
* The endogenous variables (which include CO, ES, and IS) are not
* automatically allowed to covary, although two specific covariances
* are allowed (CO with ES and CO with IS) as mentioned above. All of the 
* exogenous variables (which include Tx, att_ch, yrs_tch, age, and gender) 
* are allowed to freely covary. The analysis will only include observations 
* where the value of pcond is 1. The program will test the indirect effects 
* of Tx on each of the three outcomes (CO, ES, IS) through att_ch.
* The model will use a Wald Z test to perform an omnibus test that the 
* Educ does not have any influence on any of the three outcomes (CO, ES, IS).
* A estimates are being made of the value of CO when eduction is low
* (12 years), medium (14 years), or high (16 years).
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

set printback = off.
begin program python3.
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
        if outputItem.GetDescription() == "Page Title":
            outputItem.ExportToDocument(filename, textFormat)
            with open(filename, 'r', encoding='utf-8') as f:
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
        print("Error filling TITLE in Output Viewer [{}]".format(sys.exc_info()[1]))
    finally:
        SpssClient.StopClient()

def MplusSplit(splitstring, linelength):
    returnstring = ""
    curline = splitstring
    while len(curline) > linelength:
        splitloc = linelength
        while curline[splitloc] == " " or curline[splitloc-1] == " ":
            splitloc -= 1
        returnstring += curline[:splitloc] + "\n"
        curline = curline[splitloc:]
    returnstring += curline
    return returnstring

def SPSSspaceSplit(splitstring, linelength):
    stringwords = splitstring.split()
    returnstring = "'"
    curline = ""
    for word in stringwords:
        if len(word) > linelength:
            break
        if len(word) + len(curline) < linelength - 1:
            curline += word + " "
        else:
            returnstring += curline + "' +\n'"
            curline = word + " "
    returnstring += curline[:-1] + "'"
    return returnstring

def numericMissing(definition):
    for varnum in range(spss.GetVariableCount()):
        if spss.GetVariableType(varnum) == 0:
            # for numeric variables
            submitstring = """
missing values {} ({}).""".format(spss.GetVariableName(varnum), definition)
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
            if oldname[i] in nonalphanumeric:
                newname += "_"
            else:
                newname += oldname[i]
        newname = newname.lstrip("_")
        for i in range(t):
            compname = spss.GetVariableName(i)
            if newname.lower() == compname.lower():
                newname = "var{:05d}".format(t + 1)
        if oldname != newname:
            submitstring = "rename variables ({} = {}).".format(oldname, newname)
            spss.Submit(submitstring)

    #########
    # Rename variables with names > 8 characters
    #########
    for t in range(spss.GetVariableCount()):
        if len(spss.GetVariableName(t)) > 8:
            name = spss.GetVariableName(t)[:8]
            for i in range(spss.GetVariableCount()):
                compname = spss.GetVariableName(i)
                if name.lower() == compname.lower():
                    name = "var{:05d}".format(t + 1)
            submitstring = "rename variables ({} = {}).".format(spss.GetVariableName(t), name)
            spss.Submit(submitstring)

    # Obtain lists of variables in the dataset
    varlist = []
    numericlist = []
    stringlist = []
    for t in range(spss.GetVariableCount()):
        varlist.append(spss.GetVariableName(t))
        if spss.GetVariableType(t) == 0:
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
        submitstring += "\n {}={}_str".format(var, var)
    submitstring += "."
    spss.Submit(submitstring)

    # Recoding variables
    if len(stringlist) > 0:
        submitstring = "AUTORECODE VARIABLES="
        for var in stringlist:
            submitstring += "\n {}_str".format(var)
        submitstring += "\n /into"
        for var in stringlist:
            submitstring += "\n {}".format(var)
        submitstring += """
        /BLANK=MISSING
        /PRINT."""
        spss.Submit(submitstring)
    
    # Dropping string variables
    submitstring = "delete variables"
    for var in stringlist:
        submitstring += "\n {}_str".format(var)
    submitstring += "."
    spss.Submit(submitstring)

    # Set all missing values to be -999
    submitstring = "RECODE "
    for var in varlist:
        submitstring += " {}\n".format(var)
    submitstring += """ (MISSING=-999).
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
    alter type ddate7663804 (sdate11).
    ALTER TYPE ALL (SDATE = F11.0).
    alter type ddate7663804 (edate11).
    ALTER TYPE ALL (EDATE = F11.0).
    alter type ddate7663804 (jdate11).
    ALTER TYPE ALL (JDATE = F11.0).
    alter type ddate7663804 (datetime17).
    ALTER TYPE ALL (DATETIME = F11.0).
    alter type ddate7663804 (time11).
    ALTER TYPE ALL (TIME = F11.0).
    alter type ddate7663804 (qyr6).
    ALTER TYPE ALL (QYR = F11.0).
    alter type ddate7663804 (moyr6).
    ALTER TYPE ALL (MOYR = F11.0).
    alter type ddate7663804 (ymdhms16).
    ALTER TYPE ALL (YMDHMS = F11.0).
    alter type ddate7663804 (wkday3).
    ALTER TYPE ALL (WKDAY = F11.0).
    alter type ddate7663804 (month3).
    ALTER TYPE ALL (MONTH = F11.0).

    delete variables ddate7663804."""
    spss.Submit(submitstring)

    ######
    # Obtain list of transformed variables
    ######
    submitstring = """MATCH FILES /FILE=*
    /keep="""
    for var in varlist:
        submitstring += "\n {}".format(var)
    submitstring += """.
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
    {}
    /TYPE=TAB
    /MAP
    /REPLACE
    /CELLS=VALUES
    /keep""".format(splitfilepath)
    for var in varlist:
        submitstring += "\n {}".format(var)
    submitstring += "."
    spss.Submit(submitstring)

    ##############
    # Rename variables back to original values
    ##############
    submitstring = "rename variables"
    for s, m in zip(SPSSvarlist, MplusVarlist):
        submitstring += "\n({}={})".format(m, s)
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
        self.constraint = "MODEL CONSTRAINT:\n"
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

    def setVariablePA(self, fullList, latent, model, xwith, useobservations, subpopulation,
                      categorical, censored, count, nominal, idvariable, cluster, weight, auxiliary, grouping):
        self.variable += "Names are\n"
        for var in fullList:
            self.variable += var + "\n"
        self.variable += ";\n\n"

        # Determine usevariables
        useList = []
        latentName = []
        if latent is not None:
            for equation in latent:
                latentName.append(equation[0])
            for equation in latent:
                for var in equation[1:]:
                    if var not in useList and var not in latentName:
                        useList.append(var)
        if xwith is not None:
            for equation in xwith:
                latentName.append(equation[0])
                for var in equation[1:]:
                    if var not in useList and var not in latentName:
                        useList.append(var)
        if model is not None:
            for equation in model:
                for var in equation:
                    if var not in useList and var not in latentName:
                        useList.append(var)
        self.variable += "Usevariables are\n"
        for var in useList:
            self.variable += var + "\n"

        # Other variable additions
        if useobservations is not None:
            self.variable += ";\n\nuseobservations are " + useobservations
        if subpopulation is not None:
            self.variable += ";\n\nsubpopulation is " + subpopulation
        if idvariable is not None:
            self.variable += ";\n\nidvariable is " + idvariable
        if cluster is not None:
            self.variable += ";\n\ncluster is " + cluster
        if weight is not None:
            self.variable += ";\n\nweight is " + weight
        if auxiliary:
            self.variable += ";\n\nauxiliary = (m) "
            for var in auxiliary:
                self.variable += var + "\n"
        if grouping is not None:
            self.variable += ";\n\ngrouping is " + grouping

        vartypeList = [categorical, censored, count, nominal]
        varnameList = ["categorical", "censored", "count", "nominal"]
        for t in range(len(vartypeList)):
            if vartypeList[t]:
                self.variable += ";\n\n{0} = ".format(varnameList[t])
                for var in vartypeList[t]:
                    self.variable += var + "\n"
        self.variable += ";\n\nMISSING ARE ALL (-999);"

    def setAnalysis(self, xwith, cluster, weight, estimator, starts,
                    mc, boot, repse, processors):
        if cluster is not None:
            self.analysis += "type = complex"
            if xwith is not None:
                self.analysis += " random;"
            else:
                self.analysis += ";"
        else:
            if xwith is not None:
                self.analysis += "type = random;"
        if estimator is not None:
            self.analysis += "\nestimator = {0};".format(estimator)
        if starts is not None:
            self.analysis += "\nstarts = {0};".format(starts)
        if mc is not None:
            self.analysis += "\nintegration = montecarlo({0});".format(mc)
        if boot is not None:
            self.analysis += "\nbootstrap = {0};".format(boot)
        if repse is not None:
            self.analysis += "\nrepse = {0};".format(repse)
        if processors is not None:
            self.analysis += "\nprocessors = {0};".format(processors)

    def setModel(self, MplusLatent, MplusLatentFixed, MplusLatentIdentifiers, MplusModel, 
                 MplusXwith, MplusMeans, MplusCovar, cEndo, cExo, MplusIndirect, MplusIdentifiers,
                 MplusMeanIdentifiers, MplusCovIdentifiers, wald):
        # Latent variable definitions
        if MplusLatent is not None:
            for equation in MplusLatent:
                curline = equation[0] + " by"
                for var in equation[1:]:
                    if len(curline) + len(var) < 75:
                        curline += " " + var
                    else:
                        self.model += curline + "\n"
                        curline = var
                if MplusLatentFixed is not None:
                    for t in MplusLatentFixed:
                        if equation == t[0]:
                            curline += "@" + str(t[1])
                if MplusLatentIdentifiers is not None:
                    for id in MplusLatentIdentifiers:
                        if equation == id[0]:
                            curline += " (" + id[1] + ")"                            
                self.model += curline + ";\n"

        # Xwith statements
        if MplusXwith is not None:
            self.model += "\n"
            for t in MplusXwith:
                curline = "{0} | {1} XWITH {2};".format(t[0], t[1], t[2])
                self.model += curline + "\n"

        # Regression equations
        if MplusModel is not None:
            self.model += "\n"
            for equation in MplusModel:
                curline = equation[0] + " on"
                for var in equation[1:]:
                    if len(curline) + len(var) < 75:
                        curline += " " + var
                    else:
                        self.model += curline + "\n"
                        curline = var
                if MplusIdentifiers is not None:
                    for id in MplusIdentifiers:
                        if equation == id[0]:
                            curline += " (" + id[1] + ")"
                self.model += curline + ";\n"

        # Means
        if MplusMeans is not None:
            for m in MplusMeans:
                curline = "[" + m + "]"
                if MplusMeanIdentifiers is not None:
                    for id in MplusMeanIdentifiers:
                        if m == id[0]:
                            curline += " (" + id[1] + ")"
                self.model += curline + ";\n"

        # Getting lists of endogenous and exogenous variables
        endo = []
        for equation in MplusModel:
            endo.append(equation[0])
        endo = list(set(endo))
        exo = []
        xwithNames = []
        if MplusXwith is not None:
            for x in MplusXwith:
                xwithNames.append(x[0])
        for equation in MplusModel:
            for var in equation:
                if var not in endo and var not in exo and var not in xwithNames:
                    exo.append(var)

        # Add defined covariances
        if MplusCovar is not None:
            for c in MplusCovar:
                self.model += "\n" + c[0] + " with "
                self.model += c[1]
                if MplusCovIdentifiers is not None:
                    for id in MplusCovIdentifiers:
                        if c == id[0]:
                            self.model += " (" + id[1] + ")"
                self.model += ";"
            self.model += "\n"

        # Covariances for all exogenous variables
        if cExo and MplusModel is not None:
            # Estimate variances for exogenous variables so that they
            # will be included in FIML
            if exo:
                for var in exo:
                    self.model += "\n" + var + ";"
                self.model += "\n"
                for t in range(len(exo) - 1):
                    self.model += "\n"
                    curline = exo[t] + " with"
                    for var in exo[t + 1:]:
                        if len(curline) + len(var) < 75:
                            curline += " " + var
                        else:
                            self.model += curline + "\n"
                            curline = var
                    self.model += curline + ";"

        # Covariances for all endogenous variables
        if cEndo and MplusModel is not None:
            if endo:
                self.model += "\n"
                for t in range(len(endo) - 1):
                    self.model += "\n"
                    curline = endo[t] + " with"
                    for var in endo[t + 1:]:
                        if len(curline) + len(var) < 75:
                            curline += " " + var
                        else:
                            self.model += curline + "\n"
                            curline = var
                    self.model += curline + ";"

        # Indirect effect tests
        if MplusIndirect is not None:
            self.model += "\n\nMODEL INDIRECT:"
            for t in MplusIndirect:
                if len(t) == 2:
                    line = t[0] + " ind " + t[1] + ";"
                if len(t) > 2:
                    line = t[0] + " via"
                    for i in t[1:]:
                        line += " " + i
                    line += ";"
                self.model += "\n" + line

        # Wald test
        if MplusIdentifiers is not None and wald is not None:
            self.model += "\n\nMODEL TEST:"
            for line in wald:
                self.model += "\n" + line + ";"

    def setConstraint(self, constraintText):
        if constraintText is not None:
            self.constraint += "\n" + constraintText

    def setOutput(self, outputText, boot):
        self.output += outputText
        if boot is not None:
            self.output += "\ncinterval(bcbootstrap);"

    def setSavedata(self, savedata, saveFscores):
        if savedata is not None:
            self.savedata += "\nfile = {0};".format(savedata)
            if saveFscores:
                self.savedata += "\nsave = fscores;"

    def write(self, filename):
        # Write input file
        sectionList = [self.title, self.data, self.variable, self.define,
                       self.analysis, self.model, self.constraint, self.output, self.savedata,
                       self.plot, self.montecarlo]
        with open(filename, "w", encoding='utf-8') as outfile:
            for sec in sectionList:
                if sec[-2:] != ":\n":
                    outfile.write(sec)
                    outfile.write("\n")

    def inpOutput(self):
        # Ouput .inp file to SPSS output log
        sectionList = [self.title, self.data, self.variable, self.define,
               self.analysis, self.model, self.constraint, self.output, self.savedata, 
               self.plot, self.montecarlo]
        inpText = ""
        for sec in sectionList:
            if sec[-2:] != ":\n":
                inpText += sec + "\n"
        return(inpText)
        
def batchfile(directory, filestem):
    # Write batch file
    with open(os.path.join(directory, filestem + ".bat"), "w") as batchFile:
        batchFile.write("cd " + directory + "\n")
        batchFile.write("call mplus \"" + filestem + ".inp" + "\"\n")

    # Run batch file
    p = Popen(os.path.join(directory, filestem + ".bat"), cwd=directory)

def removeBlanks(processString):
    if processString is None:
        return None
    else:
        for t in range(len(processString), 0, -1):
            if processString[t-1] != "\n":
                return processString[0:t]

def getCoefficients(outputBlock):
    if outputBlock is None:
        return None
    else:
        outputBlock2 = outputBlock.replace("\r", "")
        outputBlock2 = outputBlock2.replace("*********", "-999")
        blockList = outputBlock2.split("\n")
        coefficients = []
        for t in range(len(blockList)):
            values1 = blockList[t].split(" ")
            values2 = [i for i in values1 if i]

            if len(values2) > 1:
                if values2[1] == "ON":
                    outcome = values2[0]
                if len(values2) > 2 and values2[0] != "Estimate":
                    line = [outcome]
                    line.extend(values2[0:1])
                    for j in values2[1:]:
                        if j != "*":
                            line.append(float(j))
                    coefficients.append(line)
        return coefficients

def getIntercepts(outputBlock):
    if outputBlock is None:
        return None
    else:
        outputBlock2 = outputBlock.replace("\r", "")
        blockList = outputBlock2.split("\n")
        start = -1
        end = len(blockList)
        for t in range(len(blockList)):
            values1 = blockList[t].split(" ")
            values2 = [i for i in values1 if i]

            if len(values2) > 0:
                if values2[0] == "Intercepts":
                    start = t + 1
                if values2[0] == "Variances":
                    end = t - 1
        if start == -1:
            intercepts = None
        else:
            intercepts = []
            for t in range(start, end):
                values1 = blockList[t].split(" ")
                values2 = [i for i in values1 if i]
                if len(values2) > 2:
                    line = [values2[0], "Intercept"]
                    for j in values2[1:]:
                        line.append(float(j))
                    intercepts.append(line)
        return intercepts

def getIndirect(outputBlock):
    outputBlock2 = outputBlock.replace("\r", "")
    blockList = outputBlock2.split("\n")
    coefficients = []
    effect = None
    for t in range(len(blockList)):
        values1 = blockList[t].split(" ")
        values2 = [i for i in values1 if i]

        if "Effects from" in blockList[t]:
            effect = " ".join(values2[2:])
        if "Total" in values2:
            if values2[1] == "indirect":
                line = [effect, "Total indirect", 0]
                for j in values2[2:]:
                    line.append(float(j))
                coefficients.append(line)
            else:
                line = [effect, "Total", 0]
                for j in values2[1:]:
                    if j != "*":
                        line.append(float(j))
                coefficients.append(line)

        if "Specific indirect" in blockList[t]:
            specific = 1
            path = ""
            while t < len(blockList) - 1:
                t += 1
                if "Effects from" in blockList[t] or "Specific indirect" in blockList[t]:
                    t -= 1
                    break
                values1 = blockList[t].split(" ")
                values2 = [i for i in values1 if i]
                if len(values2) == 1:
                    if values2[0] == "Direct":
                        specific = 0
                    path += values2[0] + " "
                if len(values2) > 1:
                    path += values2[0]
                    line = [effect, path, specific]
                    path = ""
                    for j in values2[1:]:
                        if j != "*":
                            line.append(float(j))
                    coefficients.append(line)
    return coefficients
    
def getNewParam(outputBlock):
    if outputBlock is None:
        return None
    else:
        outputBlock2 = outputBlock.replace("\r", "")
        outputBlock2 = outputBlock2.replace("*********", "-999")
        blockList = outputBlock2.split("\n")
        p = []
        for t in range(len(blockList)):
            values1 = blockList[t].split(" ")
            values2 = [i for i in values1 if i]

            if len(values2) > 2 and values2[0] != "Estimate":
                line = [values2[0]]
                for j in values2[1:]:
                    if j != "*":
                        line.append(float(j))
                p.append(line)
        return p

class MplusPAoutput:
    def __init__(self, modellabel, filename, inp, Mplus, SPSS, grouping, estimator, starts):
        self.label = modellabel
        with open(filename, "rb") as infile:
            fileText = infile.read().decode('utf-8')
        outputList = fileText.split("\n")

        if estimator == "BAYES":
            self.header = """                                               Posterior  One-Tailed         95% C.I.
                                   Estimate       S.D.      P-Value   Lower 2.5%  Upper 2.5%  Sig"""
        else:
            self.header = """                                                                   Two-Tailed 
                                   Estimate       S.E.  Est./S.E.    P-Value"""
        self.inp = None
        self.summary = None
        self.warnings = None
        self.fit = None
        self.measurement = None
        self.coefficients = None
        self.covariances = None
        self.descriptives = None
        self.newParam = None
        self.Zmeasurement = None
        self.Zcoefficients = None
        self.Zcovariances = None
        self.Zdescriptives = None
        self.ci = None
        self.Zci = None
        self.indirectci = None
        self.Zindirectci = None        
        self.groupLabels = None
        self.groupOutput = None
        self.groupZoutput = None
        self.r2 = None
        self.indirect = None
        self.Zindirect = None
        self.mi = None
        
        # Mplus .inp file
        self.inp = inp

        # Summary
        for t in range(len(outputList)):
            if "SUMMARY OF ANALYSIS" in outputList[t]:
                start = t
            if "Observed dependent variables" in outputList[t]:
                end = t - 1
        self.summary = "\n".join(outputList[start:end + 1])

        # Warnings
        for t in range(len(outputList)):
            if "Number of clusters" in outputList[t] or "Covariance Coverage" in outputList[t]:
                covcov = t
        blank = 0
        for t in range(covcov, len(outputList)):
            if len(outputList[t]) < 2:
                blank = 1
            if blank == 1 and len(outputList[t]) > 1:
                start = t
                break
        for t in range(start, len(outputList)):
            if "MODEL FIT INFORMATION" in outputList[t] or "MODEL RESULTS" in outputList[t]:
                end = t
                break
        self.warnings = "\n".join(outputList[start:end])
        self.warnings = removeBlanks(self.warnings)

        if "MODEL ESTIMATION TERMINATED NORMALLY" in self.warnings:

            # Fit statistics
            start = end
            for t in range(start, len(outputList)):
                if "MODEL RESULTS" in outputList[t]:
                    end = t
                    break
            self.fit = "\n".join(outputList[start:end])
            self.fit = removeBlanks(self.fit)
        
        if grouping is None:
            # Unstandardized measurement model
            start = end
            secexists = 0
            for t in range(start, len(outputList)):
                if re.search(r"\bBY\b", outputList[t]):
                    start = t
                    secexists = 1
                    break
            if secexists == 1:
                for t in range(start, len(outputList)):
                    if re.search(r"\bON\b", outputList[t]) or re.search(r"\bWITH\b", outputList[t]) or re.search(r"\bMeans\b", outputList[t]) or "STANDARDIZED" in outputList[t]:
                        end = t
                        break
                self.measurement = "\n".join(outputList[start:end])
                self.measurement = removeBlanks(self.measurement)

            # Unstandardized coefficients
            start = end
            secexists = 0
            for t in range(start, len(outputList)):
                if re.search(r"\bON\b", outputList[t]):
                    start = t
                    secexists = 1
                    break
            if secexists == 1:
                for t in range(start, len(outputList)):
                    if re.search(r"\bWITH\b", outputList[t]) or re.search(r"\bMeans\b", outputList[t]) or "QUALITY OF" in outputList[t] or "New/Additional Parameters" in outputList[t] or "Intercepts" in outputList[t]:
                        end = t
                        break
                self.coefficients = "\n".join(outputList[start:end])
                self.coefficients = removeBlanks(self.coefficients)

            # Unstandardized covariances
            start = end
            secexists = 0
            for t in range(start, len(outputList)):
                if re.search(r"\bWITH\b", outputList[t]):
                    start = t
                    secexists = 1
                    break
            if secexists == 1:
                for t in range(start, len(outputList)):
                    if re.search(r"\bMeans\b", outputList[t]) or "QUALITY OF" in outputList[t] or "New/Additional Parameters" in outputList[t]:
                        end = t
                        break
                self.covariances = "\n".join(outputList[start:end])
                self.covariances = removeBlanks(self.covariances)

            # Unstandardized Descriptives
            start = end
            for t in range(start, len(outputList)):
                if "STANDARDIZED MODEL RESULTS" in outputList[t] or "MODEL COMMAND" in outputList[t] or "QUALITY OF" in outputList[t] or "New/Additional Parameters" in outputList[t]:
                    end = t
                    break
            self.descriptives = "\n".join(outputList[start:end])
            self.descriptives = removeBlanks(self.descriptives)

            # New parameters
            start = end
            if "New/Additional Parameters" in outputList[start]:
                for t in range(start, len(outputList)):
                    if "STANDARDIZED MODEL RESULTS" in outputList[t] or "QUALITY OF" in outputList[t] or "MODEL COMMAND" in outputList[t]:
                        end = t
                        break
                self.newParam = "\n".join(outputList[start:end])
                self.newParam = removeBlanks(self.newParam)

            # Standardized measurement model
            if "MODEL ESTIMATION TERMINATED NORMALLY" in self.warnings or starts is not None:
                start = end
                secexists = 0
                for t in range(start, len(outputList)):
                    if re.search(r"\bBY\b", outputList[t]):
                        start = t
                        secexists = 1
                        break
                if secexists == 1:
                    for t in range(start, len(outputList)):
                        if re.search(r"\bON\b", outputList[t]) or re.search(r"\bWITH\b", outputList[t]) or re.search(r"\bMeans\b", outputList[t]) or "R-SQUARE" in outputList[t]:
                            end = t
                            break
                    self.Zmeasurement = "\n".join(outputList[start:end])
                    self.Zmeasurement = removeBlanks(self.Zmeasurement)

                # Standardized coefficients
                start = end
                secexists = 0
                for t in range(end, len(outputList)):
                    if re.search(r"\bON\b", outputList[t]):
                        start = t
                        secexists = 1
                        break
                if secexists == 1:
                    for t in range(start, len(outputList)):
                        if re.search(r"\bWITH\b", outputList[t]) or re.search(r"\bMeans\b", outputList[t]) or "R-SQUARE" in outputList[t] or "Intercepts" in outputList[t]:
                            end = t
                            break
                    self.Zcoefficients = "\n".join(outputList[start:end])
                    self.Zcoefficients = removeBlanks(self.Zcoefficients)

                # Standardized covariances
                start = end
                secexists = 0
                for t in range(start, len(outputList)):
                    if re.search(r"\bWITH\b", outputList[t]):
                        start = t
                        secexists = 1
                        break
                if secexists == 1:
                    for t in range(start, len(outputList)):
                        if re.search(r"\bMeans\b", outputList[t]):
                            end = t
                            break
                    self.Zcovariances = "\n".join(outputList[start:end])
                    self.Zcovariances = removeBlanks(self.Zcovariances)
        
                # Standardized descriptives
                start = end
                for t in range(start, len(outputList)):
                    if "R-SQUARE" in outputList[t]:
                        end = t
                        break
                self.Zdescriptives = "\n".join(outputList[start:end])
                self.Zdescriptives = removeBlanks(self.Zdescriptives)
                     
        else:
            # Identifying group labels
            self.groupLabels = []
            temp = grouping[grouping.find("(") + 1:grouping.find(")")].strip()
            while "=" in temp:
                sep = temp.find("=")
                temp = temp[sep + 1:].strip()
                if "=" in temp:
                    sep = temp.find(" ")
                    self.groupLabels.append(temp[:sep].strip())
                    temp = temp[sep + 1:]
                else:
                    self.groupLabels.append(temp)
                    temp = ""
        
            # MGA output
            # Storing an output for each group
            # Splitting by group but not by other things.   

            # Unstandardized model
            self.groupOutput = []
            # Advancing to first group
            start = end
            for t in range(start, len(outputList)):
                if "Group" in outputList[t]:
                    end = t
                    break
            for label in self.groupLabels:
                start = end
                for t in range(start + 1, len(outputList)):
                    if "Group" in outputList[t] or "STANDARDIZED MODEL RESULTS" in outputList[t] or "QUALITY OF NUMERICAL RESULTS" in outputList[t]:
                        end = t
                        break
                gO = "\n".join(outputList[start:end])
                self.groupOutput += [removeBlanks(gO)]
                    
            # Standardized model
            self.groupZoutput = []
            # Advancing to first group
            start = end
            for t in range(start, len(outputList)):
                if "Group" in outputList[t]:
                    end = t
                    break
            for label in self.groupLabels:
                start = end
                for t in range(start + 1, len(outputList)):
                    if "Group" in outputList[t] or "R-SQUARE" or "MODEL COMMAND" in outputList[t]:
                        end = t
                        break
                gO = "\n".join(outputList[start:end])
                self.groupZoutput += [removeBlanks(gO)]

        if "MODEL ESTIMATION TERMINATED NORMALLY" in self.warnings:
            # R squares
            start = end
            for t in range(start, len(outputList)):
                if ("QUALITY OF" in outputList[t] 
                    or "TOTAL, TOTAL INDIRECT" in outputList[t] 
                    or "CONFIDENCE INTERVALS" in outputList[t] 
                    or "MODIFICATION" in outputList[t] 
                    or "Beginning Time" in outputList[t]
                    or "TECHNICAL 1" in outputList[t]):
                    end = t
                    break
            self.r2 = "\n".join(outputList[start:end])
            self.r2 = removeBlanks(self.r2)

            # Indirect effects
            stest = 0
            for t in range(end, len(outputList)):
                if "INDIRECT" in outputList[t]:
                    start = t
                    stest = 1
                    break
            if stest == 1:
                for t in range(start, len(outputList)):
                    if "STANDARDIZED TOTAL" in outputList[t]:
                        end = t - 1
                        break        
                self.indirect = "\n".join(outputList[start:end])
                self.indirect = removeBlanks(self.indirect)
                start = end
                for t in range(start, len(outputList)):
                    if "Beginning Time" in outputList[t] or "TECHNICAL" in outputList[t] or "CONFIDENCE INTERVALS OF MODEL" in outputList[t] or "MODIFICATION" in outputList[t]:
                        end = t - 1
                        break
                self.Zindirect = "\n".join(outputList[start:end])
                self.Zindirect = removeBlanks(self.Zindirect)
            
            # Bootstrap CIs
            start = end
            secexists = 0
            for t in range(start, len(outputList)):
                if re.search(r"CONFIDENCE INTERVALS OF MODEL", outputList[t]):
                    start = t
                    secexists = 1
                    break
            if secexists == 1:
                for t in range(start, len(outputList)):
                    if "QUALITY OF NUMERICAL RESULTS" in outputList[t] or "CONFIDENCE INTERVALS OF STANDARDIZED" in outputList[t] or "CONFIDENCE INTERVALS OF TOTAL" in outputList[t]:
                        end = t
                        break
                self.ci = "\n".join(outputList[start:end])
                self.ci = removeBlanks(self.ci)

            # Standardized CIs
            start = end
            secexists = 0
            for t in range(start, len(outputList)):
                if re.search(r"CONFIDENCE INTERVALS OF STANDARDIZED", outputList[t]):
                    start = t
                    secexists = 1
                    break
            if secexists == 1:
                for t in range(start, len(outputList)):
                    if "QUALITY OF NUMERICAL RESULTS" in outputList[t] or "CONFIDENCE INTERVALS OF TOTAL" in outputList[t] or "Beginning Time" in outputList[t]:
                        end = t
                        break
                self.Zci = "\n".join(outputList[start:end])
                self.Zci = removeBlanks(self.Zci)
            
            # Bootstrap CIs for indirect effects
            start = end
            secexists = 0
            for t in range(start, len(outputList)):
                if re.search(r"CONFIDENCE INTERVALS OF TOTAL", outputList[t]):
                    start = t
                    secexists = 1
                    break
            if secexists == 1:
                start = end
                for t in range(start, len(outputList)):
                    if "QUALITY OF NUMERICAL RESULTS" in outputList[t] or "CONFIDENCE INTERVALS OF STANDARDIZED TOTAL" in outputList[t] or "Beginning Time" in outputList[t]:
                        end = t
                        break
                self.indirectci = "\n".join(outputList[start:end])
                self.indirectci = removeBlanks(self.indirectci)

            # Standardized CIs for indirect effects
            start = end
            secexists = 0
            for t in range(start, len(outputList)):
                if re.search(r"CONFIDENCE INTERVALS OF STANDARDIZED TOTAL", outputList[t]):
                    start = t
                    secexists = 1
                    break
            if secexists == 1:
                start = end
                for t in range(start, len(outputList)):
                    if "QUALITY OF NUMERICAL RESULTS" in outputList[t] or "Beginning Time" in outputList[t]:
                        end = t
                        break
                self.Zindirectci = "\n".join(outputList[start:end])
                self.Zindirectci = removeBlanks(self.Zindirectci)

            # Modification indices
            for t in range(end, len(outputList)):
                mitest = 0
                if "MODIFICATION" in outputList[t]:
                    start = t
                    mitest = 1
                    break
            if mitest == 1:
                for t in range(start, len(outputList)):
                    if "Beginning Time" in outputList[t] or "TECHNICAL" in outputList[t]:
                        end = t - 1
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
            var1 += " " * (8 - len(var1))
            var1 = " " + var1 + " "
            if len(var2) < 23:
                var2 += " " * (23 - len(var2))
            else:
                var2 = var2[:23]
            var2 = " " + var2 + " "
        
            if self.measurement is not None:
                self.measurement = self.measurement.replace(var1.upper(), var2)
            if self.coefficients is not None:
                self.coefficients = self.coefficients.replace(var1.upper(), var2)
            if self.covariances is not None:
                self.covariances = self.covariances.replace(var1.upper(), var2)
            if self.descriptives is not None:
                self.descriptives = self.descriptives.replace(var1.upper(), var2)
            if self.Zmeasurement is not None:
                self.Zmeasurement = self.Zmeasurement.replace(var1.upper(), var2)
            if self.Zcoefficients is not None:
                self.Zcoefficients = self.Zcoefficients.replace(var1.upper(), var2)
            if self.Zcovariances is not None:
                self.Zcovariances = self.Zcovariances.replace(var1.upper(), var2)
            if self.Zdescriptives is not None:
                self.Zdescriptives = self.Zdescriptives.replace(var1.upper(), var2)
        
            if self.groupOutput is not None:
                for t in range(len(self.groupOutput)):
                    self.groupOutput[t] = self.groupOutput[t].replace(var1.upper(), var2)
            if self.groupZoutput is not None:
                for t in range(len(self.groupZoutput)):
                    self.groupZoutput[t] = self.groupZoutput[t].replace(var1.upper(), var2)
                            
            if self.r2 is not None:
                self.r2 = self.r2.replace(var1.upper(), var2)
            if self.indirect is not None:
                self.indirect = self.indirect.replace(var1.upper(), var2)
                self.indirect = re.sub(r"\b" + var1.upper().strip() + r"\b", r"\b" + var2.strip() + r"\b", self.indirect)
            if self.Zindirect is not None:
                self.Zindirect = self.Zindirect.replace(var1.upper(), var2)
                self.Zindirect = re.sub(r"\b" + var1.upper().strip() + r"\b", r"\b" + var2.strip() + r"\b", self.Zindirect)
        
        # New parameters section
        if self.newParam is not None:
            newNP = ["New/Additional Parameters"]
            npLines = self.newParam.split("\n")
            for line in npLines[1:]:
                if len(line) > 1:
                    firstWord = line.split()[0]
                    line = line.replace(firstWord, firstWord + " " * 15)
                    newNP.append(line)
            self.newParam = "\n".join(newNP)
        
        # R2 section
        if self.r2 is not None:
            self.r2 = self.r2.replace("Variable        Estimate       S.E.  Est./S.E.    P-Value", 
                                      "Variable                       Estimate       S.E.  Est./S.E.    P-Value")
            self.r2 = self.r2.replace("Two-Tailed", "              Two-Tailed")
        
        # Indirect section
        if self.indirect is not None:
            self.indirect = self.indirect.replace("Estimate       S.E.  Est./S.E.    P-Value", 
                                                  "               Estimate       S.E.  Est./S.E.    P-Value")
            self.indirect = self.indirect.replace("Two-Tailed", "              Two-Tailed")
            self.indirect = self.indirect.replace("Total   ", 
                                                  "Total                  ")
            self.indirect = self.indirect.replace("Total indirect       ",
                                                  "Total indirect                      ")
            self.indirect = self.indirect.replace("Sum of indirect      ",
                                                  "Sum of indirect                    ")
        if self.Zindirect is not None:
            self.Zindirect = self.Zindirect.replace("Estimate       S.E.  Est./S.E.    P-Value", 
                                                    "               Estimate       S.E.  Est./S.E.    P-Value")
            self.Zindirect = self.Zindirect.replace("Two-Tailed", "              Two-Tailed")
            self.Zindirect = self.Zindirect.replace("Total   ", 
                                                    "Total                  ")
            self.Zindirect = self.Zindirect.replace("Total indirect       ",
                                                    "Total indirect                      ")
            self.Zindirect = self.Zindirect.replace("Sum of indirect      ",
                                                    "Sum of indirect                    ")
        
        # Confidence intervals
        if self.ci is not None:
            self.ci = self.ci.replace("Lower .5%", "   Lower .5%")
        if self.Zci is not None:
            self.Zci = self.Zci.replace("Lower .5%", "   Lower .5%")
        if self.indirectci is not None:
            self.indirectci = self.indirectci.replace("Lower .5%", "   Lower .5%")
        if self.Zindirectci is not None:
            self.Zindirectci = self.Zindirectci.replace("Lower .5%", "   Lower .5%")

        if self.ci is not None or self.Zci is not None or self.indirectci is not None or self.Zindirectci is not None:    
            for var1, var2 in zip(Mplus, SPSS):
                var1 += " " * (8 - len(var1))
                var1 = " " + var1 + " "
                if len(var2) < 12:
                    var2 += " " * (12 - len(var2))
                else:
                    var2 = var2[:12]
                var2 = " " + var2 + " "
        
                if self.ci is not None:
                    self.ci = self.ci.replace(var1.upper(), var2)
                if self.Zci is not None:
                    self.Zci = self.Zci.replace(var1.upper(), var2)            
                if self.indirectci is not None:
                    self.indirectci = self.indirectci.replace(var1.upper(), var2)
                if self.Zindirectci is not None:
                    self.Zindirectci = self.Zindirectci.replace(var1.upper(), var2)
        
        # MI section
        if self.mi is not None and not "THE STANDARD ERRORS OF THE MODEL PARAMETER ESTIMATES COULD NOT" in self.warnings:
            for var1, var2 in zip(Mplus, SPSS):
                if len(var2) > 23:
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
                if (" ON " in line or " BY " in line or " WITH " in line) and "/" not in line:
                    miWords = line.split()
                    newLine = miWords[0] + " " * (23 - len(miWords[0]))
                    newLine += " " + miWords[1] + " " * (5 - len(miWords[1]))
                    newLine += miWords[2] + " " * (23 - len(miWords[2]))
                    newLine += " " * (8 - len(miWords[3])) + miWords[3] + "  "
                    newLine += " " * (8 - len(miWords[4])) + miWords[4] + "  "
                    newLine += " " * (8 - len(miWords[6])) + miWords[6] + "  "
                    newMI.append(newLine)
                else:
                    newMI.append(line)
            self.mi = "\n".join(newMI)
        
    # Print function
    def toSPSSoutput(self):
        spss.Submit("title '" + self.label + "'.")
        if self.inp is not None:
            spss.Submit("title 'MPLUS SYNTAX'.")
            print(self.inp)
        spss.Submit("title 'SUMMARY'.")
        print(self.summary)
        spss.Submit("title 'WARNINGS'.")
        print(self.warnings)
        if "MODEL ESTIMATION TERMINATED NORMALLY" in self.warnings:
            spss.Submit("title 'FIT STATISTICS'.")
            print(self.fit)
        if self.measurement is not None:
            spss.Submit("title 'UNSTANDARDIZED MEASUREMENT MODEL'.")
            print("Unstandardized")
            print(self.header)
            print(self.measurement)
        if self.coefficients is not None:
            spss.Submit("title 'UNSTANDARDIZED COEFFICIENTS'.")
            print("Unstandardized")
            print(self.header)
            print(self.coefficients)
        if self.covariances is not None:
            spss.Submit("title 'UNSTANDARDIZED COVARIANCES'.")
            print("Unstandardized")
            print(self.header)
            print(self.covariances)
        spss.Submit("title 'UNSTANDARDIZED DESCRIPTIVES'.")
        print("Unstandardized")
        print(self.header)
        print(self.descriptives)
        if self.newParam is not None:
            spss.Submit("title 'NEW/ADDITIONAL PARAMETERS'.")
            print(self.header)
            print(self.newParam)
        if self.Zmeasurement is not None:
            spss.Submit("title 'STANDARDIZED MEASUREMENT MODEL'.")
            print("Standardized")
            print(self.header)
            print(self.Zmeasurement)
        if self.Zcoefficients is not None:
            spss.Submit("title 'STANDARDIZED COEFFICIENTS'.")
            print("Standardized")
            print(self.header)
            print(self.Zcoefficients)
        if self.Zcovariances is not None:
            spss.Submit("title 'STANDARDIZED COVARIANCES'.")
            print("Standardized")
            print(self.header)
            print(self.Zcovariances)
        if self.Zdescriptives is not None:
            spss.Submit("title 'STANDARDIZED DESCRIPTIVES'.")
            print("Standardized")
            print(self.header)
            print(self.Zdescriptives)
        if self.groupOutput is not None:
            for t in range(len(self.groupLabels)):
                spss.Submit("title 'GROUP {0} UNSTANDARDIZED'.".format(self.groupLabels[t]))
                print(self.groupOutput[t])
        if self.groupZoutput is not None:
            for t in range(len(self.groupLabels)):
                spss.Submit("title 'GROUP {0} STANDARDIZED'.".format(self.groupLabels[t]))
                print(self.groupZoutput[t])
        if self.r2 is not None:
            spss.Submit("title 'R-SQUARES'.")
            print(self.r2)
        if self.indirect is not None:
            spss.Submit("title 'INDIRECT EFFECTS'.")
            print(self.indirect)
        if self.Zindirect is not None:
            spss.Submit("title 'STANDARDIZED INDIRECT EFFECTS'.")
            print(self.Zindirect)
        if self.ci is not None:
            spss.Submit("title 'UNSTANDARDIZED BOOTSTRAP CIs'.")
            print(self.ci)
        if self.Zci is not None:
            spss.Submit("title 'STANDARDIZED BOOTSTRAP CIs'.")
            print(self.Zci)
        if self.indirectci is not None:
            spss.Submit("title 'UNSTANDARDIZED INDIRECT CIs'.")
            print(self.indirectci)
        if self.Zindirectci is not None:
            spss.Submit("title 'STANDARDIZED INDIRECT BOOTSTRAP CIs'.")
            print(self.Zindirectci)            
        if self.mi is not None:
            spss.Submit("title 'MODIFICATION INDICES'.")
            print(self.mi)
    
    # Save coefficients to dataset
    def toSPSSdata(self, estimator, datasetName="MPAcoefs", datasetIntercepts=True, labelList=[]):
        # Determine active data set so we can return to it when finished
        activeName = spss.ActiveDataset()
        # Set up data set if it doesn't already exist
        tag, err = spssaux.createXmlOutput('Dataset Display', omsid='Dataset Display', subtype='Datasets')
        datasetList = spssaux.getValuesFromXmlWorkspace(tag, 'Datasets')
    
        if datasetName not in datasetList:
            spss.StartDataStep()
            datasetObj = spss.Dataset(name=None)
            dsetname = datasetObj.name
            datasetObj.varlist.append("Outcome", 50)
            datasetObj.varlist.append("Predictor", 50)
            if estimator == "BAYES":
                datasetObj.varlist.append("b_Coefficient", 0)
                datasetObj.varlist.append("b_PostSD", 0)
                datasetObj.varlist.append("b_p", 0)
                datasetObj.varlist.append("b_lower", 0)
                datasetObj.varlist.append("b_upper", 0)
                datasetObj.varlist.append("beta_Coefficient", 0)
                datasetObj.varlist.append("beta_PostSD", 0)
                datasetObj.varlist.append("beta_p", 0)
                datasetObj.varlist.append("beta_lower", 0)
                datasetObj.varlist.append("beta_upper", 0)
            else:
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
        datasetObj = spss.Dataset(name=datasetName)
        spss.SetActive(datasetObj)
    
        # Label variables
        variableList = []
        for t in range(spss.GetVariableCount()):
            variableList.append(spss.GetVariableName(t))
        for t in range(len(labelList)):
            if "label{0}".format(str(t)) not in variableList:
                datasetObj.varlist.append("label{0}".format(str(t)), 50)
        spss.EndDataStep()
    
        # Set variables to f8.3
        if estimator == "BAYES":
            submitstring = "alter type b_Coefficient to beta_upper (f8.3)."
        else:
            submitstring = "alter type b_Coefficient to beta_p (f8.3)."
        spss.Submit(submitstring)
    
        # Get intercepts
        if datasetIntercepts:
            bInt = getIntercepts(self.descriptives)
            zInt = getIntercepts(self.Zdescriptives)
    
        # Get coefficients
        bCoef = getCoefficients(self.coefficients)
        zCoef = getCoefficients(self.Zcoefficients)
    
        # Determine values for dataset
        dataValues = []
        if datasetIntercepts and bInt is not None:
            for t in range(len(bInt)):
                rowList = bInt[t]
                rowList.extend(zInt[t][2:])
                rowList.extend(labelList)
                dataValues.append(rowList)
        for t in range(len(bCoef)):
            rowList = bCoef[t]
            rowList.extend(zCoef[t][2:])
            rowList.extend(labelList)
            dataValues.append(rowList)
    
        # Put values in dataset
        spss.StartDataStep()
        datasetObj = spss.Dataset(name=datasetName)
        for t in dataValues:
            datasetObj.cases.append(t)
        spss.EndDataStep()
    
        # Return to original data set
        spss.StartDataStep()
        datasetObj = spss.Dataset(name=activeName)
        spss.SetActive(datasetObj)
        spss.EndDataStep()
    
    # Save indirect tests to dataset
    def indirectToSPSSdata(self, estimator, datasetName="MPAindirect", labelList=[]):
    
        # Determine active data set so we can return to it when finished
        activeName = spss.ActiveDataset()
        # Set up data set if it doesn't already exist
        tag, err = spssaux.createXmlOutput('Dataset Display', omsid='Dataset Display', subtype='Datasets')
        datasetList = spssaux.getValuesFromXmlWorkspace(tag, 'Datasets')
    
        if datasetName not in datasetList:
            spss.StartDataStep()
            datasetObj = spss.Dataset(name=None)
            dsetname = datasetObj.name
            datasetObj.varlist.append("IndirectTest", 200)
            datasetObj.varlist.append("Path", 200)
            datasetObj.varlist.append("SpecificEffect", 0)
            if estimator == "BAYES":
                datasetObj.varlist.append("b_Coefficient", 0)
                datasetObj.varlist.append("b_PostSD", 0)
                datasetObj.varlist.append("b_p", 0)
                datasetObj.varlist.append("b_lower", 0)
                datasetObj.varlist.append("b_upper", 0)
                datasetObj.varlist.append("beta_Coefficient", 0)
                datasetObj.varlist.append("beta_PostSD", 0)
                datasetObj.varlist.append("beta_p", 0)
                datasetObj.varlist.append("beta_lower", 0)
                datasetObj.varlist.append("beta_upper", 0)
            else:
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
        datasetObj = spss.Dataset(name=datasetName)
        spss.SetActive(datasetObj)
    
        # Label variables
        variableList = []
        for t in range(spss.GetVariableCount()):
            variableList.append(spss.GetVariableName(t))
        for t in range(len(labelList)):
            if "label{0}".format(str(t)) not in variableList:
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
        datasetObj = spss.Dataset(name=datasetName)
        for t in dataValues:
            datasetObj.cases.append(t)
        spss.EndDataStep()
    
        # Return to original data set
        spss.StartDataStep()
        datasetObj = spss.Dataset(name=activeName)
        spss.SetActive(datasetObj)
        spss.EndDataStep()

    # Save new/additional parameters to dataset
    def newToSPSSdata(self, estimator="ML", datasetName="MPAnew", labelList=[]):
        # Determine active data set so we can return to it when finished
        activeName = spss.ActiveDataset()
        # Set up data set if it doesn't already exist
        tag, err = spssaux.createXmlOutput('Dataset Display', omsid='Dataset Display', subtype='Datasets')
        datasetList = spssaux.getValuesFromXmlWorkspace(tag, 'Datasets')
    
        if datasetName not in datasetList:
            spss.StartDataStep()
            datasetObj = spss.Dataset(name=None)
            dsetname = datasetObj.name
            datasetObj.varlist.append("Parameter", 50)
            if estimator == "BAYES":
                datasetObj.varlist.append("Estimate", 0)
                datasetObj.varlist.append("PostSD", 0)
                datasetObj.varlist.append("p", 0)
                datasetObj.varlist.append("lower", 0)
                datasetObj.varlist.append("upper", 0)
            else:
                datasetObj.varlist.append("estimate", 0)
                datasetObj.varlist.append("SE", 0)
                datasetObj.varlist.append("Ratio", 0)
                datasetObj.varlist.append("p", 0)
            spss.EndDataStep()
            submitstring = """dataset activate {0}.
    dataset name {1}.""".format(dsetname, datasetName)
            spss.Submit(submitstring)
    
        spss.StartDataStep()
        datasetObj = spss.Dataset(name=datasetName)
        spss.SetActive(datasetObj)
    
        # Label variables
        variableList = []
        for t in range(spss.GetVariableCount()):
            variableList.append(spss.GetVariableName(t))
        for t in range(len(labelList)):
            if "label{0}".format(str(t)) not in variableList:
                datasetObj.varlist.append("label{0}".format(str(t)), 50)
        spss.EndDataStep()
    
        # Set variables to f8.3
        if estimator == "BAYES":
            submitstring = "alter type Estimate to upper (f8.3)."
        else:
            submitstring = "alter type Estimate to p (f8.3)."
        spss.Submit(submitstring)
    
        # Get coefficients
        param = getNewParam(self.newParam)
    
        # Determine values for dataset
        dataValues = []
        for t in range(len(param)):
            rowList = param[t]
            rowList.extend(labelList)
            dataValues.append(rowList)
    
        # Put values in dataset
        spss.StartDataStep()
        datasetObj = spss.Dataset(name=datasetName)
        for t in dataValues:
            datasetObj.cases.append(t)
        spss.EndDataStep()
    
        # Return to original data set
        spss.StartDataStep()
        datasetObj = spss.Dataset(name=activeName)
        spss.SetActive(datasetObj)
        spss.EndDataStep()
    
def MplusPathAnalysis(modellabel="MplusPathAnalysis", inpfile="Mplus/model.inp", inpShow=False, 
                      runModel=True, viewOutput=True, suppressSPSS=False, 
                      latent=None, latentFixed=None, latentIdentifiers=None,
                      model=None, xwith=None, means=None,
                      covar=None, covEndo=False, covExo=True, estimator=None,
                      starts=None,
                      useobservations=None, subpopulation=None, indirect=None, 
                      identifiers=None, meanIdentifiers=None, covIdentifiers=None, 
                      wald=None, constraint=None, montecarlo=None,
                      bootstrap=None, repse=None,
                      categorical=None, censored=None, count=None, nominal=None,
                      idvariable=None, cluster=None, grouping=None, weight=None, auxiliary=None, 
                      datasetName=None, datasetIntercepts=True, 
                      indDatasetName=None, newDatasetName=None, datasetLabels=[], 
                      miThreshold=10, savedata=None, saveFscores=False, 
                      processors=None, waittime=5):

    spss.Submit("display scratch.")

    # Redirect output
    if suppressSPSS:
        submitstring = """OMS /SELECT ALL EXCEPT = [WARNINGS] 
    /DESTINATION VIEWER = NO 
    /TAG = 'NoJunk'."""
        spss.Submit(submitstring)

    # Find directory and filename
    outdir = os.path.dirname(inpfile)
    fname, fext = os.path.splitext(os.path.basename(inpfile))

    # Obtain list of variables in data set
    SPSSvariables = []
    SPSSvariablesCaps = []
    for varnum in range(spss.GetVariableCount()):
        SPSSvariables.append(spss.GetVariableName(varnum))
        SPSSvariablesCaps.append(spss.GetVariableName(varnum).upper())

    # Restore output
    if suppressSPSS:
        submitstring = """OMSEND TAG = 'NoJunk'."""
        spss.Submit(submitstring)

    # Check for errors
    error = 0
    if fext.upper() != ".INP":
        print("Error: Input file specification does not end with .inp")
        error = 1
    if not os.path.exists(outdir):
        print("Error: Output directory does not exist")
        error = 1
    if estimator is not None:
        estimator = estimator.upper()
        if estimator not in ["ML", "MLM", "MLMV", "MLR", "MLF", "MUML", "WLS", "WLSM", "WLSMV", "ULS", "ULSMV", "GLS", "BAYES"]:
            print("Error: Estimator not valid")
            error = 1
                   
    if latent is not None:
        variableError = 0
        for equation in latent:
            if equation[0].upper() in SPSSvariablesCaps:
                variableError = 1
                break
        if variableError == 1:
            print("Error: Latent variable name overlaps with existing variable name")
            error = 1
    
    if xwith is not None:
        variableError = 0
        for equation in xwith:
            if equation[0].upper() in SPSSvariablesCaps:
                variableError = 1
                break
        if variableError == 1:
            print("Error: Xwith variable name overlaps with existing variable name")
            error = 1
    
    if latent is not None:
        variableError = 0
        for equation in latent:
            for var in equation[1:]:
                if var.upper() not in SPSSvariablesCaps:
                    variableError = 1
                    for latentvar in latent:
                        if var.upper() == latentvar[0].upper():
                            variableError = 0
                    if variableError == 1:
                        print("Missing " + var)
        if variableError == 1:
            print("Error: Variable listed in latent variable definition not in current data set")
            error = 1
    
    if model is not None:
        variableError = 0
        for equation in model:
            for var in equation:
                if var.upper() not in SPSSvariablesCaps:
                    variableError = 1
                    if latent is not None:
                        for latentvar in latent:
                            if var.upper() == latentvar[0].upper():
                                variableError = 0
                    if xwith is not None:
                        for xwithvar in xwith:
                            if var.upper() == xwithvar[0].upper():
                                variableError = 0
                    if variableError == 1:
                        print("Missing " + var)
    
        if variableError == 1:
            print("Error: Variable listed in model not in current data set")
            error = 1
    
    if error == 0:
        # Redirect output
        if suppressSPSS:
            submitstring = """OMS /SELECT ALL EXCEPT = [WARNINGS] 
    /DESTINATION VIEWER = NO 
    /TAG = 'NoJunk'."""
            spss.Submit(submitstring)
    
        # Export data
        dataname = os.path.join(outdir, fname + ".dat")
        MplusVariables = exportMplus(dataname)
    
        # Define latent variables using Mplus variables
        if latent is None:
            MplusLatent = None
        else:
            MplusLatent = []
            for t in latent:
                MplusLatent.append([i.upper() for i in t])
            for t in range(len(MplusLatent)):
                for i in range(len(MplusLatent[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if MplusLatent[t][i] == s:
                            MplusLatent[t][i] = m
    
        # Convert latentFixed to Mplus
        if latentFixed is None:
            MplusLatentFixed = None
        else:
            MplusLatentFixed = []
            fixedEquations = []
            for t in latentFixed:
                j = [i.upper() for i in t[0]]
                fixedEquations.append(j)
            for t in range(len(fixedEquations)):
                for i in range(len(fixedEquations[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if fixedEquations[t][i] == s:
                            fixedEquations[t][i] = m
                MplusLatentFixed.append([fixedEquations[t], latentFixed[t][1]])
                
        # Convert latentIdentifiers to Mplus
        if latentIdentifiers is None:
            MplusLatentIdentifiers = None
        else:
            MplusLatentIdentifiers = []
            latentIdEquations = []
            for t in latentIdentifiers:
                j = [i.upper() for i in t[0]]
                latentIdEquations.append(j)
            for t in range(len(latentIdEquations)):
                for i in range(len(latentIdEquations[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if latentIdEquations[t][i] == s:
                            latentIdEquations[t][i] = m
                MplusLatentIdentifiers.append([latentIdEquations[t], latentIdentifiers[t][1]])                

        # Define model using Mplus variables
        if model is None:
            MplusModel = None
        else:
            MplusModel = []
            for t in model:
                MplusModel.append([i.upper() for i in t])
            for t in range(len(MplusModel)):
                for i in range(len(MplusModel[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if MplusModel[t][i] == s:
                            MplusModel[t][i] = m
        
        # Convert variables in xwith to Mplus
        if xwith is None:
            MplusXwith = None
        else:
            MplusXwith = []
            for t in xwith:
                MplusXwith.append([i.upper() for i in t])
            for t in range(len(MplusXwith)):
                for i in range(len(MplusXwith[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if MplusXwith[t][i] == s:
                            MplusXwith[t][i] = m
        
        # Convert variables in covariance list to Mplus
        if covar is None:
            MplusCovar = None
        else:
            MplusCovar = []
            for t in covar:
                MplusCovar.append([i.upper() for i in t])
            for t in range(len(MplusCovar)):
                for i in range(2):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if MplusCovar[t][i] == s:
                            MplusCovar[t][i] = m
    
        # Define indirect effects using Mplus variables
        if indirect is None:
            MplusIndirect = None
        else:
            MplusIndirect = []
            for t in indirect:
                MplusIndirect.append([i.upper() for i in t])
            for t in range(len(MplusIndirect)):
                for i in range(len(MplusIndirect[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if MplusIndirect[t][i] == s:
                            MplusIndirect[t][i] = m
    
        # Convert identifiers to Mplus
        if identifiers is None:
            MplusIdentifiers = None
        else:
            MplusIdentifiers = []
            idEquations = []
            for t in identifiers:
                j = [i.upper() for i in t[0]]
                idEquations.append(j)
            for t in range(len(idEquations)):
                for i in range(len(idEquations[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if idEquations[t][i] == s:
                            idEquations[t][i] = m
                MplusIdentifiers.append([idEquations[t], identifiers[t][1]])

        # Convert mean identifiers to Mplus
        if meanIdentifiers is None:
            MplusMeanIdentifiers = None
        else:
            MplusMeanIdentifiers = []
            idMeans = [t[0].upper() for t in meanIdentifiers]
            for t in range(len(idMeans)):
                for s, m in zip(SPSSvariablesCaps, MplusVariables):
                    if idMeans[t] == s:
                        idMeans[t] = m
                MplusMeanIdentifiers.append([idMeans[t], meanIdentifiers[t][1]])
        
        # Convert covariance identifiers to Mplus
        if covIdentifiers is None:
            MplusCovIdentifiers = None
        else:
            MplusCovIdentifiers = []
            idEquations = []
            for t in covIdentifiers:
                j = [i.upper() for i in t[0]]
                idEquations.append(j)
            for t in range(len(idEquations)):
                for i in range(len(idEquations[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if idEquations[t][i] == s:
                            idEquations[t][i] = m
                MplusCovIdentifiers.append([idEquations[t], covIdentifiers[t][1]])

        # Convert useobservations to Mplus
        if useobservations is None:
            MplusUseobservations = None
        else:
            MplusUseobservations = useobservations
            for s, m in zip(SPSSvariablesCaps, MplusVariables):
                z = re.compile(s, re.IGNORECASE)
                MplusUseobservations = z.sub(m, MplusUseobservations)
         
        # Convert subpopulation to Mplus
        if subpopulation is None:
            MplusSubpopulation = None
        else:
            MplusSubpopulation = subpopulation
            for s, m in zip(SPSSvariablesCaps, MplusVariables):
                z = re.compile(s, re.IGNORECASE)
                MplusSubpopulation = z.sub(m, MplusSubpopulation)
        
        # Convert idvariable to Mplus
        if idvariable is None:
            MplusIdvariable = None
        else:
            for s, m in zip(SPSSvariablesCaps, MplusVariables):
                if idvariable.upper() == s:
                    MplusIdvariable = m
        
        # Convert cluster variable to Mplus
        if cluster is None:
            MplusCluster = None
        else:
            for s, m in zip(SPSSvariablesCaps, MplusVariables):
                if cluster.upper() == s:
                    MplusCluster = m
        
        # Convert grouping variable to Mplus
        if grouping is None:
            MplusGrouping = None
        else:
            # Separate grouping variable from values
            sep = grouping.find("(")
            grouping_var = grouping[0:sep].strip()
            grouping_val = grouping[sep:]
            for s, m in zip(SPSSvariablesCaps, MplusVariables):
                if grouping_var.upper() == s:
                    MplusGrouping = m
            MplusGrouping += " " + grouping_val
        
        # Convert variable list arguments to Mplus
        lvarList = [means, auxiliary, categorical, censored, count, nominal]
        MplusMeans = []
        MplusAuxiliary = []
        MplusCategorical = []
        MplusCensored = []
        MplusCount = []
        MplusNominal = []
        lvarMplusList = [MplusMeans, MplusAuxiliary, MplusCategorical, 
                         MplusCensored, MplusCount, MplusNominal]
        for t in range(len(lvarList)):
            if lvarList[t] is None:
                lvarMplusList[t] = None
            else:
                for i in lvarList[t]:
                    lvarMplusList[t].append(i.upper())
                for i in range(len(lvarMplusList[t])):
                    for s, m in zip(SPSSvariablesCaps, MplusVariables):
                        if lvarMplusList[t][i] == s:
                            lvarMplusList[t][i] = m
        
        # Convert weight variable to Mplus
        if weight is None:
            MplusWeight = None
        else:
            for s, m in zip(SPSSvariablesCaps, MplusVariables):
                if weight.upper() == s:
                    MplusWeight = m
        
        # Create input program
        pathProgram = MplusPAprogram()
        pathProgram.setTitle("Created by MplusPathAnalysis")
        pathProgram.setData(dataname)
        pathProgram.setVariablePA(MplusVariables, MplusLatent, MplusModel, 
                                  MplusXwith, MplusUseobservations, MplusSubpopulation,
                                  MplusCategorical, MplusCensored, MplusCount, MplusNominal, MplusIdvariable,
                                  MplusCluster, MplusWeight, MplusAuxiliary, MplusGrouping)
        pathProgram.setAnalysis(MplusXwith, MplusCluster, MplusWeight, estimator,
                                starts, montecarlo, bootstrap, repse, processors)
        pathProgram.setModel(MplusLatent, MplusLatentFixed, MplusLatentIdentifiers,
                            MplusModel, MplusXwith, MplusMeans,
                             MplusCovar, covEndo, covExo, MplusIndirect, MplusIdentifiers, 
                             MplusMeanIdentifiers, MplusCovIdentifiers, wald)
        pathProgram.setConstraint(constraint)
        pathProgram.setSavedata(savedata, saveFscores)
        pathProgram.setOutput("stdyx;\nmodindices({0});".format(miThreshold), bootstrap)
        pathProgram.write(os.path.join(outdir, fname + ".inp"))
        
        # Add latent variables to SPSSvariables lists
        if latent is not None:
            for equation in latent:
                if equation[0].upper() not in SPSSvariablesCaps:
                    SPSSvariables.append(equation[0])
                    SPSSvariablesCaps.append(equation[0].upper())
        
        # Add latent variables to MplusVariable list
        if latent is not None:
            for equation in latent:
                if equation[0].upper() not in MplusVariables:
                    MplusVariables.append(equation[0].upper())
        
        if runModel:
            # Run input program
            batchfile(outdir, fname)
            time.sleep(waittime)
        
            # Restore output
            if suppressSPSS:
                submitstring = """OMSEND TAG = 'NoJunk'."""
                spss.Submit(submitstring)

            # Parse output
            inpText = None
            if inpShow == True:
                inpText = pathProgram.inpOutput()                    
            if viewOutput:
                pathOutput = MplusPAoutput(modellabel, os.path.join(outdir, fname + ".out"), inpText,
                                           MplusVariables, SPSSvariables, MplusGrouping, estimator, starts)
                pathOutput.toSPSSoutput()
        
                # Redirect output
                if suppressSPSS:
                    submitstring = """OMS /SELECT ALL EXCEPT = [WARNINGS] 
        /DESTINATION VIEWER = NO 
        /TAG = 'NoJunk'."""
                    spss.Submit(submitstring)
        
                # Create coefficient dataset
                if datasetName is not None:
                    pathOutput.toSPSSdata(estimator, datasetName, datasetIntercepts, datasetLabels)
        
                # Create indirect effects dataset
                if indDatasetName is not None:
                    if pathOutput.indirect is not None:
                        pathOutput.indirectToSPSSdata(estimator, indDatasetName, datasetLabels)
                        
                # Create dataset for new/additional parameters
                if newDatasetName is not None:
                    if constraint is not None:
                        pathOutput.newToSPSSdata(estimator, newDatasetName, datasetLabels)
        
                # Restore output
                if suppressSPSS:
                    submitstring = """OMSEND TAG = 'NoJunk'."""
                    spss.Submit(submitstring)
        
    # Replace titles
    titleToPane()

end program python3.
set printback = on.

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
* 2018-10-30 Added MLR command
    MLR is always used if a weight variable is defined
* 2019-04-14 Added constraint option
* 2019-04-14a Added means and meanIdentifiers options
* 2019-04-15 Added new parameters section to output
* 2019-05-10 Added xwith option
* 2019-05-11 Fixed error with xwith
* 2020-10-29 Added montecarlo option
* 2020-11-01 Added bootstrap option
* 2020-11-04 Removed non-letter characters at the start of variable names
* 2020-11-04a Added covIdentifiers option
* 2020-11-05 Added warning about using covIdentifiers with covExo or covEndo
* 2020-12-02 Added grouping option
* 2020-12-02a Changed output for MGA
* 2020-12-02b Separated unstandardized and standardized MGA output
* 2020-12-07 Corrected misspelling of wald
* 2020-12-27 Replaced variable names in grouping output
* 2021-01-26 Added "subpopulation" argument
* 2021-04-08 Added latentFixed argument
*    Ensured that each latent variable only added to SPSSvariables once
* 2021-04-09 Added modellabel argument
* 2021-05-07 Added estimator argument/dropped MLR
* 2021-05-09 Changed output and dataset headers for Bayes estimation
* 2021-06-28 R-square section now prints with a Bayes model
* 2021-06-28a Added CIs to SPSS output
* 2021-06-28b Corrected variable names in CI output
* 2021-07-06 Included intercepts in coefficient data set
*    Added datasetIntercepts argument
* 2021-07-11 Corrected parsing of output for CFAs
* 2021-07-12 Corrected error when there are no intercepts but
*    datasetIntercepts = True
* 2021-08-08 Added savedata and saveFscores arguments
* 2021-08-09 Added idvariable argument
* 2021-08-12 Revised output parsing
* 2021-10-04 Corrected mulitgroup output extraction when model doesn't converge
* 2021-11-13 Removed extra print statements
* 2021-12-21 Allowed hierarchical latents
* 2021-12-22 Removed extra print commands
* 2021-12-27 Fixed error with MI section in MGAs
* 2022-01-04 Included number of categorical latent variables in summary
* 2022-02-13 Added processors argument
* 2022-02-22 Added starts argument
* 2022-03-11 Altered additional date/time types
* 2022-10-20 Stopped coefficients section at "Intercepts"
* 2022-11-09 Corrected error when extracting multiple specific effects
* 2023-08-30 Set coefficient elements to -999 when undefined
* 2024-01-03 Renamed twoLevel function so it doesn't conflict with MTL
* 2024-05-28 Aligned tabs
* 2024-05-28a Converted to Python 3
* 2024-07-05 Removed extra parentheses
* 2024-09-10 Added option to save new/additional parameters
* 2024-10-23 Added latentIdentifiers
* 2024-11-12 Corrected parenthesis error in MI
* 2024-11-13 Set Estimator in getNewParam to default to ML
* 2024-11-13a Added inpShow argument

COMMENT BOOKMARK;LINE_NUM=977;ID=1.
