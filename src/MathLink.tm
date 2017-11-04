:Evaluate:	BeginPackage["Fermat`"]

:Evaluate:      FermatEval::usage = "FermatEval['x'] performs an external evaluation of x"
:Evaluate:      FermatInit::usage = "FermatInit['file'] initializes fermat"
:Evaluate:      FermatClose::usage = "FermatClose[] closes the fermat program and the link"

:Evaluate:	Begin["Private`"]

:Begin:
:Function:      FermatEval
:Pattern:       FermatEval[s_String]
:Arguments:     {s}
:ArgumentTypes: {String}
:ReturnType:    Manual
:End:

:Begin:
:Function:      FermatInit
:Pattern:       FermatInit[path_String]
:Arguments:     {path}
:ArgumentTypes: {String}
:ReturnType:    Null
:End:

:Begin:
:Function:      FermatClose
:Pattern:       FermatClose[]
:Arguments:     {}
:ArgumentTypes: {}
:ReturnType:    Null
:End:

:Evaluate:	Print["Link to Fermat established."]

:Evaluate:	End[]
:Evaluate:	EndPackage[]
