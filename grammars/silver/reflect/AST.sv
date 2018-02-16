grammar silver:reflect;

exports core:reflect;

imports silver:langutil;
imports silver:langutil:pp;

attribute unparse occurs on AST;

aspect production nonterminalAST
top::AST ::= prodName::String children::ASTs annotations::NamedASTs
{
  top.unparse = s"${prodName}(${implode(", ", children.unparses ++ annotations.unparses)})";
}

aspect production listAST
top::AST ::= vals::ASTs
{
  top.unparse = s"[${implode(", ", vals.unparses)}]";
}

aspect production stringAST
top::AST ::= s::String
{
  -- TODO: Handle escaping properly
  top.unparse = s"\"${s}\"";
}

aspect production integerAST
top::AST ::= i::Integer
{
  top.unparse = toString(i);
}

aspect production floatAST
top::AST ::= f::Float
{
  top.unparse = toString(f);
}

aspect production booleanAST
top::AST ::= b::Boolean
{
  top.unparse = toString(b);
}

aspect production anyAST
top::AST ::= x::a
{
  top.unparse = error("Can't unparse anyAST");
}

synthesized attribute unparses::[String];

attribute unparses occurs on ASTs;

aspect production consAST
top::ASTs ::= h::AST t::ASTs
{
  top.unparses = h.unparse :: t.unparses;
}

aspect production nilAST
top::ASTs ::=
{
  top.unparses = [];
}

attribute unparses occurs on NamedASTs;

aspect production consNamedAST
top::NamedASTs ::= h::NamedAST t::NamedASTs
{
  top.unparses = h.unparse :: t.unparses;
}

aspect production nilNamedAST
top::NamedASTs ::=
{
  top.unparses = [];
}

attribute unparse occurs on NamedAST;

aspect production namedAST
top::NamedAST ::= n::String v::AST
{
  top.unparse = s"${n}=${v.unparse}";
}