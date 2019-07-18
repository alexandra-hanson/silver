abstract production otxDebugImpl
top::Expr ::= arg::Expr
{
  top.unparse = "<otxDebugImpl>";

  top.errors := arg.errors;

  top.typerep = arg.typerep;

  top.flowDefs = arg.flowDefs;
  top.flowDeps = arg.flowDeps;

  arg.downSubst = top.downSubst;
  top.upSubst = arg.upSubst;

  top.translation = s"((${finalType(arg).transType})common.Origins.debug(${arg.translation}))";

  top.lazyTranslation = wrapThunk(top.translation, top.frame.lazyApplication);
}