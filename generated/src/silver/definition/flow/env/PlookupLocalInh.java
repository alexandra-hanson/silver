
package silver.definition.flow.env;

public final class PlookupLocalInh extends common.FunctionNode {

	public static final int i_prod = 0;
	public static final int i_fName = 1;
	public static final int i_attr = 2;
	public static final int i_e = 3;


	public static final Class<?> childTypes[] = { common.StringCatter.class,common.StringCatter.class,common.StringCatter.class,common.DecoratedNode.class };

	public static final int num_local_attrs = Init.count_local__ON__silver_definition_flow_env_lookupLocalInh;
	public static final String[] occurs_local = new String[num_local_attrs];

	public static final common.Lazy[][] childInheritedAttributes = new common.Lazy[4][];

	public static final common.Lazy[] localAttributes = new common.Lazy[num_local_attrs];
	public static final common.Lazy[][] localInheritedAttributes = new common.Lazy[num_local_attrs][];

	static{

	}

	public PlookupLocalInh(final Object c_prod, final Object c_fName, final Object c_attr, final Object c_e) {
		this.child_prod = c_prod;
		this.child_fName = c_fName;
		this.child_attr = c_attr;
		this.child_e = c_e;

	}

	private Object child_prod;
	public final common.StringCatter getChild_prod() {
		return (common.StringCatter) (child_prod = common.Util.demand(child_prod));
	}

	private Object child_fName;
	public final common.StringCatter getChild_fName() {
		return (common.StringCatter) (child_fName = common.Util.demand(child_fName));
	}

	private Object child_attr;
	public final common.StringCatter getChild_attr() {
		return (common.StringCatter) (child_attr = common.Util.demand(child_attr));
	}

	private Object child_e;
	public final common.DecoratedNode getChild_e() {
		return (common.DecoratedNode) (child_e = common.Util.demand(child_e));
	}



	@Override
	public Object getChild(final int index) {
		switch(index) {
			case i_prod: return getChild_prod();
			case i_fName: return getChild_fName();
			case i_attr: return getChild_attr();
			case i_e: return getChild_e();

			default: return null;
		}
	}

	@Override
	public Object getChildLazy(final int index) {
		switch(index) {
			case i_prod: return child_prod;
			case i_fName: return child_fName;
			case i_attr: return child_attr;
			case i_e: return child_e;

			default: return null;
		}
	}

	@Override
	public final int getNumberOfChildren() {
		return 4;
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
		return "silver:definition:flow:env:lookupLocalInh";
	}

	public static common.ConsCell invoke(final Object c_prod, final Object c_fName, final Object c_attr, final Object c_e) {
		try {
		final common.DecoratedNode context = new PlookupLocalInh(c_prod, c_fName, c_attr, c_e).decorate();
		//searchEnvTree(crossnames(prod, crossnames(fName, attr)), e.localInhTree)
		return (common.ConsCell)(((common.ConsCell)silver.definition.env.PsearchEnvTree.invoke(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((common.StringCatter)silver.definition.flow.ast.Pcrossnames.invoke(context.childAsIsLazy(silver.definition.flow.env.PlookupLocalInh.i_prod), new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((common.StringCatter)silver.definition.flow.ast.Pcrossnames.invoke(context.childAsIsLazy(silver.definition.flow.env.PlookupLocalInh.i_fName), context.childAsIsLazy(silver.definition.flow.env.PlookupLocalInh.i_attr))); } })); } }, new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((Object)((common.DecoratedNode)context.childAsIs(silver.definition.flow.env.PlookupLocalInh.i_e)).inherited(silver.definition.flow.env.Init.silver_definition_flow_env_localInhTree__ON__silver_definition_flow_env_FlowEnv)); } })));

		} catch(Throwable t) {
			throw new common.exceptions.TraceException("Error while evaluating function silver:definition:flow:env:lookupLocalInh", t);
		}
	}

	public static final common.NodeFactory<common.ConsCell> factory = new Factory();

	public static final class Factory extends common.NodeFactory<common.ConsCell> {
		@Override
		public common.ConsCell invoke(final Object[] children, final Object[] namedNotApplicable) {
			return PlookupLocalInh.invoke(children[0], children[1], children[2], children[3]);
		}
	};
}