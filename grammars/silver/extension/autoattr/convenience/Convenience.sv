grammar silver:extension:autoattr:convenience;

import silver:extension:autoattr;
import silver:extension:convenience;
import silver:modification:collection;
import silver:definition:core;
import silver:definition:concrete_syntax;
import silver:definition:type:syntax;
import silver:definition:type;
import silver:definition:env;

concrete production functorAttributeDclMultiple
top::AGDcl ::= 'functor' 'attribute' a::Name 'occurs' 'on' qs::QNames ';'
{
  top.unparse = "functor attribute " ++ a.name ++ " occurs on " ++ qs.unparse ++ ";";
  forwards to
    appendAGDcl(
      functorAttributeDcl($1, $2, a, $7, location=a.location),
      makeOccursDclsHelp($1.location, qNameWithTL(qNameId(a, location=a.location), botlNone(location=top.location)), qs.qnames),
      location=top.location);
}

concrete production monoidAttributeDclMultiple
top::AGDcl ::= 'monoid' 'attribute' a::Name tl::BracketedOptTypeExprs '::' te::TypeExpr 'with' e::Expr ',' q::NameOrBOperator 'occurs' 'on' qs::QNames ';'
{
  top.unparse = "monoid attribute " ++ a.unparse ++ tl.unparse ++ " :: " ++ te.unparse ++ " with " ++ e.unparse ++ ", " ++ q.unparse ++ " occurs on " ++ qs.unparse ++ ";";
  forwards to
    appendAGDcl(
      monoidAttributeDcl($1, $2, a, tl, $5, te, $7, e, $9, q, $14, location=a.location),
      makeOccursDclsHelp($1.location, qNameWithTL(qNameId(a, location=a.location), botlNone(location=top.location)), qs.qnames),
      location=top.location);
}
