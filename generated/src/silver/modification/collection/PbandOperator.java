
package silver.modification.collection;

// top::NameOrBOperator ::= '&&' 
public final class PbandOperator extends silver.modification.collection.NNameOrBOperator {

	public static final int i__G_0 = 0;


	public static final Class<?> childTypes[] = {silver.definition.core.TAnd_t.class};

	public static final int num_local_attrs = Init.count_local__ON__silver_modification_collection_bandOperator;
	public static final String[] occurs_local = new String[num_local_attrs];

	public static final common.Lazy[] forwardInheritedAttributes = new common.Lazy[silver.modification.collection.NNameOrBOperator.num_inh_attrs];

	public static final common.Lazy[] synthesizedAttributes = new common.Lazy[silver.modification.collection.NNameOrBOperator.num_syn_attrs];
	public static final common.Lazy[][] childInheritedAttributes = new common.Lazy[1][];

	public static final common.Lazy[] localAttributes = new common.Lazy[num_local_attrs];
	public static final common.Lazy[][] localInheritedAttributes = new common.Lazy[num_local_attrs][];

	static {

	}

	public PbandOperator(final Object c__G_0, final Object a_core_location) {
		super(a_core_location);
		this.child__G_0 = c__G_0;

	}

	private Object child__G_0;
	public final silver.definition.core.TAnd_t getChild__G_0() {
		return (silver.definition.core.TAnd_t) (child__G_0 = common.Util.demand(child__G_0));
	}



	@Override
	public Object getChild(final int index) {
		switch(index) {
			case i__G_0: return getChild__G_0();

			default: return null;
		}
	}

	@Override
	public Object getChildLazy(final int index) {
		switch(index) {
			case i__G_0: return child__G_0;

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
		throw new common.exceptions.SilverInternalError("Production silver:modification:collection:bandOperator erroneously claimed to forward");
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
		return "silver:modification:collection:bandOperator";
	}

	static void initProductionAttributeDefinitions() {
		// top.pp = "&&"
		silver.modification.collection.PbandOperator.synthesizedAttributes[silver.modification.collection.Init.silver_definition_env_pp__ON__silver_modification_collection_NameOrBOperator] = new common.Lazy() { public final Object eval(final common.DecoratedNode context) { return (new common.StringCatter("&&")); } };
		// top.operation = bandOperation()
		silver.modification.collection.PbandOperator.synthesizedAttributes[silver.modification.collection.Init.silver_modification_collection_operation__ON__silver_modification_collection_NameOrBOperator] = new common.Lazy() { public final Object eval(final common.DecoratedNode context) { return ((silver.modification.collection.NOperation)new silver.modification.collection.PbandOperation()); } };
		// top.errors := case top.operatorForType of boolType() -> [] | _ -> [ err(top.location, "&& operator will only work for collections of type Boolean") ] end
		if(silver.modification.collection.PbandOperator.synthesizedAttributes[silver.modification.collection.Init.silver_definition_core_errors__ON__silver_modification_collection_NameOrBOperator] == null)
			silver.modification.collection.PbandOperator.synthesizedAttributes[silver.modification.collection.Init.silver_definition_core_errors__ON__silver_modification_collection_NameOrBOperator] = new silver.definition.core.CAerrors(silver.modification.collection.Init.silver_definition_core_errors__ON__silver_modification_collection_NameOrBOperator);
		((common.CollectionAttribute)silver.modification.collection.PbandOperator.synthesizedAttributes[silver.modification.collection.Init.silver_definition_core_errors__ON__silver_modification_collection_NameOrBOperator]).setBase(new common.Lazy() { public final Object eval(final common.DecoratedNode context) { return ((common.ConsCell)(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { final common.Thunk<Object> __SV_LOCAL_6942___fail_6943 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((common.ConsCell)core.Pcons.invoke(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((silver.definition.core.NMessage)new silver.definition.core.Perr(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((core.NLocation)((silver.modification.collection.NNameOrBOperator)context.undecorate()).getAnno_core_location()); } }, (new common.StringCatter("&& operator will only work for collections of type Boolean")))); } }, new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((common.ConsCell)core.Pnil.invoke()); } })); } };
return new common.PatternLazy<common.DecoratedNode, common.ConsCell>() { public final common.ConsCell eval(final common.DecoratedNode context, common.DecoratedNode scrutineeIter) {while(true) {final common.DecoratedNode scrutinee = scrutineeIter; final common.Node scrutineeNode = scrutinee.undecorate(); if(scrutineeNode instanceof silver.definition.type.PboolType) {  return (common.ConsCell)((common.ConsCell)core.Pnil.invoke()); }if(!scrutineeIter.undecorate().hasForward()) break;scrutineeIter = scrutineeIter.forward();}return ((common.ConsCell)(__SV_LOCAL_6942___fail_6943.eval()));}}.eval(context, (common.DecoratedNode)((silver.definition.type.NType)context.inherited(silver.modification.collection.Init.silver_modification_collection_operatorForType__ON__silver_modification_collection_NameOrBOperator)).decorate(context, (common.Lazy[])null)); } }).eval()); } });

	}

	public static final common.NodeFactory<PbandOperator> factory = new Factory();

	public static final class Factory extends common.NodeFactory<PbandOperator> {

		@Override
		public PbandOperator invoke(final Object[] children, final Object[] annotations) {
			return new PbandOperator(children[0], annotations[0]);
		}
	};

}
