
package silver.translation.java.core;

public final class Pint2str extends common.FunctionNode {

	public static final int i_i = 0;


	public static final Class<?> childTypes[] = { Integer.class };

	public static final int num_local_attrs = Init.count_local__ON__silver_translation_java_core_int2str;
	public static final String[] occurs_local = new String[num_local_attrs];

	public static final common.Lazy[][] childInheritedAttributes = new common.Lazy[1][];

	public static final common.Lazy[] localAttributes = new common.Lazy[num_local_attrs];
	public static final common.Lazy[][] localInheritedAttributes = new common.Lazy[num_local_attrs][];

	static{

	}

	public Pint2str(final Object c_i) {
		this.child_i = c_i;

	}

	private Object child_i;
	public final Integer getChild_i() {
		return (Integer) (child_i = common.Util.demand(child_i));
	}



	@Override
	public Object getChild(final int index) {
		switch(index) {
			case i_i: return getChild_i();

			default: return null;
		}
	}

	@Override
	public Object getChildLazy(final int index) {
		switch(index) {
			case i_i: return child_i;

			default: return null;
		}
	}

	@Override
	public final int getNumberOfChildren() {
		return 1;
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
		return "silver:translation:java:core:int2str";
	}

	public static common.StringCatter invoke(final Object c_i) {
		try {
		final common.DecoratedNode context = new Pint2str(c_i).decorate();
		//toString(i)
		return (common.StringCatter)(new common.StringCatter(String.valueOf(((Integer)context.childAsIs(silver.translation.java.core.Pint2str.i_i)))));

		} catch(Throwable t) {
			throw new common.exceptions.TraceException("Error while evaluating function silver:translation:java:core:int2str", t);
		}
	}

	public static final common.NodeFactory<common.StringCatter> factory = new Factory();

	public static final class Factory extends common.NodeFactory<common.StringCatter> {
		@Override
		public common.StringCatter invoke(final Object[] children, final Object[] namedNotApplicable) {
			return Pint2str.invoke(children[0]);
		}
	};
}