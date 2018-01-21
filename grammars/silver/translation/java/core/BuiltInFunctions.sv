grammar silver:translation:java:core;

aspect production errorLength
top::Expr ::= e::Decorated Expr
{
  top.translation = error("Internal compiler error: translation not defined in the presence of errors");
  top.lazyTranslation = top.translation;
}

aspect production stringLength
top::Expr ::= e::Decorated Expr
{
  top.translation = s"Integer.valueOf(((common.StringCatter)${e.translation}).length())";

  top.lazyTranslation = wrapThunk(top.translation, top.frame.lazyApplication);
}

aspect production toIntFunction
top::Expr ::= 'toInt' '(' e::Expr ')'
{
  top.translation = case finalType(e) of
                    | intType() -> e.translation
                    | floatType() -> s"Integer.valueOf(((Float)${e.translation}).intValue())"
                    | stringType() -> s"Integer.valueOf(${e.translation}.toString())"
                    | t -> error("INTERNAL ERROR: no toInt translation for type " ++ prettyType(t))
                    end;

  top.lazyTranslation = wrapThunk(top.translation, top.frame.lazyApplication);
}
aspect production toFloatFunction
top::Expr ::= 'toFloat' '(' e::Expr ')'
{
  top.translation = case finalType(e) of
                    | intType() -> s"Float.valueOf(((Integer)${e.translation}).floatValue())"
                    | floatType() -> e.translation
                    | stringType() -> s"Float.valueOf(${e.translation}.toString())"
                    | t -> error("INTERNAL ERROR: no toFloat translation for type " ++ prettyType(t))
                    end;

  top.lazyTranslation = wrapThunk(top.translation, top.frame.lazyApplication);
}
aspect production toStringFunction
top::Expr ::= 'toString' '(' e::Expr ')'
{
  top.translation = s"new common.StringCatter(String.valueOf(${e.translation}))";

  top.lazyTranslation = wrapThunk(top.translation, top.frame.lazyApplication);
}

aspect production reifyFunctionLiteral
top::Expr ::= 'reify'
{
  local resultType::Type =
    case finalType(top).outputType of
      nonterminalType("core:Either", [stringType(), a]) -> a
    | _ -> error("Unexpected final type for reify!")
    end;
  
  top.translation =
s"""(new common.NodeFactory<core.NEither>() {
	@Override
	public final core.NEither invoke(final Object[] args, final Object[] namedArgs) {
		assert args.length == 1;
		assert namedArgs.length == 0;
		
		${makeTyVarDecls(resultType.freeVariables)}
		common.TypeRep resultType = ${resultType.transTypeRep};
		
		return common.Reflection.reifyChecked(resultType, (core.reflect.NAST)common.Util.demand(args[0]));
	}
	
	@Override
	public final common.FunctionTypeRep getType() {
		${makeTyVarDecls(finalType(top).freeVariables)}
		return ${finalType(top).transTypeRep};
	}
})""";
  
  top.lazyTranslation = top.translation;
}

aspect production newFunction
top::Expr ::= 'new' '(' e::Expr ')'
{
  top.translation = s"((${finalType(top).transType})${e.translation}.undecorate())";
  
  top.lazyTranslation = wrapThunk(top.translation, top.frame.lazyApplication);
}

aspect production terminalConstructor
top::Expr ::= 'terminal' '(' t::TypeExpr ',' es::Expr ',' el::Expr ')'
{
  top.translation = s"new ${makeTerminalName(t.typerep.typeName)}(${es.translation}, (core.NLocation)${el.translation})";

  top.lazyTranslation = wrapThunk(top.translation, top.frame.lazyApplication);
}
