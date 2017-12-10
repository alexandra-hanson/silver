
package silver.extension.patternmatching;

// top::Pattern ::= num::Int_t 
public final class PintPattern extends silver.extension.patternmatching.NPattern {

	public static final int i_num = 0;


	public static final Class<?> childTypes[] = {silver.definition.core.TInt_t.class};

	public static final int num_local_attrs = Init.count_local__ON__silver_extension_patternmatching_intPattern;
	public static final String[] occurs_local = new String[num_local_attrs];

	public static final common.Lazy[] forwardInheritedAttributes = new common.Lazy[silver.extension.patternmatching.NPattern.num_inh_attrs];

	public static final common.Lazy[] synthesizedAttributes = new common.Lazy[silver.extension.patternmatching.NPattern.num_syn_attrs];
	public static final common.Lazy[][] childInheritedAttributes = new common.Lazy[1][];

	public static final common.Lazy[] localAttributes = new common.Lazy[num_local_attrs];
	public static final common.Lazy[][] localInheritedAttributes = new common.Lazy[num_local_attrs][];

	static {

	}

	public PintPattern(final Object c_num, final Object a_core_location) {
		super(a_core_location);
		this.child_num = c_num;

	}

	private Object child_num;
	public final silver.definition.core.TInt_t getChild_num() {
		return (silver.definition.core.TInt_t) (child_num = common.Util.demand(child_num));
	}



	@Override
	public Object getChild(final int index) {
		switch(index) {
			case i_num: return getChild_num();

			default: return null;
		}
	}

	@Override
	public Object getChildLazy(final int index) {
		switch(index) {
			case i_num: return child_num;

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
		throw new common.exceptions.SilverInternalError("Production silver:extension:patternmatching:intPattern erroneously claimed to forward");
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
		return "silver:extension:patternmatching:intPattern";
	}

	static void initProductionAttributeDefinitions() {
		// top.pp = num.lexeme
		silver.extension.patternmatching.PintPattern.synthesizedAttributes[silver.extension.patternmatching.Init.silver_definition_env_pp__ON__silver_extension_patternmatching_Pattern] = new common.Lazy() { public final Object eval(final common.DecoratedNode context) { return ((common.StringCatter)((silver.definition.core.TInt_t)context.childAsIs(silver.extension.patternmatching.PintPattern.i_num)).lexeme); } };
		// top.errors := []
		if(silver.extension.patternmatching.PintPattern.synthesizedAttributes[silver.extension.patternmatching.Init.silver_definition_core_errors__ON__silver_extension_patternmatching_Pattern] == null)
			silver.extension.patternmatching.PintPattern.synthesizedAttributes[silver.extension.patternmatching.Init.silver_definition_core_errors__ON__silver_extension_patternmatching_Pattern] = new silver.definition.core.CAerrors(silver.extension.patternmatching.Init.silver_definition_core_errors__ON__silver_extension_patternmatching_Pattern);
		((common.CollectionAttribute)silver.extension.patternmatching.PintPattern.synthesizedAttributes[silver.extension.patternmatching.Init.silver_definition_core_errors__ON__silver_extension_patternmatching_Pattern]).setBase(new common.Lazy() { public final Object eval(final common.DecoratedNode context) { return ((common.ConsCell)core.Pnil.invoke()); } });
		// top.patternSubPatternList = []
		silver.extension.patternmatching.PintPattern.synthesizedAttributes[silver.extension.patternmatching.Init.silver_extension_patternmatching_patternSubPatternList__ON__silver_extension_patternmatching_Pattern] = new common.Lazy() { public final Object eval(final common.DecoratedNode context) { return ((common.ConsCell)core.Pnil.invoke()); } };
		// top.patternSortKey = num.lexeme
		silver.extension.patternmatching.PintPattern.synthesizedAttributes[silver.extension.patternmatching.Init.silver_extension_patternmatching_patternSortKey__ON__silver_extension_patternmatching_Pattern] = new common.Lazy() { public final Object eval(final common.DecoratedNode context) { return ((common.StringCatter)((silver.definition.core.TInt_t)context.childAsIs(silver.extension.patternmatching.PintPattern.i_num)).lexeme); } };

	}

	public static final common.NodeFactory<PintPattern> factory = new Factory();

	public static final class Factory extends common.NodeFactory<PintPattern> {

		@Override
		public PintPattern invoke(final Object[] children, final Object[] annotations) {
			return new PintPattern(children[0], annotations[0]);
		}
	};

}