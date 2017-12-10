
package silver.util.treemap;

public final class PbalanceR extends common.FunctionNode {

	public static final int i_lefttree = 0;
	public static final int i_righttree = 1;
	public static final int i_label = 2;
	public static final int i_values = 3;
	public static final int i_CMP = 4;


	public static final Class<?> childTypes[] = { silver.util.treemap.NTreeMap.class,silver.util.treemap.NTreeMap.class,Object.class,common.DecoratedNode.class,common.NodeFactory.class };

	public static final int num_local_attrs = Init.count_local__ON__silver_util_treemap_balanceR;
	public static final String[] occurs_local = new String[num_local_attrs];

	public static final common.Lazy[][] childInheritedAttributes = new common.Lazy[5][];

	public static final common.Lazy[] localAttributes = new common.Lazy[num_local_attrs];
	public static final common.Lazy[][] localInheritedAttributes = new common.Lazy[num_local_attrs][];

	static{
	childInheritedAttributes[i_lefttree] = new common.Lazy[silver.util.treemap.NTreeMap.num_inh_attrs];
	childInheritedAttributes[i_righttree] = new common.Lazy[silver.util.treemap.NTreeMap.num_inh_attrs];

	}

	public PbalanceR(final Object c_lefttree, final Object c_righttree, final Object c_label, final Object c_values, final Object c_CMP) {
		this.child_lefttree = c_lefttree;
		this.child_righttree = c_righttree;
		this.child_label = c_label;
		this.child_values = c_values;
		this.child_CMP = c_CMP;

	}

	private Object child_lefttree;
	public final silver.util.treemap.NTreeMap getChild_lefttree() {
		return (silver.util.treemap.NTreeMap) (child_lefttree = common.Util.demand(child_lefttree));
	}

	private Object child_righttree;
	public final silver.util.treemap.NTreeMap getChild_righttree() {
		return (silver.util.treemap.NTreeMap) (child_righttree = common.Util.demand(child_righttree));
	}

	private Object child_label;
	public final Object getChild_label() {
		return (Object) (child_label = common.Util.demand(child_label));
	}

	private Object child_values;
	public final common.ConsCell getChild_values() {
		return (common.ConsCell) (child_values = common.Util.demand(child_values));
	}

	private Object child_CMP;
	public final common.NodeFactory<Integer> getChild_CMP() {
		return (common.NodeFactory<Integer>) (child_CMP = common.Util.demand(child_CMP));
	}



	@Override
	public Object getChild(final int index) {
		switch(index) {
			case i_lefttree: return getChild_lefttree();
			case i_righttree: return getChild_righttree();
			case i_label: return getChild_label();
			case i_values: return getChild_values();
			case i_CMP: return getChild_CMP();

			default: return null;
		}
	}

	@Override
	public Object getChildLazy(final int index) {
		switch(index) {
			case i_lefttree: return child_lefttree;
			case i_righttree: return child_righttree;
			case i_label: return child_label;
			case i_values: return child_values;
			case i_CMP: return child_CMP;

			default: return null;
		}
	}

	@Override
	public final int getNumberOfChildren() {
		return 5;
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
		return "silver:util:treemap:balanceR";
	}

	public static silver.util.treemap.NTreeMap invoke(final Object c_lefttree, final Object c_righttree, final Object c_label, final Object c_values, final Object c_CMP) {
		try {
		final common.DecoratedNode context = new PbalanceR(c_lefttree, c_righttree, c_label, c_values, c_CMP).decorate();
		//case righttree of node(false, node(false, b, c, y1, y2, _), d, z1, z2, _) -> node(false, node(true, lefttree, b, label, values, CMP), node(true, c, d, z1, z2, CMP), y1, y2, CMP) | node(false, b, node(false, c, d, z1, z2, _), y1, y2, _) -> node(false, node(true, lefttree, b, label, values, CMP), node(true, c, d, z1, z2, CMP), y1, y2, CMP) | b -> node(true, lefttree, b, label, values, CMP) end
		return (silver.util.treemap.NTreeMap)(((silver.util.treemap.NTreeMap)(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { final common.Thunk<Object> __SV_LOCAL_11011___fail_11012 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((silver.util.treemap.NTreeMap)(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { final common.Thunk<Object> __SV_LOCAL_11010_b = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return context.childDecorated(silver.util.treemap.PbalanceR.i_righttree); } };
return ((silver.util.treemap.NTreeMap)new silver.util.treemap.Pnode(true, common.Thunk.transformUndecorate(context.childDecoratedLazy(silver.util.treemap.PbalanceR.i_lefttree)), common.Thunk.transformUndecorate(__SV_LOCAL_11010_b), context.childAsIsLazy(silver.util.treemap.PbalanceR.i_label), context.childAsIsLazy(silver.util.treemap.PbalanceR.i_values), context.childAsIsLazy(silver.util.treemap.PbalanceR.i_CMP))); } }).eval()); } };
return new common.PatternLazy<common.DecoratedNode, silver.util.treemap.NTreeMap>() { public final silver.util.treemap.NTreeMap eval(final common.DecoratedNode context, common.DecoratedNode scrutineeIter) {while(true) {final common.DecoratedNode scrutinee = scrutineeIter; final common.Node scrutineeNode = scrutinee.undecorate(); if(scrutineeNode instanceof silver.util.treemap.Pnode) { final common.Thunk<Object> __SV_LOCAL___pv11022___sv_tmp_pv_11021 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return (Boolean)scrutinee.childAsIs(0); } };
final common.Thunk<Object> __SV_LOCAL___pv11023___sv_tmp_pv_11024 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return (common.DecoratedNode)scrutinee.childDecorated(1); } };
final common.Thunk<Object> __SV_LOCAL___pv11025___sv_pv_11026_d = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return (common.DecoratedNode)scrutinee.childDecorated(2); } };
final common.Thunk<Object> __SV_LOCAL___pv11027___sv_pv_11028_z1 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return (Object)scrutinee.childAsIs(3); } };
final common.Thunk<Object> __SV_LOCAL___pv11029___sv_pv_11030_z2 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return (common.ConsCell)scrutinee.childAsIs(4); } };
final common.Thunk<Object> __SV_LOCAL___pv11031___sv_tmp_pv_11032 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return (common.NodeFactory<Integer>)scrutinee.childAsIs(5); } };
 return (silver.util.treemap.NTreeMap)new common.PatternLazy<Boolean, silver.util.treemap.NTreeMap>() { public final silver.util.treemap.NTreeMap eval(final common.DecoratedNode context, Boolean scrutineeIter) {final Boolean scrutinee = scrutineeIter; if(scrutinee == false) { return (silver.util.treemap.NTreeMap)((silver.util.treemap.NTreeMap)(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { final common.Thunk<Object> __SV_LOCAL_11055___fail_11056 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return new common.PatternLazy<common.DecoratedNode, silver.util.treemap.NTreeMap>() { public final silver.util.treemap.NTreeMap eval(final common.DecoratedNode context, common.DecoratedNode scrutineeIter) {while(true) {final common.DecoratedNode scrutinee = scrutineeIter; final common.Node scrutineeNode = scrutinee.undecorate(); if(scrutineeNode instanceof silver.util.treemap.Pnode) { final common.Thunk<Object> __SV_LOCAL___pv11037___sv_tmp_pv_11036 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return (Boolean)scrutinee.childAsIs(0); } };
final common.Thunk<Object> __SV_LOCAL___pv11038___sv_pv_11039_c = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return (common.DecoratedNode)scrutinee.childDecorated(1); } };
final common.Thunk<Object> __SV_LOCAL___pv11040___sv_pv_11041_d = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return (common.DecoratedNode)scrutinee.childDecorated(2); } };
final common.Thunk<Object> __SV_LOCAL___pv11042___sv_pv_11043_z1 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return (Object)scrutinee.childAsIs(3); } };
final common.Thunk<Object> __SV_LOCAL___pv11044___sv_pv_11045_z2 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return (common.ConsCell)scrutinee.childAsIs(4); } };
final common.Thunk<Object> __SV_LOCAL___pv11046___sv_tmp_pv_11047 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return (common.NodeFactory<Integer>)scrutinee.childAsIs(5); } };
 return (silver.util.treemap.NTreeMap)new common.PatternLazy<Boolean, silver.util.treemap.NTreeMap>() { public final silver.util.treemap.NTreeMap eval(final common.DecoratedNode context, Boolean scrutineeIter) {final Boolean scrutinee = scrutineeIter; if(scrutinee == false) { return (silver.util.treemap.NTreeMap)((silver.util.treemap.NTreeMap)(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { final common.Thunk<Object> __SV_LOCAL_11048_y2 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((common.ConsCell)(__SV_LOCAL___pv11029___sv_pv_11030_z2.eval())); } };
return ((silver.util.treemap.NTreeMap)(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { final common.Thunk<Object> __SV_LOCAL_11049_y1 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((Object)(__SV_LOCAL___pv11027___sv_pv_11028_z1.eval())); } };
return ((silver.util.treemap.NTreeMap)(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { final common.Thunk<Object> __SV_LOCAL_11050_z2 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((common.ConsCell)(__SV_LOCAL___pv11044___sv_pv_11045_z2.eval())); } };
return ((silver.util.treemap.NTreeMap)(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { final common.Thunk<Object> __SV_LOCAL_11051_z1 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((Object)(__SV_LOCAL___pv11042___sv_pv_11043_z1.eval())); } };
return ((silver.util.treemap.NTreeMap)(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { final common.Thunk<Object> __SV_LOCAL_11052_d = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((common.DecoratedNode)(__SV_LOCAL___pv11040___sv_pv_11041_d.eval())); } };
return ((silver.util.treemap.NTreeMap)(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { final common.Thunk<Object> __SV_LOCAL_11053_c = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((common.DecoratedNode)(__SV_LOCAL___pv11038___sv_pv_11039_c.eval())); } };
return ((silver.util.treemap.NTreeMap)(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { final common.Thunk<Object> __SV_LOCAL_11054_b = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((common.DecoratedNode)(__SV_LOCAL___pv11023___sv_tmp_pv_11024.eval())); } };
return ((silver.util.treemap.NTreeMap)new silver.util.treemap.Pnode(false, new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((silver.util.treemap.NTreeMap)new silver.util.treemap.Pnode(true, common.Thunk.transformUndecorate(context.childDecoratedLazy(silver.util.treemap.PbalanceR.i_lefttree)), common.Thunk.transformUndecorate(__SV_LOCAL_11054_b), context.childAsIsLazy(silver.util.treemap.PbalanceR.i_label), context.childAsIsLazy(silver.util.treemap.PbalanceR.i_values), context.childAsIsLazy(silver.util.treemap.PbalanceR.i_CMP))); } }, new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((silver.util.treemap.NTreeMap)new silver.util.treemap.Pnode(true, common.Thunk.transformUndecorate(__SV_LOCAL_11053_c), common.Thunk.transformUndecorate(__SV_LOCAL_11052_d), __SV_LOCAL_11051_z1, __SV_LOCAL_11050_z2, context.childAsIsLazy(silver.util.treemap.PbalanceR.i_CMP))); } }, __SV_LOCAL_11049_y1, __SV_LOCAL_11048_y2, context.childAsIsLazy(silver.util.treemap.PbalanceR.i_CMP))); } }).eval()); } }).eval()); } }).eval()); } }).eval()); } }).eval()); } }).eval()); } }).eval()); }return ((silver.util.treemap.NTreeMap)(__SV_LOCAL_11011___fail_11012.eval()));}}.eval(context, (Boolean)((Boolean)(__SV_LOCAL___pv11037___sv_tmp_pv_11036.eval()))); }if(!scrutineeIter.undecorate().hasForward()) break;scrutineeIter = scrutineeIter.forward();}return ((silver.util.treemap.NTreeMap)(__SV_LOCAL_11011___fail_11012.eval()));}}.eval(context, (common.DecoratedNode)((common.DecoratedNode)(__SV_LOCAL___pv11025___sv_pv_11026_d.eval()))); } };
return new common.PatternLazy<common.DecoratedNode, silver.util.treemap.NTreeMap>() { public final silver.util.treemap.NTreeMap eval(final common.DecoratedNode context, common.DecoratedNode scrutineeIter) {while(true) {final common.DecoratedNode scrutinee = scrutineeIter; final common.Node scrutineeNode = scrutinee.undecorate(); if(scrutineeNode instanceof silver.util.treemap.Pnode) { final common.Thunk<Object> __SV_LOCAL___pv11081___sv_tmp_pv_11080 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return (Boolean)scrutinee.childAsIs(0); } };
final common.Thunk<Object> __SV_LOCAL___pv11082___sv_pv_11083_b = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return (common.DecoratedNode)scrutinee.childDecorated(1); } };
final common.Thunk<Object> __SV_LOCAL___pv11084___sv_pv_11085_c = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return (common.DecoratedNode)scrutinee.childDecorated(2); } };
final common.Thunk<Object> __SV_LOCAL___pv11086___sv_pv_11087_y1 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return (Object)scrutinee.childAsIs(3); } };
final common.Thunk<Object> __SV_LOCAL___pv11088___sv_pv_11089_y2 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return (common.ConsCell)scrutinee.childAsIs(4); } };
final common.Thunk<Object> __SV_LOCAL___pv11090___sv_tmp_pv_11091 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return (common.NodeFactory<Integer>)scrutinee.childAsIs(5); } };
 return (silver.util.treemap.NTreeMap)new common.PatternLazy<Boolean, silver.util.treemap.NTreeMap>() { public final silver.util.treemap.NTreeMap eval(final common.DecoratedNode context, Boolean scrutineeIter) {final Boolean scrutinee = scrutineeIter; if(scrutinee == false) { return (silver.util.treemap.NTreeMap)((silver.util.treemap.NTreeMap)(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { final common.Thunk<Object> __SV_LOCAL_11092_z2 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((common.ConsCell)(__SV_LOCAL___pv11029___sv_pv_11030_z2.eval())); } };
return ((silver.util.treemap.NTreeMap)(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { final common.Thunk<Object> __SV_LOCAL_11093_z1 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((Object)(__SV_LOCAL___pv11027___sv_pv_11028_z1.eval())); } };
return ((silver.util.treemap.NTreeMap)(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { final common.Thunk<Object> __SV_LOCAL_11094_d = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((common.DecoratedNode)(__SV_LOCAL___pv11025___sv_pv_11026_d.eval())); } };
return ((silver.util.treemap.NTreeMap)(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { final common.Thunk<Object> __SV_LOCAL_11095_y2 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((common.ConsCell)(__SV_LOCAL___pv11088___sv_pv_11089_y2.eval())); } };
return ((silver.util.treemap.NTreeMap)(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { final common.Thunk<Object> __SV_LOCAL_11096_y1 = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((Object)(__SV_LOCAL___pv11086___sv_pv_11087_y1.eval())); } };
return ((silver.util.treemap.NTreeMap)(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { final common.Thunk<Object> __SV_LOCAL_11097_c = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((common.DecoratedNode)(__SV_LOCAL___pv11084___sv_pv_11085_c.eval())); } };
return ((silver.util.treemap.NTreeMap)(new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { final common.Thunk<Object> __SV_LOCAL_11098_b = new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((common.DecoratedNode)(__SV_LOCAL___pv11082___sv_pv_11083_b.eval())); } };
return ((silver.util.treemap.NTreeMap)new silver.util.treemap.Pnode(false, new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((silver.util.treemap.NTreeMap)new silver.util.treemap.Pnode(true, common.Thunk.transformUndecorate(context.childDecoratedLazy(silver.util.treemap.PbalanceR.i_lefttree)), common.Thunk.transformUndecorate(__SV_LOCAL_11098_b), context.childAsIsLazy(silver.util.treemap.PbalanceR.i_label), context.childAsIsLazy(silver.util.treemap.PbalanceR.i_values), context.childAsIsLazy(silver.util.treemap.PbalanceR.i_CMP))); } }, new common.Thunk<Object>(context) { public final Object doEval(final common.DecoratedNode context) { return ((silver.util.treemap.NTreeMap)new silver.util.treemap.Pnode(true, common.Thunk.transformUndecorate(__SV_LOCAL_11097_c), common.Thunk.transformUndecorate(__SV_LOCAL_11094_d), __SV_LOCAL_11093_z1, __SV_LOCAL_11092_z2, context.childAsIsLazy(silver.util.treemap.PbalanceR.i_CMP))); } }, __SV_LOCAL_11096_y1, __SV_LOCAL_11095_y2, context.childAsIsLazy(silver.util.treemap.PbalanceR.i_CMP))); } }).eval()); } }).eval()); } }).eval()); } }).eval()); } }).eval()); } }).eval()); } }).eval()); }return ((silver.util.treemap.NTreeMap)(__SV_LOCAL_11055___fail_11056.eval()));}}.eval(context, (Boolean)((Boolean)(__SV_LOCAL___pv11081___sv_tmp_pv_11080.eval()))); }if(!scrutineeIter.undecorate().hasForward()) break;scrutineeIter = scrutineeIter.forward();}return ((silver.util.treemap.NTreeMap)(__SV_LOCAL_11055___fail_11056.eval()));}}.eval(context, (common.DecoratedNode)((common.DecoratedNode)(__SV_LOCAL___pv11023___sv_tmp_pv_11024.eval()))); } }).eval()); }return ((silver.util.treemap.NTreeMap)(__SV_LOCAL_11011___fail_11012.eval()));}}.eval(context, (Boolean)((Boolean)(__SV_LOCAL___pv11022___sv_tmp_pv_11021.eval()))); }if(!scrutineeIter.undecorate().hasForward()) break;scrutineeIter = scrutineeIter.forward();}return ((silver.util.treemap.NTreeMap)(__SV_LOCAL_11011___fail_11012.eval()));}}.eval(context, (common.DecoratedNode)context.childDecorated(silver.util.treemap.PbalanceR.i_righttree)); } }).eval()));

		} catch(Throwable t) {
			throw new common.exceptions.TraceException("Error while evaluating function silver:util:treemap:balanceR", t);
		}
	}

	public static final common.NodeFactory<silver.util.treemap.NTreeMap> factory = new Factory();

	public static final class Factory extends common.NodeFactory<silver.util.treemap.NTreeMap> {
		@Override
		public silver.util.treemap.NTreeMap invoke(final Object[] children, final Object[] namedNotApplicable) {
			return PbalanceR.invoke(children[0], children[1], children[2], children[3], children[4]);
		}
	};
}