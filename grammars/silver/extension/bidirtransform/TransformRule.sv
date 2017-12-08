grammar silver:extension:bidirtransform;

synthesized attribute transformRules :: [TransformRule];

nonterminal TransformRuleList with transformRules, env, errors, location, absGroup, cncGroup, pp, downSubst, upSubst, finalSubst, config;
nonterminal TransformRule with matchProd, namedSig, outputStmt, env, errors, location, absGroup, cncGroup, pp, downSubst, upSubst, finalSubst, config;

concrete production transformRuleCons
trl::TransformRuleList ::= Vbar_kwd l::TransformRule r::TransformRuleList
{
    l.config = trl.config;
    r.config = trl.config;

    l.env = trl.env;
    r.env = trl.env;

    l.downSubst = trl.downSubst;
    r.downSubst = l.upSubst;
    l.finalSubst = r.upSubst;
    r.finalSubst = l.finalSubst;

    trl.pp = "|" ++ l.pp ++ r.pp;

    trl.errors := l.errors ++ r.errors;
    trl.transformRules = [l] ++ r.transformRules;
    
    -- error check: is the exact transformation l found in r?
    -- equality checking is non trivial so we aren't doing this
    -- trl.errors <- if !contains(r.transformRules, l) then []
    --               else [err(trl.location, "Duplicate transformation rule definition")];
}

concrete production transformRuleSingle
trl::TransformRuleList ::= Vbar_kwd rule::TransformRule 
{
    rule.config = trl.config;
    rule.env = trl.env;
    rule.downSubst = trl.downSubst;
    trl.upSubst = rule.upSubst;
    rule.finalSubst = trl.upSubst;

    trl.pp = "|" ++ rule.pp;

    trl.errors := rule.errors;
    trl.transformRules = [rule];
}

concrete production transformRule
tr::TransformRule ::= l::ProductionDef '->' r::Expr
{
    l.config = tr.config;
    r.config = tr.config;
    l.env = tr.env;
    r.downSubst = tr.downSubst;
    tr.upSubst = r.upSubst;
    r.finalSubst = tr.upSubst;
    
    r.defaultInheritedAnnos = [];
    
    tr.pp = l.pp ++ "->" ++ r.pp;

    tr.namedSig = l.namedSig;
    tr.matchProd = l.matchProd;    
    tr.errors := l.errors; -- We ignore r.errors intentionally, it isn't a well-formed expression
    tr.outputStmt = (\ e::Expr ->
        case e of application(_,_,aexpr,_,_,_) ->
            -- need to pass in e here and supply all of e's inherited attributes
            -- aka this needs to be a production
            fillExprPattern(r, aexpr, l.patternList, location=e.location)
        end
    );

    -- Do the productions in both the lhs and rhs result in the same type?
    -- tr.errors <- if !check(l.typerep, r.typerep).typeerror then []
    --              else [err(tr.location, "Transformation rule type mismatch")];
}

    -- -- b: are there anonymous variables referred to in the rhs that are not defined in the lhs?
    -- --    (error rhs)
    -- local anonVarsMatch :: Boolean = containsAll(prd.definedAnonVars, trr.providedVars); 
    -- trr.errors <- if anonVarsMatch then [] 
    --               else err(trr.location, "Undefined anonymous variables in transformation rule")
    -- -- c: are there anonymous variables defined in the lhs that are not used in the rhs? 
    -- --    (message: replace these with _)
    -- --    (error rhs)
    -- trr.errors <- if containsAll(trr.providedVars, prd.definedAnonVars) then [] 
    --               else err(trr.location, "Unused anonymous variables in transformation rule")
    -- -- d: are anonymous variables taken from the lhs used as the same type in the rhs?
    -- --    (error rhs)
    -- trr.errors <- if !anonVarsMatch then []
    --               else if typesMatch(prd.definedAnonVars, trr.providedVars) then []
    --               else err(trr.location, "Type mismatch in transformation rule")

function hasTrans
Boolean ::= rules::[TransformRule] dcl::[Decorated NamedSignature] 
            absGroup::Decorated NonterminalList cncGroup::Decorated NonterminalList
{
    local hd::TransformRule = head(rules);

    hd.absGroup = absGroup;
    hd.cncGroup = cncGroup;

    return if null(rules) || null(dcl) then false
        else if head(dcl).fullName == hd.namedSig.fullName then true
        else hasTrans(tail(rules), dcl, absGroup, cncGroup);
}

abstract production getTrans
top::TransformRule ::= rules::[TransformRule] dcl::[Decorated NamedSignature]
{
    forwards to --if null(rules) then nothing()
        --else if null(dcl) then nothing() else
        if head(dcl).fullName == head(rules).namedSig.fullName 
            then head(rules)
            else getTrans(tail(rules), dcl, location=top.location);
}