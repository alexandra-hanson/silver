
package silver.extension.bidirtransform;

public final class PskipToNextLock extends common.FunctionNode {

	public static final int i_fnnt = 0;
	public static final int i_dfs = 1;
	public static final int i_skipGrammar = 2;


	public static final Class<?> childTypes[] = { common.StringCatter.class,silver.definition.env.NDefs.class,common.StringCatter.class };

	public static final int num_local_attrs = Init.count_local__ON__silver_extension_bidirtransform_skipToNextLock;
	public static final String[] occurs_local = new String[num_local_attrs];

	public static final common.Lazy[][] childInheritedAttributes = new common.Lazy[3][];

	public static final common.Lazy[] localAttributes = new common.Lazy[num_local_attrs];
	public static final common.Lazy[][] localInheritedAttributes = new common.Lazy[num_local_attrs][];

	static{
	childInheritedAttributes[i_dfs] = new common.Lazy[silver.definition.env.NDefs.num_inh_attrs];

	}

	public PskipToNextLock(final Object c_fnnt, final Object c_dfs, final Object c_skipGrammar) {
		this.child_fnnt = c_fnnt;
		this.child_dfs = c_dfs;
		this.child_skipGrammar = c_skipGrammar;

	}

	private Object child_fnnt;
	public final common.StringCatter getChild_fnnt() {
		return (common.StringCatter) (child_fnnt = common.Util.demand(child_fnnt));
	}

	private Object child_dfs;
	public final silver.definition.env.NDefs getChild_dfs() {
		return (silver.definition.env.NDefs) (child_dfs = common.Util.demand(child_dfs));
	}

	private Object child_skipGrammar;
	public final common.StringCatter getChild_skipGrammar() {
		return (common.StringCatter) (child_skipGrammar = common.Util.demand(child_skipGrammar));
	}



	@Override
	public Object getChild(final int index) {
		switch(index) {
			case i_fnnt: return getChild_fnnt();
			case i_dfs: return getChild_dfs();
			case i_skipGrammar: return getChild_skipGrammar();

			default: return null;
		}
	}

	@Override
	public Object getChildLazy(final int index) {
		switch(index) {
			case i_fnnt: return child_fnnt;
			case i_dfs: return child_dfs;
			case i_skipGrammar: return child_skipGrammar;

			default: return null;
		}
	}

	@Override
	public final int getNumberOfChildren() {
		return 3;
	}

	@Override
	public common.Lazy[] getLocalInheritedAttributes(final int key) {
		return localInheritedAttributes[key];
	}

	@Override
	public common.Lazy[] getChildInheritedAttributes(final int key) {
		return childInheritedAttributes[key];
	}

	@Override
	public common.Lazy getLocal(final int key) {
		return localAttributes[key];
	}

	@Override
	public final int getNumberOfLocalAttrs() {
		return num_local_attrs;
	}

	@Override
	public final String getNameOfLocalAttr(final int index) {
		return occurs_local[index];
	}

	@Override
	public String getName() {
		return "silver:extension:bidirtransform:skipToNextLock";
	}

	public static common.ConsCell invoke(final Object c_fnnt, final Object c_dfs, final Object c_skipGrammar) {
		try {
		final common.DecoratedNode context = new PskipToNextLock(c_fnnt, c_dfs, c_skipGrammar).decorate();
		//case dfs of nilDefs() -> [] | consDefs(d, dfs2) -> if d.isLock then getProdsFromDefs(fnnt, dfs2, skipGrammar) else skipToNextLock(fnnt, dfs2, skipGrammar) end
		return (common.ConsCell)(new common.PatternLazy<common.DecoratedNode, common.ConsCell>() { public final common.ConsCell eval(final common.DecoratedNode context, common.DecoratedNode scrutineeIter) {while(true) {final common.DecoratedNode scrutinee = scrutineeIter; final common.Node scrutineeNode = scrutinee.undecorate(); if(scrutineeNode instanceof silver.definition.env.PconsDefs) { final common.Thunk<Object> __SV_LOCAL___pv13682___sv_pv_13683_d = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return (common.DecoratedNode)scrutinee.childDecorated(0); } };
final common.Thunk<Object> __SV_LOCAL___pv13684___sv_pv_13681_dfs2 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return (common.DecoratedNode)scrutinee.childDecorated(1); } };
 return (common.ConsCell)((common.ConsCell)(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { final common.Thunk<Object> __SV_LOCAL_13685_dfs2 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((common.DecoratedNode)(__SV_LOCAL___pv13684___sv_pv_13681_dfs2.eval())); } };
return ((common.ConsCell)(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { final common.Thunk<Object> __SV_LOCAL_13686_d = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((common.DecoratedNode)(__SV_LOCAL___pv13682___sv_pv_13683_d.eval())); } };
return (((Boolean)((common.DecoratedNode)(__SV_LOCAL_13686_d.eval())).synthesized(silver.extension.bidirtransform.Init.silver_extension_bidirtransform_isLock__ON__silver_definition_env_Def)) ? ((common.ConsCell)silver.extension.bidirtransform.PgetProdsFromDefs.invoke(context.childAsIsLazy(silver.extension.bidirtransform.PskipToNextLock.i_fnnt), common.Thunk.transformUndecorate(__SV_LOCAL_13685_dfs2), context.childAsIsLazy(silver.extension.bidirtransform.PskipToNextLock.i_skipGrammar))) : ((common.ConsCell)silver.extension.bidirtransform.PskipToNextLock.invoke(context.childAsIsLazy(silver.extension.bidirtransform.PskipToNextLock.i_fnnt), common.Thunk.transformUndecorate(__SV_LOCAL_13685_dfs2), context.childAsIsLazy(silver.extension.bidirtransform.PskipToNextLock.i_skipGrammar)))); } }).eval()); } }).eval()); }
else if(scrutineeNode instanceof silver.definition.env.PnilDefs) {  return (common.ConsCell)((common.ConsCell)core.Pnil.invoke()); }if(!scrutineeIter.undecorate().hasForward()) break;scrutineeIter = scrutineeIter.forward();}return ((common.ConsCell)core.Perror.invoke((new common.StringCatter("Error: pattern match failed at silver:extension:bidirtransform 'HelpLookup.sv', 116, 11, 122, 7, 3763, 3982\n"))));}}.eval(context, (common.DecoratedNode)context.childDecorated(silver.extension.bidirtransform.PskipToNextLock.i_dfs)));

		} catch(Throwable t) {
			throw new common.exceptions.TraceException("Error while evaluating function silver:extension:bidirtransform:skipToNextLock", t);
		}
	}

	public static final common.NodeFactory<common.ConsCell> factory = new Factory();

	public static final class Factory extends common.NodeFactory<common.ConsCell> {
		@Override
		public common.ConsCell invoke(final Object[] children, final Object[] namedNotApplicable) {
			return PskipToNextLock.invoke(children[0], children[1], children[2]);
		}
	};
}