grammar silver:modification:collection;

import silver:definition:type:syntax;
import silver:extension:list;
import silver:util;

--import silver:analysis:typechecking:core;

nonterminal NameOrBOperator with config, location, grammarName, errors, env, unparse, operation, operatorForType;
nonterminal Operation;

synthesized attribute operation :: Operation;
inherited attribute operatorForType :: Type;

concrete production nameOperator
top::NameOrBOperator ::= q::QName
{
  top.unparse = q.unparse;

  top.operation = case q.lookupValue.dcl of
                  | funDcl(_,_,_) -> functionOperation(q.lookupValue.fullName)
                  | prodDcl(_,_,_,_) -> productionOperation(q.lookupValue.fullName)
                  | _ -> error("INTERNAL ERROR: operation attribute demanded for non-function or production.")
                  end;

  top.errors := q.lookupValue.errors;
  
  local checkOperationType :: TypeCheck =
    check(freshenCompletely(q.lookupValue.typerep),
      functionType(top.operatorForType, [top.operatorForType, top.operatorForType], []));
  checkOperationType.downSubst = emptySubst();
  checkOperationType.finalSubst = checkOperationType.upSubst;
  
  local operationErrors :: [Message] =
    if !checkOperationType.typeerror then []
    else [err(top.location, q.name ++ " must be of type " ++ checkOperationType.rightpp ++
            " instead it is of type " ++ checkOperationType.leftpp)];
  
  top.errors <- if !q.lookupValue.found then [] else
    case q.lookupValue.dcl of
    | funDcl(_,_,_) -> operationErrors
    | prodDcl(_,_,_,_) -> operationErrors
    | _ -> [err(top.location, q.name ++ " is not a valid operator for collections.")]
    end;
}

concrete production plusplusOperator
top::NameOrBOperator ::= '++'
{
  top.unparse = "++";

  top.operation = case top.operatorForType of
                  | stringType() -> plusPlusOperationString()
                  | listType(_) -> plusPlusOperationList()
                  | _ -> error("INTERNAL ERROR: operation attribute demanded for ++ that isn't string or list.")
                  end;
  top.errors := case top.operatorForType of
                | stringType() -> []
                | listType(_) -> []
                | _ -> [err(top.location, "++ operator will only work for collections of type list or String")]
                end;
}

concrete production borOperator
top::NameOrBOperator ::= '||'
{
  top.unparse = "||";

  top.operation = borOperation();
  top.errors := case top.operatorForType of
                | boolType() -> []
                | _ -> [err(top.location, "|| operator will only work for collections of type Boolean")]
                end;
}
concrete production bandOperator
top::NameOrBOperator ::= '&&'
{
  top.unparse = "&&";

  top.operation = bandOperation();
  top.errors := case top.operatorForType of
                | boolType() -> []
                | _ -> [err(top.location, "&& operator will only work for collections of type Boolean")]
                end;
}

abstract production functionOperation
top::Operation ::= s::String
{
}
abstract production productionOperation
top::Operation ::= s::String
{
}
abstract production plusPlusOperationString
top::Operation ::= 
{
}
abstract production plusPlusOperationList
top::Operation ::= 
{
}
abstract production borOperation
top::Operation ::= 
{
}
abstract production bandOperation
top::Operation ::= 
{
}

--- Declarations ---------------------------------------------------------------
concrete production collectionAttributeDclSyn
top::AGDcl ::= 'synthesized' 'attribute' a::Name tl::BracketedOptTypeExprs '::' te::TypeExpr 'with' q::NameOrBOperator ';'
{
  top.unparse = "synthesized attribute " ++ a.name ++ tl.unparse ++ " :: " ++ te.unparse ++ " with " ++ q.unparse ++ " ;" ;

  production attribute fName :: String;
  fName = top.grammarName ++ ":" ++ a.name;

  tl.initialEnv = top.env;
  tl.env = tl.envBindingTyVars;
  te.env = tl.envBindingTyVars;
  
  q.operatorForType = te.typerep;
  
  top.defs := [synColDef(top.grammarName, a.location, fName, tl.freeVariables, te.typerep, q.operation)];
  
  propagate errors, flowDefs;
  
  top.errors <- tl.errorsTyVars;

  top.errors <-
        if length(getAttrDclAll(fName, top.env)) > 1
        then [err(a.location, "Attribute '" ++ fName ++ "' is already bound.")]
        else [];
}

concrete production collectionAttributeDclInh
top::AGDcl ::= 'inherited' 'attribute' a::Name tl::BracketedOptTypeExprs '::' te::TypeExpr 'with' q::NameOrBOperator ';'
{
  top.unparse = "inherited attribute " ++ a.name ++ tl.unparse ++ " :: " ++ te.unparse ++ " with " ++ q.unparse ++ " ;" ;

  production attribute fName :: String;
  fName = top.grammarName ++ ":" ++ a.name;

  tl.initialEnv = top.env;
  tl.env = tl.envBindingTyVars;
  te.env = tl.envBindingTyVars;
  
  q.operatorForType = te.typerep;

  top.defs := [inhColDef(top.grammarName, a.location, fName, tl.freeVariables, te.typerep, q.operation)];

  propagate errors, flowDefs;
  
  top.errors <- tl.errorsTyVars;

  top.errors <-
        if length(getAttrDclAll(fName, top.env)) > 1
        then [err(a.location, "Attribute '" ++ fName ++ "' is already bound.")]
        else [];
}


concrete production collectionAttributeDclProd
top::ProductionStmt ::= 'production' 'attribute' a::Name '::' te::TypeExpr 'with' q::NameOrBOperator ';'
{
  top.unparse = "production attribute " ++ a.name ++ " :: " ++ te.unparse ++ " with " ++ q.unparse ++ " ;" ;

  top.productionAttributes := [localColDef(top.grammarName, a.location, fName, te.typerep, q.operation)];

  production attribute fName :: String;
  fName = top.frame.fullName ++ ":local:" ++ a.name;

  top.defs := [];

  propagate errors;

  top.errors <-
        if length(getValueDclAll(fName, top.env)) > 1
        then [err(a.location, "Value '" ++ fName ++ "' is already bound.")]
        else [];

  q.operatorForType = te.typerep;
 
  forwards to productionAttributeDcl($1, $2, a, $4, te, $8, location=top.location);
}

--- The use semantics ----------------------------------------------------------

-- ERROR ON VALUE DEFS:
abstract production errorCollectionValueDef
top::ProductionStmt ::= val::Decorated QName  e::Expr
{
  top.errors <- [err(top.location, "The ':=' and '<-' operators can only be used for collections. " ++ val.name ++ " is not a collection.")];
  
  -- TODO: this production also produces an error message, so we'll produce two errors for one flaw.
  -- We don't want to use := for the errors, because we'd miss any errors in e, and we don't want to repeat
  -- it because that will produce duplicate trees.
  forwards to errorValueDef(val, e, location=top.location);
}
abstract production errorColNormalValueDef
top::ProductionStmt ::= val::Decorated QName  e::Expr
{
  top.errors <- [err(top.location, val.name ++ " is a collection attribute, and you must use ':=' or '<-', not '='.")];
  
  -- TODO: same problem
  forwards to errorValueDef(val, e, location=top.location);
}

-- NON-ERRORS for PRODUCTIONS

abstract production baseCollectionValueDef
top::ProductionStmt ::= val::Decorated QName  e::Expr
{
  top.unparse = "\t" ++ val.unparse ++ " := " ++ e.unparse ++ ";";

  e.downSubst = top.downSubst;
  -- the real type checking is done by the forward, but we must ensure things are tied up nicely
  -- otherwise we don't specialize ntOrDecs in OUR e
  forward.downSubst = unifyCheck(val.lookupValue.typerep, e.typerep, e.upSubst);
  
  forwards to localValueDef(val, e, location=top.location);
}
abstract production appendCollectionValueDef
top::ProductionStmt ::= val::Decorated QName  e::Expr
{
  top.unparse = "\t" ++ val.unparse ++ " <- " ++ e.unparse ++ ";";

  e.downSubst = top.downSubst;
  -- the real type checking is done by the forward, but we must ensure things are tied up nicely
  -- otherwise we don't specialize ntOrDecs in OUR e
  forward.downSubst = unifyCheck(val.lookupValue.typerep, e.typerep, e.upSubst);
  
  forwards to localValueDef(val, e, location=top.location);
}

-- NON-ERRORS for SYN ATTRS

abstract production synBaseColAttributeDef
top::ProductionStmt ::= dl::Decorated DefLHS  attr::Decorated QNameAttrOccur  e::Expr
{
  top.unparse = "\t" ++ dl.unparse ++ "." ++ attr.unparse ++ " := " ++ e.unparse ++ ";";

  top.errors := e.errors;

  local attribute errCheck1 :: TypeCheck; errCheck1.finalSubst = top.finalSubst;

  e.downSubst = top.downSubst;
  errCheck1.downSubst = e.upSubst;
  top.upSubst = errCheck1.upSubst; 

  errCheck1 = check(attr.typerep, e.typerep);
  top.errors <-
    if errCheck1.typeerror
    then [err(top.location, "Attribute " ++ attr.name ++ " has type " ++ errCheck1.leftpp ++ " but the expression being assigned to it has type " ++ errCheck1.rightpp)]
    else [];
}
abstract production synAppendColAttributeDef
top::ProductionStmt ::= dl::Decorated DefLHS  attr::Decorated QNameAttrOccur  e::Expr
{
  top.unparse = "\t" ++ dl.unparse ++ "." ++ attr.unparse ++ " <- " ++ e.unparse ++ ";";

  top.errors := e.errors;

  local attribute errCheck1 :: TypeCheck; errCheck1.finalSubst = top.finalSubst;

  e.downSubst = top.downSubst;
  errCheck1.downSubst = e.upSubst;
  top.upSubst = errCheck1.upSubst; 

  errCheck1 = check(attr.typerep, e.typerep);
  top.errors <-
    if errCheck1.typeerror
    then [err(top.location, "Attribute " ++ attr.name ++ " has type " ++ errCheck1.leftpp ++ " but the expression being assigned to it has type " ++ errCheck1.rightpp)]
    else [];
}

-- NON-ERRORS for INHERITED ATTRS

abstract production inhBaseColAttributeDef
top::ProductionStmt ::= dl::Decorated DefLHS  attr::Decorated QNameAttrOccur  e::Expr
{
  top.unparse = "\t" ++ dl.unparse ++ "." ++ attr.unparse ++ " := " ++ e.unparse ++ ";";

  top.errors := e.errors;

  local attribute errCheck1 :: TypeCheck; errCheck1.finalSubst = top.finalSubst;

  e.downSubst = top.downSubst;
  errCheck1.downSubst = e.upSubst;
  top.upSubst = errCheck1.upSubst; 

  errCheck1 = check(attr.typerep, e.typerep);
  top.errors <-
    if errCheck1.typeerror
    then [err(top.location, "Attribute " ++ attr.name ++ " has type " ++ errCheck1.leftpp ++ " but the expression being assigned to it has type " ++ errCheck1.rightpp)]
    else [];
}
abstract production inhAppendColAttributeDef
top::ProductionStmt ::= dl::Decorated DefLHS  attr::Decorated QNameAttrOccur  e::Expr
{
  top.unparse = "\t" ++ dl.unparse ++ "." ++ attr.unparse ++ " <- " ++ e.unparse ++ ";";

  top.errors := e.errors;

  local attribute errCheck1 :: TypeCheck; errCheck1.finalSubst = top.finalSubst;

  e.downSubst = top.downSubst;
  errCheck1.downSubst = e.upSubst;
  top.upSubst = errCheck1.upSubst; 

  errCheck1 = check(attr.typerep, e.typerep);
  top.errors <-
    if errCheck1.typeerror
    then [err(top.location, "Attribute " ++ attr.name ++ " has type " ++ errCheck1.leftpp ++ " but the expression being assigned to it has type " ++ errCheck1.rightpp)]
    else [];
}

-- The use syntax --------------------------------------------------------------

terminal Contains_t      '<-' lexer classes {SPECOP};
terminal BaseContains_t  ':=' lexer classes {SPECOP};

concrete production attrContainsAppend
top::ProductionStmt ::= dl::DefLHS '.' attr::QNameAttrOccur '<-' e::Expr ';'
{
  top.unparse = "\t" ++ dl.unparse ++ "." ++ attr.unparse ++ " <- " ++ e.unparse ++ ";";

  -- defs must stay here explicitly, because we dispatch on types in the forward here!
  top.productionAttributes := [];
  top.defs := [];
  
  dl.defLHSattr = attr;
  attr.attrFor = dl.typerep;

  forwards to
    if !dl.found || !attr.found
    then errorAttributeDef(dl.errors ++ attr.errors, dl, attr, e, location=top.location)
    else attr.attrDcl.attrAppendDefDispatcher(dl, attr, e, top.location);
}

concrete production attrContainsBase
top::ProductionStmt ::= dl::DefLHS '.' attr::QNameAttrOccur ':=' e::Expr ';'
{
  top.unparse = "\t" ++ dl.unparse ++ "." ++ attr.unparse ++ " := " ++ e.unparse ++ ";";

  -- defs must stay here explicitly, because we dispatch on types in the forward here!
  top.productionAttributes := [];
  top.defs := [];
  
  dl.defLHSattr = attr;
  attr.attrFor = dl.typerep;

  forwards to
    if !dl.found || !attr.found
    then errorAttributeDef(dl.errors ++ attr.errors, dl, attr, e, location=top.location)
    else attr.attrDcl.attrBaseDefDispatcher(dl, attr, e, top.location);
}

concrete production valContainsAppend
top::ProductionStmt ::= val::QName '<-' e::Expr ';'
{
  top.unparse = val.unparse ++ " <- " ++ e.unparse ++ ";";
  
  top.errors <- val.lookupValue.errors;

  top.productionAttributes := [];
  top.defs := [];
  
  forwards to if null(val.lookupValue.dcls)
              then errorValueDef(val, e, location=top.location)
              else val.lookupValue.dcl.appendDefDispatcher(val, e, top.location);
}

concrete production valContainsBase
top::ProductionStmt ::= val::QName ':=' e::Expr ';'
{
  top.unparse = val.unparse ++ " := " ++ e.unparse ++ ";";

  top.errors <- val.lookupValue.errors;

  top.productionAttributes := [];
  top.defs := [];
  
  forwards to if null(val.lookupValue.dcls)
              then errorValueDef(val, e, location=top.location)
              else val.lookupValue.dcl.baseDefDispatcher(val, e, top.location);
}

