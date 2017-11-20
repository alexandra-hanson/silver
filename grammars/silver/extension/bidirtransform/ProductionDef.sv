grammar silver:extension:bidirtransform;

nonterminal ProductionDef with env, errors, namedSig, patternList, matchProd, typerep, inputNames, location, absGroup, cncGroup, pp, grammarName, config;

synthesized attribute patternList::PatternList;
synthesized attribute matchProd::Expr;
synthesized attribute namedSig::Decorated NamedSignature;

autocopy attribute absGroup::NonterminalList;
autocopy attribute cncGroup::NonterminalList;

concrete production productionDef
pd::ProductionDef ::= qn::QName '(' args::PatternList ')'
{
    pd.errors := args.errors;
    
    pd.pp = qn.pp ++ "(" ++ args.pp ++ ")";

    args.config = pd.config;
    args.env = pd.env;
    
    local absSig::[Decorated NamedSignature] = getProdFromGroup(qn.name, pd.absGroup);
    local cncSig::[Decorated NamedSignature] = getProdFromGroup(qn.name, pd.cncGroup);

    pd.namedSig = if length(absSig) != 0 then head(absSig)
        else head(cncSig);
        
    pd.matchProd = matchProd(args.rawPatternList, pd.namedSig.inputElements, location=pd.location);
    pd.typerep = pd.namedSig.outputElement.typerep;

    -- When we looked up a production, was exactly one production found?
    pd.errors <- if length(absSig) != 0 || length(cncSig) != 0 then []
                 else [err(pd.location, "Unknown Production " ++ qn.name)];
    
    -- Is the pattern as long as the production's expected input arguments?
    pd.errors <- if length(absSig) == 0 && length(cncSig) == 0 then []
        else if length(pd.namedSig.inputElements) != length(args.rawPatternList) 
        then [err(pd.location, "Transformation Production does not match size with Production Signature")]
        else [];

    -- Are variables in pattern the appropriate type for where they are used?
    pd.errors <- tyCheckProd(pd.location, args.rawPatternList, pd.namedSig.inputElements);

    -- Are there any duplicate anonymous variable names defined?
    -- TODO
}

abstract production matchProd
top::Expr ::= args::[Pattern] nsElems::[NamedSignatureElement]
{
    forwards to if length(args) == 1 
        then matchSingle(head(args), head(nsElems), mkTrue(location=top.location), location=top.location) 
        else matchSingle(head(args), head(nsElems), matchProd(tail(args), tail(nsElems), location=top.location), location=top.location);
}
                     
abstract production matchSingle
top::Expr ::= arg::Pattern nsElem::NamedSignatureElement ifTrue::Expr
{   
    -- This is unreadable so long as we don't have default annotations
    forwards to case arg of 
        | wildcPattern(_) -> ifTrue
        | _ -> caseExpr_c('case', exprsSingle(baseName(nsElem.elementName, location=top.location), location=top.location),
            'of', terminal(Opt_Vbar_t, "|"), mRuleList_cons(matchRule_c(patternList_one(arg, location=top.location),
                '->', ifTrue, location=top.location),
                    terminal(Vbar_kwd, "|"), mRuleList_one(matchRule_c(patternList_one(wildcPattern('_',location=top.location),
                        location=top.location),
                    '->',mkFalse(location=top.location),location=top.location),location=top.location),location=top.location),
            'end', location=top.location)
    end;
}        

function tyCheckProd
[Message] ::= loc::Location args::[Pattern] nsElems::[NamedSignatureElement]
{
    -- TODO
    return [];
}