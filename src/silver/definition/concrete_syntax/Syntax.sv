--grammar silver:definition:concrete_syntax;
import silver:definition:core;

--concrete production syntaxStmtsOne 
--top::ModuleStmts ::= syn::SyntaxStmt
--{
--  top.pp = syn.pp;
--  top.location = syn.location;
--}
--
--concrete production syntaxStmtsCons
--top::ModuleStmts ::= h::SyntaxStmt t::ModuleStmts
--{
--  top.pp = h.pp ++ "\n" ++ t.pp;
--  top.location = h.location;
--}
--
--concrete production syntaxAll
--top::SyntaxStmt ::= 'syntax' pkg::QName ';'
--{
--  top.pp = "syntax " ++ pkg.pp ++ ";";
--  top.location = loc(top.file, $1.line, $1.column);
--}
--
--concrete production syntaxHiding
--top::SyntaxStmt ::= 'syntax' pkg::QName 'hiding' ns::NameList ';'
--{
--  top.pp = "syntax " ++ pkg.pp ++ " hiding " ++ ns.pp ++ ";";
--  top.location = loc(top.file, $1.line, $1.column);
--}
--