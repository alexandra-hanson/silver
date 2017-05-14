grammar silver:definition:core;

nonterminal ProductionBody with
  config, grammarName, env, location, pp, errors, defs, frame, compiledGrammars,
  productionAttributes, uniqueSignificantExpression;
nonterminal ProductionStmts with 
  config, grammarName, env, location, pp, errors, defs, frame, compiledGrammars,
  productionAttributes, uniqueSignificantExpression;
nonterminal ProductionStmt with
  config, grammarName, env, location, pp, errors, defs, frame, compiledGrammars,
  productionAttributes, uniqueSignificantExpression;

nonterminal DefLHS with 
  config, grammarName, env, location, pp, errors, frame, compiledGrammars, typerep, defLHSattr;

nonterminal ForwardInhs with 
  config, grammarName, env, location, pp, errors, frame, compiledGrammars;
nonterminal ForwardInh with 
  config, grammarName, env, location, pp, errors, frame, compiledGrammars;
nonterminal ForwardLHSExpr with 
  config, grammarName, env, location, pp, errors, frame, typerep;

{--
 - Context for ProductionStmt blocks. (Indicates function, production, aspect, etc)
 - Includes singature for those contexts with a signature.
 -}
autocopy attribute frame :: BlockContext;

{--
 - Defs of attributes that should be wrapped up as production attributes.
 -}
synthesized attribute productionAttributes :: [Def];
{--
 - Either the 'forward' expression, or the 'return' expression.
 - I gave it an obtuse name so it could easily be renamed in the future.
 -}
synthesized attribute uniqueSignificantExpression :: [Decorated Expr];

{--
 - The attribute we're defining on a DefLHS.
 -}
inherited attribute defLHSattr :: Decorated QNameAttrOccur;


concrete production productionBody
top::ProductionBody ::= '{' stmts::ProductionStmts '}'
{
  top.pp = stmts.pp;

  top.productionAttributes = stmts.productionAttributes;
  top.uniqueSignificantExpression = stmts.uniqueSignificantExpression;

  top.defs = stmts.defs;
  top.errors := stmts.errors;
}

concrete production productionStmtsNil
top::ProductionStmts ::= 
{
  top.pp = "";

  top.productionAttributes = [];
  top.uniqueSignificantExpression = [];

  top.defs = [];
  top.errors := [];
}

concrete production productionStmtsSnoc
top::ProductionStmts ::= h::ProductionStmts t::ProductionStmt
{
  top.pp = h.pp ++ "\n" ++ t.pp;
  
  top.productionAttributes = h.productionAttributes ++ t.productionAttributes;
  top.uniqueSignificantExpression = h.uniqueSignificantExpression ++ t.uniqueSignificantExpression;

  top.defs = h.defs ++ t.defs;
  top.errors := h.errors ++ t.errors;
}

----------

abstract production productionStmtAppend
top::ProductionStmt ::= h::ProductionStmt t::ProductionStmt
{
  top.pp = h.pp ++ "\n" ++ t.pp;

  top.productionAttributes = h.productionAttributes ++ t.productionAttributes;
  top.uniqueSignificantExpression = h.uniqueSignificantExpression ++ t.uniqueSignificantExpression;

  top.defs = h.defs ++ t.defs;
  top.errors := h.errors ++ t.errors;
}

abstract production errorProductionStmt
top::ProductionStmt ::= e::[Message]
{
  top.pp = s"{- Errors:\n${foldMessages(e)} -}";
  top.errors := e;
  
  top.productionAttributes = [];
  top.uniqueSignificantExpression = [];
  top.defs = [];
}

--------------------------------------------------------------------------------

aspect default production
top::ProductionStmt ::=
{
  -- as is usual for defaults ("base classes")
  -- can't provide pp or location, errors should NOT be defined!
  top.productionAttributes = [];
  top.uniqueSignificantExpression = [];
  
  top.defs = [];
}

concrete production returnDef
top::ProductionStmt ::= 'return' e::Expr ';'
{
  top.pp = "\treturn " ++ e.pp ++ ";";
  
  top.uniqueSignificantExpression = [e];

  top.errors := e.errors;
  
  top.errors <- if !top.frame.permitReturn
                then [err(top.location, "Return is not valid in this context. (They are only permitted in function declarations.)")]
                else [];
}

concrete production localAttributeDcl
top::ProductionStmt ::= 'local' 'attribute' a::Name '::' te::Type ';'
{
  top.pp = "\tlocal attribute " ++ a.pp ++ "::" ++ te.pp ++ ";";

  production attribute fName :: String;
  fName = top.frame.fullName ++ ":local:" ++ a.name;

  top.defs = [localDef(top.grammarName, a.location, fName, te.typerep)];

  top.errors := te.errors;

  top.errors <-
        if length(getValueDclAll(fName, top.env)) > 1 
        then [err(a.location, "Value '" ++ fName ++ "' is already bound.")]
        else [];

  top.errors <- if !top.frame.permitLocalAttributes
                then [err(top.location, "Local attributes are not valid in this context.")]
                else [];
}

concrete production productionAttributeDcl
top::ProductionStmt ::= 'production' 'attribute' a::Name '::' te::Type ';'
{
  -- TODO: we should pp the production keyword, not local here!!
  --top.pp = "\tproduction attribute " ++ a.pp ++ "::" ++ te.pp ++ ";";

  top.productionAttributes = forward.defs;
  top.defs = [];

  top.errors <- if !top.frame.permitProductionAttributes
                then [err(top.location, "Production attributes are not valid in this context.")]
                else [];

  forwards to localAttributeDcl('local', $2, a, $4, te, $6, location=top.location);
}

concrete production forwardsTo
top::ProductionStmt ::= 'forwards' 'to' e::Expr ';'
{
  top.pp = "\tforwards to " ++ e.pp;

  top.productionAttributes = [forwardDef(top.grammarName, top.location, top.frame.signature.outputElement.typerep)];
  top.uniqueSignificantExpression = [e];

  top.errors := e.errors;

  top.errors <- if !top.frame.permitForward
                then [err(top.location, "Forwarding is not permitted in this context. (Only permitted in non-aspect productions.)")]
                else [];
}

concrete production forwardsToWith
top::ProductionStmt ::= 'forwards' 'to' e::Expr 'with' '{' inh::ForwardInhs '}' ';'
{
  top.pp = "\tforwards to " ++ e.pp ++ " with {" ++ inh.pp ++ "};";

  forwards to productionStmtAppend(
    forwardsTo($1, $2, $3, $8, location=top.location),
    forwardingWith('forwarding', $4, $5, inh, $7, $8, location=top.location),
    location=top.location);
}

concrete production forwardingWith
top::ProductionStmt ::= 'forwarding' 'with' '{' inh::ForwardInhs '}' ';'
{
  top.pp = "\tforwarding with {" ++ inh.pp ++ "};";

  production attribute fwdDcls :: [DclInfo];
  fwdDcls = getValueDcl("forward", top.env);

  top.errors := inh.errors;
  
  top.errors <- if null(fwdDcls)
                then [err(top.location, "'forwarding with' clause for a production that does not forward!")]
                else [];
}

-- TODO eliminate these (/ combine with the ones for decorate expression)
concrete production forwardInh
top::ForwardInh ::= lhs::ForwardLHSExpr '=' e::Expr ';'
{
  top.pp = lhs.pp ++ " = " ++ e.pp ++ ";";

  top.errors := lhs.errors ++ e.errors;
}

concrete production forwardInhsOne
top::ForwardInhs ::= lhs::ForwardInh
{
  top.pp = lhs.pp;
  top.errors := lhs.errors;
}

concrete production forwardInhsCons
top::ForwardInhs ::= lhs::ForwardInh rhs::ForwardInhs
{
  top.pp = lhs.pp ++ " " ++ rhs.pp;
  top.errors := lhs.errors ++ rhs.errors;
}

concrete production forwardLhsExpr
top::ForwardLHSExpr ::= q::QNameAttrOccur
{
  top.pp = q.pp;

  top.errors := q.errors;
  top.typerep = q.typerep;
  
  q.attrFor = top.frame.signature.outputElement.typerep;
}

concrete production attributeDef
top::ProductionStmt ::= dl::DefLHS '.' attr::QNameAttrOccur '=' e::Expr ';'
{
  top.pp = "\t" ++ dl.pp ++ "." ++ attr.pp ++ " = " ++ e.pp ++ ";";

  -- defs must stay here explicitly, because we dispatch on types in the forward here!
  top.productionAttributes = [];
  top.defs = [];
  
  dl.defLHSattr = attr;
  attr.attrFor = dl.typerep;
  
  local problems :: [Message] =
    if null(attr.errors) && attr.attrDcl.isAnnotation
    then [err(attr.location, attr.pp ++ " is an annotation, which are supplied to productions as arguments, not defined as equations.")]
    else dl.errors ++ attr.errors;

  forwards to
    if !null(problems)
    then errorAttributeDef(problems, dl, attr, e, location=top.location)
    else attr.attrDcl.attrDefDispatcher(dl, attr, e, top.location);
}

{- This is a helper that exist primarily to decorate 'e' and add its error messages to the list.
   Invariant: msg should not be null! -}
abstract production errorAttributeDef
top::ProductionStmt ::= msg::[Message] dl::Decorated DefLHS  attr::Decorated QNameAttrOccur  e::Expr
{
  top.pp = "\t" ++ dl.pp ++ "." ++ attr.pp ++ " = " ++ e.pp ++ ";";

  forwards to errorProductionStmt(msg ++ e.errors, location=top.location);
}

abstract production synthesizedAttributeDef
top::ProductionStmt ::= dl::Decorated DefLHS  attr::Decorated QNameAttrOccur  e::Expr
{
  top.pp = "\t" ++ dl.pp ++ "." ++ attr.pp ++ " = " ++ e.pp ++ ";";

  top.errors := e.errors;
}

abstract production inheritedAttributeDef
top::ProductionStmt ::= dl::Decorated DefLHS  attr::Decorated QNameAttrOccur  e::Expr
{
  top.pp = "\t" ++ dl.pp ++ "." ++ attr.pp ++ " = " ++ e.pp ++ ";";

  top.errors := e.errors;
}

concrete production concreteDefLHS
top::DefLHS ::= q::QName
{
  top.pp = q.pp;

  top.errors := q.lookupValue.errors ++ forward.errors;
  
  forwards to if null(q.lookupValue.dcls)
              then errorDefLHS(q, location=top.location)
              else q.lookupValue.dcl.defLHSDispatcher(q, top.location);
}

abstract production errorDefLHS
top::DefLHS ::= q::Decorated QName
{
  top.pp = q.pp;
  
  -- Warning: we get here two ways: one is q is lookup error. That errors at the
  -- dispatcher
  -- the other is q look up successfully and we need to error here
  -- TODO we error twice in that case!!
  top.errors := [err(q.location, "Cannot define attributes on " ++ q.pp)];
  top.typerep = q.lookupValue.typerep;
}

concrete production concreteDefLHSfwd
top::DefLHS ::= q::'forward'
{
  forwards to concreteDefLHS(qName(q.location, "forward"), location=top.location);
}

abstract production childDefLHS
top::DefLHS ::= q::Decorated QName
{
  top.pp = q.pp;
  
  top.errors := if !null(top.defLHSattr.errors) || top.defLHSattr.attrDcl.isInherited then []
                else [err(q.location, "Cannot define synthesized attribute '" ++ top.defLHSattr.pp ++ "' on child '" ++ q.pp ++ "'")];
                
  top.typerep = q.lookupValue.typerep;
}

abstract production lhsDefLHS
top::DefLHS ::= q::Decorated QName
{
  top.pp = q.pp;
  
  top.errors := if !null(top.defLHSattr.errors) || top.defLHSattr.attrDcl.isSynthesized then []
                else [err(q.location, "Cannot define inherited attribute '" ++ top.defLHSattr.pp ++ "' on the lhs '" ++ q.pp ++ "'")];

  top.typerep = q.lookupValue.typerep;
}

abstract production localDefLHS
top::DefLHS ::= q::Decorated QName
{
  top.pp = q.pp;
  
  top.errors := if !null(top.defLHSattr.errors) || top.defLHSattr.attrDcl.isInherited then []
                else [err(q.location, "Cannot define synthesized attribute '" ++ top.defLHSattr.pp ++ "' on local '" ++ q.pp ++ "'")];

  top.typerep = q.lookupValue.typerep;
}

abstract production forwardDefLHS
top::DefLHS ::= q::Decorated QName
{
  top.pp = q.pp;
  
  top.errors := if !null(top.defLHSattr.errors) || top.defLHSattr.attrDcl.isInherited then []
                else [err(q.location, "Cannot define synthesized attribute '" ++ top.defLHSattr.pp ++ "' on forward")];

  top.typerep = q.lookupValue.typerep;
}

----- done with DefLHS

concrete production valueEq
top::ProductionStmt ::= val::QName '=' e::Expr ';'
{
  top.pp = "\t" ++ val.pp ++ " = " ++ e.pp ++ ";";

  top.errors <- val.lookupValue.errors;

  -- defs must stay here explicitly, because we dispatch on types in the forward here!
  top.productionAttributes = [];
  top.defs = [];
  
  forwards to if null(val.lookupValue.dcls)
              then errorValueDef(val, e, location=top.location)
              else val.lookupValue.dcl.defDispatcher(val, e, top.location);
}

abstract production errorValueDef
top::ProductionStmt ::= val::Decorated QName  e::Expr
{
  top.pp = "\t" ++ val.pp ++ " = " ++ e.pp ++ ";";

  -- We get here two ways: the defDispatcher is us, or the lookup failed.
  -- TODO: this leads to duplicate error messages, when (a) the lookup fails and (b) we error here too
  top.errors := [err(val.location, val.pp ++ " cannot be assigned to.")] ++ e.errors;
}

abstract production localValueDef
top::ProductionStmt ::= val::Decorated QName  e::Expr
{
  top.pp = "\t" ++ val.pp ++ " = " ++ e.pp ++ ";";

  -- val is already valid here
  top.errors := e.errors;

  -- TODO: missing redefinition check
}

