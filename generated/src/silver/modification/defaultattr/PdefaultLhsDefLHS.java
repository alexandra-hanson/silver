
package silver.modification.defaultattr;

// top::DefLHS ::= q::Decorated QName 
public final class PdefaultLhsDefLHS extends silver.definition.core.NDefLHS {

	public static final int i_q = 0;


	public static final Class<?> childTypes[] = {common.DecoratedNode.class};

	public static final int num_local_attrs = Init.count_local__ON__silver_modification_defaultattr_defaultLhsDefLHS;
	public static final String[] occurs_local = new String[num_local_attrs];

	public static final common.Lazy[] forwardInheritedAttributes = new common.Lazy[silver.definition.core.NDefLHS.num_inh_attrs];

	public static final common.Lazy[] synthesizedAttributes = new common.Lazy[silver.definition.core.NDefLHS.num_syn_attrs];
	public static final common.Lazy[][] childInheritedAttributes = new common.Lazy[1][];

	public static final common.Lazy[] localAttributes = new common.Lazy[num_local_attrs];
	public static final common.Lazy[][] localInheritedAttributes = new common.Lazy[num_local_attrs][];

	static {

	}

	public PdefaultLhsDefLHS(final Object c_q, final Object a_core_location) {
		super(a_core_location);
		this.child_q = c_q;

	}

	private Object child_q;
	public final common.DecoratedNode getChild_q() {
		return (common.DecoratedNode) (child_q = common.Util.demand(child_q));
	}



	@Override
	public Object getChild(final int index) {
		switch(index) {
			case i_q: return getChild_q();

			default: return null;
		}
	}

	@Override
	public Object getChildLazy(final int index) {
		switch(index) {
			case i_q: return child_q;

			default: return null;
		}
	}

	@Override
	public final int getNumberOfChildren() {
		return 1;
	}

	@Override
	public common.Lazy getSynthesized(final int index) {
		return synthesizedAttributes[index];
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
	public boolean hasForward() {
		return false;
	}

	@Override
	public common.Node evalForward(final common.DecoratedNode context) {
		throw new common.exceptions.SilverInternalError("Production silver:modification:defaultattr:defaultLhsDefLHS erroneously claimed to forward");
	}

	@Override
	public common.Lazy getForwardInheritedAttributes(final int index) {
		return forwardInheritedAttributes[index];
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
		return "silver:modification:defaultattr:defaultLhsDefLHS";
	}

	static void initProductionAttributeDefinitions() {
		// top.pp = q.pp
		silver.modification.defaultattr.PdefaultLhsDefLHS.synthesizedAttributes[silver.definition.core.Init.silver_definition_env_pp__ON__silver_definition_core_DefLHS] = new common.Lazy() { public final Object eval(final common.DecoratedNode context) { return ((common.StringCatter)((common.DecoratedNode)context.childAsIs(silver.modification.defaultattr.PdefaultLhsDefLHS.i_q)).synthesized(silver.definition.core.Init.silver_definition_env_pp__ON__silver_definition_core_QName)); } };
		// top.errors := if ! null(top.defLHSattr.errors) || top.defLHSattr.attrDcl.isSynthesized then [] else [ err(q.location, "Cannot define inherited attribute '" ++ top.defLHSattr.pp ++ "' on the lhs '" ++ q.pp ++ "'") ]
		if(silver.modification.defaultattr.PdefaultLhsDefLHS.synthesizedAttributes[silver.definition.core.Init.silver_definition_core_errors__ON__silver_definition_core_DefLHS] == null)
			silver.modification.defaultattr.PdefaultLhsDefLHS.synthesizedAttributes[silver.definition.core.Init.silver_definition_core_errors__ON__silver_definition_core_DefLHS] = new silver.definition.core.CAerrors(silver.definition.core.Init.silver_definition_core_errors__ON__silver_definition_core_DefLHS);
		((common.CollectionAttribute)silver.modification.defaultattr.PdefaultLhsDefLHS.synthesizedAttributes[silver.definition.core.Init.silver_definition_core_errors__ON__silver_definition_core_DefLHS]).setBase(new common.Lazy() { public final Object eval(final common.DecoratedNode context) { return (((!((Boolean)core.Pnull.invoke(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((common.ConsCell)((common.DecoratedNode)context.inherited(silver.definition.core.Init.silver_definition_core_defLHSattr__ON__silver_definition_core_DefLHS)).synthesized(silver.definition.core.Init.silver_definition_core_errors__ON__silver_definition_core_QNameAttrOccur)); } }))) || ((Boolean)((silver.definition.env.NDclInfo)((common.DecoratedNode)context.inherited(silver.definition.core.Init.silver_definition_core_defLHSattr__ON__silver_definition_core_DefLHS)).synthesized(silver.definition.core.Init.silver_definition_core_attrDcl__ON__silver_definition_core_QNameAttrOccur)).decorate(context, (common.Lazy[])null).synthesized(silver.definition.env.Init.silver_definition_env_isSynthesized__ON__silver_definition_env_DclInfo))) ? ((common.ConsCell)core.Pnil.invoke()) : ((common.ConsCell)core.Pcons.invoke(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((silver.definition.core.NMessage)new silver.definition.core.Perr(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((core.NLocation)((silver.definition.core.NQName)((common.DecoratedNode)context.childAsIs(silver.modification.defaultattr.PdefaultLhsDefLHS.i_q)).undecorate()).getAnno_core_location()); } }, new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return new common.StringCatter((common.StringCatter)(new common.StringCatter("Cannot define inherited attribute '")), (common.StringCatter)new common.StringCatter((common.StringCatter)((common.StringCatter)((common.DecoratedNode)context.inherited(silver.definition.core.Init.silver_definition_core_defLHSattr__ON__silver_definition_core_DefLHS)).synthesized(silver.definition.core.Init.silver_definition_env_pp__ON__silver_definition_core_QNameAttrOccur)), (common.StringCatter)new common.StringCatter((common.StringCatter)(new common.StringCatter("' on the lhs '")), (common.StringCatter)new common.StringCatter((common.StringCatter)((common.StringCatter)((common.DecoratedNode)context.childAsIs(silver.modification.defaultattr.PdefaultLhsDefLHS.i_q)).synthesized(silver.definition.core.Init.silver_definition_env_pp__ON__silver_definition_core_QName)), (common.StringCatter)(new common.StringCatter("'")))))); } })); } }, new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((common.ConsCell)core.Pnil.invoke()); } }))); } });
		// top.typerep = q.lookupValue.typerep
		silver.modification.defaultattr.PdefaultLhsDefLHS.synthesizedAttributes[silver.definition.core.Init.silver_definition_env_typerep__ON__silver_definition_core_DefLHS] = new common.Lazy() { public final Object eval(final common.DecoratedNode context) { return ((silver.definition.type.NType)((common.DecoratedNode)((common.DecoratedNode)context.childAsIs(silver.modification.defaultattr.PdefaultLhsDefLHS.i_q)).synthesized(silver.definition.core.Init.silver_definition_core_lookupValue__ON__silver_definition_core_QName)).synthesized(silver.definition.core.Init.silver_definition_env_typerep__ON__silver_definition_core_QNameLookup)); } };
		// top.translation = makeNTClassName(top.frame.lhsNtName) ++ ".defaultSynthesizedAttributes"
		silver.modification.defaultattr.PdefaultLhsDefLHS.synthesizedAttributes[silver.translation.java.core.Init.silver_translation_java_core_translation__ON__silver_definition_core_DefLHS] = new common.Lazy() { public final Object eval(final common.DecoratedNode context) { return new common.StringCatter((common.StringCatter)((common.StringCatter)silver.translation.java.core.PmakeNTClassName.invoke(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((common.StringCatter)((silver.definition.core.NBlockContext)context.inherited(silver.definition.core.Init.silver_definition_core_frame__ON__silver_definition_core_DefLHS)).decorate(context, (common.Lazy[])null).synthesized(silver.definition.core.Init.silver_definition_core_lhsNtName__ON__silver_definition_core_BlockContext)); } })), (common.StringCatter)(new common.StringCatter(".defaultSynthesizedAttributes"))); } };

	}

	public static final common.NodeFactory<PdefaultLhsDefLHS> factory = new Factory();

	public static final class Factory extends common.NodeFactory<PdefaultLhsDefLHS> {

		@Override
		public PdefaultLhsDefLHS invoke(final Object[] children, final Object[] annotations) {
			return new PdefaultLhsDefLHS(children[0], annotations[0]);
		}
	};

}