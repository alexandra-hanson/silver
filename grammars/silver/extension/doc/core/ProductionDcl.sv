grammar silver:extension:doc:core;

import silver:util;
import silver:definition:concrete_syntax;

aspect production productionDcl
top::AGDcl ::= 'abstract' 'production' id::Name ns::ProductionSignature body::ProductionBody
{
  top.docs := [toNoCommentMarkdown("abstract production", id.name, ns.pp)];
}

concrete production docProductionDecl
top::AGDcl ::= comment::DocComment 'abstract' 'production' id::Name ns::ProductionSignature body::ProductionBody
{
  top.docs := [toMarkdown("abstract production", id.name, ns.pp, comment)];
  forwards to productionDcl('abstract', 'production', id, ns, body, location=top.location);
}

concrete production noDocProductionDecl
top::AGDcl ::= noDoc::NoDocComment_t 'abstract' 'production' id::Name ns::ProductionSignature body::ProductionBody
{
  top.docs := [];
  forwards to productionDcl('abstract', 'production', id, ns, body, location=top.location);
}

aspect production concreteProductionDcl
top::AGDcl ::= 'concrete' 'production' id::Name ns::ProductionSignature pm::ProductionModifiers body::ProductionBody
{
  top.docs := [toNoCommentMarkdown("concrete production", id.name, ns.pp)];
}

concrete production docConcreteProductionDcl
top::AGDcl ::= comment::DocComment 'concrete' 'production' id::Name ns::ProductionSignature pm::ProductionModifiers body::ProductionBody
{
  top.docs := [toMarkdown("concrete production", id.name, ns.pp, comment)];
  forwards to concreteProductionDcl('concrete', 'production', id, ns, pm, body, location=top.location);
}

concrete production noDocConcreteProductionDcl
top::AGDcl ::= noDoc::NoDocComment_t 'concrete' 'production' id::Name ns::ProductionSignature pm::ProductionModifiers body::ProductionBody
{
  top.docs := [];
  forwards to concreteProductionDcl('concrete', 'production', id, ns, pm, body, location=top.location);
}

