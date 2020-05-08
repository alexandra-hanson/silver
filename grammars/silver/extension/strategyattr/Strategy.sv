grammar silver:extension:strategyattr;

import silver:definition:flow:driver only ProductionGraph, FlowType, constructAnonymousGraph;
import silver:driver:util;

abstract production strategyAttributeDcl
top::AGDcl ::= isTotal::Boolean a::Name recVarEnv::[Pair<String Pair<Boolean String>>] e::StrategyExpr
{
  top.unparse = (if isTotal then "" else "partial ") ++ "strategy attribute " ++ a.unparse ++ "=" ++ e.unparse ++ ";";

  production attribute fName :: String;
  fName = top.grammarName ++ ":" ++ a.name;
  
  -- Define these directly to avoid circular dependencies,
  -- since the forward contributes to the env.
  propagate errors, moduleNames;
  
  top.errors <-
    if length(getAttrDclAll(fName, top.env)) > 1
    then [err(a.location, "Attribute '" ++ fName ++ "' is already bound.")]
    else [];
  top.errors <-
    if null(getValueDcl("core:monad:bindMaybe", top.env))
    then [err(top.location, "Strategy attributes require import of core:monad")]
    else [];
  top.errors <-
    if isTotal && !e.isTotal
    -- Not an error since we can still translate this, but the translation may raise run-time errors in case of failure
    then [wrn(e.location, s"Implementation of total strategy ${a.name} is not total")]
    else []; 
  
  -- Frame doesn't really matter, since we will re-check any expressions occuring in e when propagated.
  -- Need all this to construct a bogus frame...
  local myFlow :: EnvTree<FlowType> = head(searchEnvTree(top.grammarName, top.compiledGrammars)).grammarFlowTypes;
  local myProds :: EnvTree<ProductionGraph> = head(searchEnvTree(top.grammarName, top.compiledGrammars)).productionFlowGraphs;
  local myFlowGraph :: ProductionGraph = 
    constructAnonymousGraph(e.flowDefs, top.env, myProds, myFlow);
  e.frame = globalExprContext(myFlowGraph);
  
  e.recVarEnv = recVarEnv;
  e.outerTotalRecVars = map(fst, filter(\ v::Pair<String Pair<Boolean String>> -> v.snd.fst, recVarEnv));
  e.outerAttr = just(pair(isTotal, a.name));
  
  local fwrd::AGDcl =
    foldr(
      appendAGDcl(_, _, location=top.location),
      defsAGDcl(
        [attrDef(
           defaultEnvItem(
             strategyDcl(
               top.grammarName, a.location, fName, isTotal, freshTyVar(),
               !null(top.errors), map(fst, e.liftedStrategies), recVarEnv, e.totalRefs, e)))],
        location=top.location),
      map(
        \ d::Pair<String Decorated StrategyExpr> ->
          strategyAttributeDcl(d.snd.isTotalInf, name(d.fst, top.location), d.snd.recVarEnv, new(d.snd), location=top.location),
        e.liftedStrategies));
   
  --forwards to unsafeTrace(fwrd, print(a.name ++ " = " ++ e.unparse ++ "; lifted  " ++ implode(",  ", map(fst, e.liftedStrategies)) ++ "\n\n", unsafeIO()));
  forwards to fwrd;
}

abstract production strategyAttributionDcl
top::AGDcl ::= at::Decorated QName attl::BracketedOptTypeExprs nt::QName nttl::BracketedOptTypeExprs
{
  production attribute localErrors::[Message] with ++;
  localErrors :=
    attl.errors ++ attl.errorsTyVars ++ nt.lookupType.errors ++ nttl.errors ++ nttl.errorsTyVars;
  localErrors <-
    if length(attl.types) > 0
    then [err(attl.location, "Explicit type arguments are not allowed for strategy attributes")]
    else [];
  
  -- Technically we could do this check on the propagate, but it seems clearer to raise it here
  localErrors <-
    flatMap(
      \ totalAttr::String ->
        if null(getOccursDcl(totalAttr, nt.lookupType.fullName, top.env))
        then [err(top.location, s"Total strategy attribute ${totalAttr} referenced by ${at.name} does not occur on ${nt.name}")]
        else [],
      at.lookupAttribute.dcl.totalRefs);
  
  -- TODO: Check that the type parameters of any rules of type nt match nttl
  
  top.errors := if !null(localErrors) then localErrors else forward.errors;

  forwards to
    foldr(
      appendAGDcl(_, _, location=top.location),
      defaultAttributionDcl(
        at,
        botlSome(
          '<',
          typeListSingle(
            nominalTypeExpr(nt.qNameType, nttl, location=top.location),
            location=top.location),
          '>', location=top.location),
        nt, nttl,
        location=top.location),
      map(
        \ n::String ->
          attributionDcl(
            'attribute', qName(top.location, n), attl, 'occurs', 'on', nt, nttl, ';',
            location=top.location),
        at.lookupAttribute.dcl.liftedStrategyNames));
}

{--
 - Propagate a strategy attribute on the enclosing production
 - @param attr  The name of the attribute to propagate
 -}
abstract production propagateStrategy
top::ProductionStmt ::= attr::Decorated QName
{
  top.unparse = s"propagate ${attr.unparse}";
  
  production isTotal::Boolean = attr.lookupAttribute.dcl.isTotal;
  production e::StrategyExpr = attr.lookupAttribute.dcl.strategyExpr;
  e.grammarName = top.grammarName;
  e.config = top.config;
  e.frame = top.frame;
  e.env = top.env;
  e.recVarEnv = attr.lookupAttribute.dcl.givenRecVarEnv;
  e.outerTotalRecVars = map(fst, filter(\ v::Pair<String Pair<Boolean String>> -> v.snd.fst, e.recVarEnv));
  e.outerAttr = just(pair(isTotal, attr.lookupAttribute.fullName));
  e.inlinedStrategies = [attr.lookupAttribute.fullName]; -- Don't unfold the top-level strategy within itself
  
  production e2::StrategyExpr = e.optimize;
  e2.grammarName = e.grammarName;
  e2.config = e.config;
  e2.frame = e.frame;
  e2.env = e.env;
  e2.recVarEnv = e.recVarEnv;
  e2.outerTotalRecVars = e.outerTotalRecVars;
  e2.outerAttr = e.outerAttr;
  e2.inlinedStrategies = e.inlinedStrategies;
  
  -- Can't do this with forwarding to avoid circular dependency of
  -- forward -> dcl.containsErrors -> dcl.flowEnv -> forward.flowDefs
  top.errors :=
    if
      attr.lookupAttribute.dcl.containsErrors ||
      -- Check for total strategy ref occurs errors that would already be reported on the occurence
      any(map(null, map(getOccursDcl(_, top.frame.signature.outputElement.typerep.typeName, top.env), attr.lookupAttribute.dcl.totalRefs))) 
    then []
    else forward.errors;
  
  local fwrd::ProductionStmt =
    foldr(
      productionStmtAppend(_, _, location=top.location),
      attributeDef(
        concreteDefLHS(qName(top.location, top.frame.signature.outputElement.elementName), location=top.location),
        '.',
        qNameAttrOccur(new(attr), location=top.location),
        '=',
        if isTotal then e2.totalTranslation else e2.partialTranslation,
        ';',
        location=top.location),
      map(
        \ n::String -> propagateOneAttr(qName(top.location, n), location=top.location),
        attr.lookupAttribute.dcl.liftedStrategyNames));
  
  --forwards to unsafeTrace(fwrd, print(attr.name ++ " on " ++ top.frame.fullName ++ " = " ++ (if isTotal then e2.totalTranslation else e2.partialTranslation).unparse ++ ";\n\n", unsafeIO()));
  forwards to fwrd;
}