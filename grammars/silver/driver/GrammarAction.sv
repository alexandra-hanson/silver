grammar silver:driver;

{-
 - A short guide to error codes:
 - Negative = configuration/installation error
 - 1-19 = command line/start up error
 - 20+ = Normal use error (errors in spec)
 - 127 = "abnormal" success (e.g. printed version string, quit now)
 - 0 = success of course
 -}

{- Orders:
 - 0: parsing errors (also flow graph emitting)
 - 1: binding errors
 - 3: interfaces and classes
 - 4: doc
 - 5: copper_mda
 - 6: buildxml
 - 7: impide
 -}

aspect production compilation
top::Compilation ::= g::Grammars  r::Grammars  buildGrammar::String  benv::BuildEnv
{
  top.postOps <- [printAllParsingErrors(g.grammarList ++ r.grammarList)];
  top.postOps <- if top.config.noBindingChecking then [] else
    [printAllBindingErrors(g.grammarList ++ r.grammarList)]; 
  top.postOps <- [touchIfaces(r.grammarList, benv.silverGen)];
}

abstract production touchIfaces
top::DriverAction ::= r::[Decorated RootSpec] genPath::String
{
  top.io = touchFiles(map(sviPath(_, genPath), r), top.ioIn);
  top.code = 0;
  top.order = 3;
}
function sviPath
String ::= r::Decorated RootSpec genPath::String
{
  return genPath ++ "src/" ++ grammarToPath(r.declaredName) ++ "Silver.svi";
}

abstract production printAllBindingErrors
top::DriverAction ::= specs::[Decorated RootSpec]
{
  forwards to printAllBindingErrorsHelp(specs)
  with {
    ioIn = print("Checking For Errors.\n", top.ioIn);
  };
}

abstract production printAllBindingErrorsHelp
top::DriverAction ::= specs::[Decorated RootSpec]
{
  local es :: [Message] = head(specs).errors;

  local i :: IO =
    if null(es)
    then top.ioIn
    else print("Errors for : " ++ head(specs).declaredName ++ " :\n" ++ foldMessages(es) ++ "\n\n", top.ioIn);

  local recurse :: DriverAction = printAllBindingErrorsHelp(tail(specs));
  recurse.ioIn = i;

  top.io = if null(specs) then top.ioIn else recurse.io;

  top.code = 
    if null(specs) || (!containsErrors(es, head(specs).config.warnError) && recurse.code == 0)
    then 0
    else 20;

  top.order = 1;
}

abstract production printAllParsingErrors
top::DriverAction ::= specs::[Decorated RootSpec]
{
  local errs :: [Message] = flatMap((.parsingErrors), specs);

  top.io = if null(errs) then top.ioIn else print(foldMessages(errs), top.ioIn);
  top.order = 0;
  top.code = if null(errs) then 0 else 21;
}

