(* vim: set syntax=mma: *)

BeginPackage["Fermat`"];

Install["mmaFermat"];

FermatAddSymbol[sym_Symbol] := FermatEval["&(J="<>ToString[sym,InputForm]<>")"];

Fermat[expr_] := ToExpression[StringReplace[FermatEval[StringReplace[ToString[expr,InputForm]," "->""]],RegularExpression[";.*$"]->""]];
Fermat[list_List] := Fermat/@list;
Fermat[expr_?NumberQ] := expr;

FermatSolve[eqs_,vars_] := Module[{sparse,res,f},
	sparse = Select[ArrayRules[Last[CoefficientArrays[eqs,vars]]],First[#] =!= {_,_} &];
	sparse = Gather[sparse,#1[[1,1]] === #2[[1,1]] &];
	sparse = Map[f,sparse,{1}]/.f[a_]:>Flatten[{a[[1,1,1]],a/.Rule[{r_,c_},b_]->{c,b}},1];
	
	FermatEval["&U"];	(* workaround *)
	FermatEval["Array tmpmat["<>ToString[Length[eqs],InputForm]<>","<>ToString[Length[vars],InputForm]<>"] Sparse"];
	FermatEval["&U"];
	
	FermatEval["[tmpmat]:="<>StringReplace[StringReplace[ToString[sparse,InputForm],{"{"->"[","}"->"]"," "->""}],"]],["->"]]["]];
	FermatEval["Redrowech([tmpmat])"];
	res = FermatEval["![tmpmat]"];
	FermatEval["@[tmpmat]"]; 

	res = StringReplace[StringReplace[res,{RegularExpression["^[^:]*:="]->"",RegularExpression["\][^]]*$"]->"}"," "->"","["->"{","]"->"}"}],"}{"->"},{"];
	res = ToExpression[res];
	res = Map[f,res,{1}]/.f[a_]:>f[Drop[a,1]]/.f[a_]:>Rule[vars[[a[[1,1]]]],-Total[(vars[[First[#]]]*Last[#] &)/@Drop[a,1]]];
{res}];

FermatInverse[mat_List] := Module[{res},
	FermatEval["&U"];	(* workaround *)
	FermatEval["Array tmpmat1["<>ToString[Length[mat],InputForm]<>","<>ToString[Length[First[mat]],InputForm]<>"]"];

	FermatEval["[tmpmat1]:="<>StringReplace[ToString[Flatten[Transpose[mat]],InputForm],{"{"->"[[","}"->"]]"}]];
	FermatEval["[tmpmat2]:=1/[tmpmat1]"];
	FermatEval["&U"];

	res = FermatEval["[tmpmat2]"];
	FermatEval["@[tmpmat1]"];
	FermatEval["@[tmpmat2]"];

	res = StringReplace[StringReplace[res,{" "->"","["->"{","]"->"}"}],{RegularExpression["}}0"]->"}}"}];
	res = ToExpression[res];
res];

FermatDet[mat_List] := Module[{res},
    FermatEval["&U"];	(* workaround *)
    FermatEval["Array tmpmat["<>ToString[Length[mat],InputForm]<>","<>ToString[Length[First[mat]],InputForm]<>"]"];
    FermatEval["[tmpmat]:="<>StringReplace[ToString[Flatten[Transpose[mat]],InputForm],{"{"->"[[","}"->"]]"}]];
    FermatEval["&U"];	(* workaround *)

    res = FermatEval["Det[tmpmat]"];

    FermatEval["@[tmpmat]"];

    res = ToExpression[res];
res];

FermatRank[mat_List] := Module[{res},
    FermatEval["&U"];	(* workaround *)
    FermatEval["Array tmpmat["<>ToString[Length[mat],InputForm]<>","<>ToString[Length[First[mat]],InputForm]<>"]"];
    FermatEval["[tmpmat]:="<>StringReplace[ToString[Flatten[Transpose[mat]],InputForm],{"{"->"[[","}"->"]]"}]];
    FermatEval["&U"];	(* workaround *)

    res = FermatEval["Normalize([tmpmat])"];

    FermatEval["@[tmpmat]"];

    res = ToExpression[res];
res];

EndPackage[];


