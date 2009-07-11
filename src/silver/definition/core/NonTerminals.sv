grammar silver:definition:core;
import silver:definition:env;

nonterminal Root with location, grammarName, impliedName, file, declaredName, moduleNames, importedDefs, exportedDefs, warnings, errors, compiledGrammars, env, globalImports, defs, pp, exportSelf, grammarExportSelf;

closed nonterminal Location with line, column, fileName, warnings, errors, env, defs, pp;

nonterminal QName with name, location, grammarName, file, warnings, errors, env, defs, pp;
nonterminal Name with name, location, grammarName, file, warnings, errors, env, defs, pp;
nonterminal NameTick with name, location, grammarName, file, warnings, errors, env, defs, pp;
nonterminal NameTickTick with name, location, grammarName, file, warnings, errors, env, defs, pp;
nonterminal AGDcls with location, grammarName, file, warnings, errors, env, defs, pp, moduleNames, compiledGrammars;
nonterminal AGDcl with location, grammarName, file, warnings, errors, env, defs, pp, moduleNames, compiledGrammars;
--nonterminal ProductionDcl with location, grammarName, file, name, fullName, inputElements, outputElement, warnings, errors, env, defs, pp;
nonterminal ProductionSignature with location, grammarName, file, inputElements, outputElement, warnings, errors, env, defs, pp;
nonterminal ProductionLHS with location, grammarName, file, outputElement, warnings, errors, env, defs, pp;
nonterminal ProductionRHS with location, grammarName, file, inputElements, warnings, errors, env, defs, pp;
nonterminal ProductionRHSElem with location, grammarName, file, inputElements, warnings, errors, env, defs, pp;
--nonterminal AspectDcl with location, grammarName, file, name, fullName, warnings, errors, env, defs, pp;
nonterminal FunctionSignature with location, grammarName, file, inputElements, outputElement, warnings, errors, env, defs, pp;
nonterminal FunctionLHS with location, grammarName, file, outputElement, warnings, errors, env, defs, pp;
nonterminal AspectProductionSignature with location, grammarName, file, inputElements, outputElement, warnings, errors, realSignature, env, defs, pp;
nonterminal AspectProductionLHS with location, grammarName, file, warnings, errors, outputElement, realSignature, env, defs, pp;
nonterminal AspectFunctionSignature with location, grammarName, file, inputElements, outputElement, warnings, errors, realSignature, env, defs, pp;
nonterminal AspectFunctionLHS with location, grammarName, file, warnings, errors, realSignature, outputElement, env, defs, pp;
nonterminal AspectRHS with location, grammarName, file, warnings, errors, inputElements, realSignature, env, defs, pp;
nonterminal AspectRHSElem with location, grammarName, file, warnings, errors, realSignature, inputElements, env, defs, pp;
nonterminal Expr with location, grammarName, file, warnings, errors, signature, expected, userFriendly, typerep, signatureEnv, localsEnv, env, defs, pp;
nonterminal Type with location, grammarName, file, warnings, errors, typerep, env, defs, pp;
--nonterminal ExportStmt with location, grammarName, file, warnings, errors, env, defs, pp;
nonterminal NameList with location, grammarName, file, names, warnings, errors, env, defs, pp;
nonterminal ExprInhs with location, grammarName, file, warnings, errors, signature, signatureEnv, localsEnv, env, defs, pp;
nonterminal ExprInh with location, grammarName, file, warnings, errors, signature, signatureEnv, localsEnv, env, defs, pp;
nonterminal ExprLHSExpr with location, grammarName, file, warnings, errors, typerep, signatureEnv, localsEnv, env, defs, pp;
nonterminal Exprs with location, grammarName, file, warnings, errors, signature, expectedInputTypes, exprs, signatureEnv, localsEnv, env, defs, pp;
nonterminal Module with errors, warnings, grammarName, compiledGrammars, defs;
nonterminal ImportStmt with location, grammarName, file, moduleNames, compiledGrammars, warnings, errors, importedDefs, defs, pp;
nonterminal ImportStmts with location, grammarName, file, moduleNames, compiledGrammars, warnings, errors, importedDefs, defs, pp;
nonterminal ModuleStmt with location, grammarName, file, moduleNames, importedDefs, exportedDefs, compiledGrammars, warnings, errors, pp, defs;
nonterminal ModuleStmts with location, grammarName, file, moduleNames, importedDefs, exportedDefs, compiledGrammars, warnings, errors, pp, exportSelf;
nonterminal ImportsStmt with location, grammarName, file, moduleNames, importedDefs, compiledGrammars, warnings, errors, pp;
nonterminal ExportsStmt with location, grammarName, file, moduleNames, exportedDefs, compiledGrammars, warnings, errors, pp, exportSelf;
nonterminal WithElems with location, grammarName, file, envMaps, warnings, errors, env, defs, pp;
nonterminal WithElem with location, grammarName, file, envMaps, warnings, errors, env, defs, pp;
nonterminal ProductionBody with location, grammarName, file, productionAttributes, warnings, errors, signature, signatureEnv, localsEnv, env, defs, pp;
nonterminal ProductionStmts with location, grammarName, file, productionAttributes, warnings, errors, signature, signatureEnv, localsEnv, env, defs, pp;
nonterminal ProductionStmt with location, grammarName, file, productionAttributes, warnings, errors, signature, signatureEnv, localsEnv, env, defs, pp;
nonterminal ReturnDef with location, grammarName, file, warnings, errors, signature, signatureEnv, localsEnv, env, defs, pp;
nonterminal AttributeDef with location, grammarName, file, warnings, errors, signature, signatureEnv, localsEnv, env, defs, pp;
nonterminal ProductionAttributeDcl with location, grammarName, file, warnings, errors, signature, signatureEnv, localsEnv, env, defs, pp;
nonterminal LocalAttributeDcl with location, grammarName, file, warnings, errors, signature, signatureEnv, localsEnv, env, defs, pp;
nonterminal ForwardsToDcl with location, grammarName, file, warnings, errors, signature, signatureEnv, localsEnv, env, defs, pp;
nonterminal ForwardingWithDcl with location, grammarName, file, warnings, errors, signature, signatureEnv, localsEnv, env, defs, pp;
nonterminal ForwardInhs with location, grammarName, file, warnings, errors, signature, signatureEnv, localsEnv, env, defs, pp;
nonterminal ForwardInh with location, grammarName, file, warnings, errors, signature, signatureEnv, localsEnv, env, defs, pp;
nonterminal ForwardLHSExpr with location, grammarName, file, warnings, errors, typerep, signatureEnv, localsEnv, env, defs, pp;
nonterminal LHSExpr with location, grammarName, file, warnings, errors, typerep, signature, signatureEnv, localsEnv, env, defs, pp;
nonterminal GrammarDcl with location, grammarName, declaredName, file, warnings, errors, env, defs, pp;
--nonterminal SyntaxStmt with location, grammarName, file, warnings, errors, env, defs, pp;
