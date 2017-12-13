grammar silver:extension:bidirtransform;


-- -- copy attributes from origin's RHS elements to their LHS for all RHS that can. 
-- -- example usage: pp. 
concrete production originAttributeDcl
top::AGDcl ::= 'origins' 'attribute' qns::QNameList ';'
{
    top.moduleNames = [];
    top.mdaSpecs = [];

    forwards to originAttributes(qns.qList, location=top.location);
}

abstract production originAttributes
top::AGDcl ::= qns::[QName]
{
    default annotation location = top.location;

    forwards to if null(qns) then emptyAGDcl()
      else appendAGDcl(originAttribute(head(qns)), originAttributes(tail(qns)));
}

abstract production originAttribute
top::AGDcl ::= qn::QName
{      
    default annotation location = top.location;

    forwards to appendAGDcl(
        attrOn(qn.name, ["Origin"]),
        -- find all origin productions and give them this attribute if it's defined on their RHS
        originAttrDef(qn));
        
}

abstract production originAttrDef
top::AGDcl ::= qn::QName oProds::[Decorated NamedSignature]
{
    top.defs = [];
    
    forwards to foldl(\ agDcls::AGDcl ns::Decorated NamedSignature ->
        appendAGDcl(
                if null(ns.inputTypes) then emptyAGDcl()
                else if hasNamedAttr(head(ns.inputTypes).typeName, top.env, qn.name)
                then aspectProdStmt(ns,\ ns::Decorated NamedSignature ->
                        attribDef(ns.outputElement.elementName, qn.name, 
                            exprAccess(qn.name, head(ns.inputNames))))
                else emptyAGDcl(),
            agDcls),
        emptyAGDcl(), filterSigs("Origin", prodsFromDefs(top.env.allDefs))));
}

-- todo: this should act like the above, but defines a Maybe<T>, new attribute
-- instead of the existing attribute, so the presence of the attribute can be checked.
concrete production optOriginAttributeDcl
top::AGDcl ::= 'optional' 'origins' 'attribute' qns::QNameList ';'
{
    default annotation location = top.location;    

    forwards to appendAGDcl(writeOptAttributes(qns, ""), optOriginAttributes(qns, ""));
}

concrete production optOriginAttributeDclPrefix
top::AGDcl ::= 'optional' 'origins' 'attribute' qns::QNameList 'with' 'prefix' pfix::QName ';'
{
    default annotation location = top.location;
    
    forwards to appendAGDcl(writeOptAttributes(qns, pfix.name), optOriginAttributes(qns, pfix.name));
}


abstract production writeOptAttributes
top::AGDcl ::= qns::QNameList pfix::String 
{
    local prefixedNames::[String] = map(\ qn::QName -> 
        pfix ++ qn.name, 
        qns.qList);

    local tyExprs::[TypeExpr] = map(\ qn::QName ->
        mkMaybeTypeExpr(head(getAttrDcl(qn.name, top.env)).typerep.typeName),
        qns.qList);

    top.errors <- foldl(\ errs::[Message] qn::QName ->
        if null(getAttrDcl(qn.name, top.env)) 
        then [err(qn.location, "Unknown attribute " ++ qn.name)] ++ errs
        else errs,
        [], qns.qList);

    default annotation location = top.location;

    forwards to foldl(\ agDcls::AGDcl attr::Pair<String TypeExpr> ->
        appendAGDcl(synAttr(attr.fst, attr.snd), agDcls),
        emptyAGDcl(), zipWith(pair, prefixedNames, tyExprs));
}

abstract production optOriginAttributes
top::AGDcl ::= qns::QNameList pfix::String
{
    local qnsTail::QNameList = case qns of qNameListCons(_,_,tl) -> tl end;

    default annotation location = top.location;

    forwards to if null(qns.qList) then emptyAGDcl()
      else appendAGDcl(optOriginAttribute(head(qns.qList), pfix), optOriginAttributes(qnsTail, pfix));
}

abstract production optOriginAttribute
top::AGDcl ::= qn::QName pfix::String
{      
    local oProds::[Decorated NamedSignature] = 
      prodsFromDcls(getProdsFromNtHack("Origin", top.env, "transformed"));

    local lhsAttr::String = pfix ++ qn.name;

    default annotation location = top.location;

    forwards to appendAGDcl(
        attrOn(qn.name, ["Origin"]),
        -- find all origin productions and give them just(this attribute) if it's defined on their RHS,
        -- otherwise nothing().
        foldl(\ agDcls::AGDcl ns::Decorated NamedSignature ->
            appendAGDcl(
                    if null(ns.inputTypes) then emptyAGDcl()
                    else if hasNamedAttr(head(ns.inputTypes).typeName, top.env, qn.name)
                    then aspectProdStmt(ns,\ ns::Decorated NamedSignature ->
                            attribDef(ns.outputElement.elementName, lhsAttr, 
                                oneArgFunc("just", namedAccess(qn.name, head(ns.inputNames)))))
                    else aspectProdStmt(ns,\ ns::Decorated NamedSignature ->
                            attribDef(ns.outputElement.elementName, lhsAttr, emptyFunc("nothing"))),
                agDcls),
          emptyAGDcl(), oProds));
}