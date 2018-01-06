package common;

import java.io.*;
import java.lang.reflect.*;
import java.util.*;

import common.exceptions.*;

import core.reflect.*;

/**
 * ReifyFn implements the value of the <code>reify</code> expression.  
 * 
 * @param <T>  The return type of the function
 * @author krame505
 */
public abstract class ReifyFn<T> extends NodeFactory<T> {
	protected final TypeRep resultType;
	
	/**
	 * Create a ReifyFn.
	 * 
	 * @param resultType The type of tree to be constructed.
	 */
	public ReifyFn(TypeRep resultType) {
		this.resultType = resultType;
	}
	
	/**
	 * Invoke the reify operation.
	 * 
	 * @return The tree constructed.
	 */
	public final T invoke(final Object[] args, final Object[] namedArgs) {
		assert args.length == 1;
		assert namedArgs.length == 0;
		return (T)reify(resultType, (NAST)args[0]);
	}
	
	/**
	 * Implementation of the reify operation for an arbitrary type.
	 * 
	 * @param resultType The type of tree to be constructed.
	 * @param ast The tree to reify. 
	 */
	public static Object reify(final TypeRep resultType, final NAST ast) {
		if (ast.getName().equals("core:reflect:nonterminalAST")) {
			final String prodName = ((StringCatter)ast.getChild(0)).toString();
			final List<NAST> childASTs = new ArrayList<>(5);
			for (NASTs current = (NASTs)ast.getChild(1); !current.getName().equals("core:reflect:nilAST"); current = (NASTs)current.getChild(1)) {
				childASTs.add((NAST)current.getChild(0));
			}
			final Map<String, NAST> annotationASTs = new TreeMap<>();
			for (NNamedASTs current = (NNamedASTs)ast.getChild(2); !current.getName().equals("core:reflect:nilNamedAST"); current = (NNamedASTs)current.getChild(1)) {
				NNamedAST item = (NNamedAST)current.getChild(0);
				annotationASTs.put(item.getChild(0).toString(), (NAST)item.getChild(1));
			}

			// Invoke the reify function for the appropriate nonterminal class
			final String[] path = prodName.split(":");
			path[path.length - 1] = "P" + path[path.length - 1];
			final String className = String.join(".", path);
			try {
				return Class.forName(className).getMethod("reify", TypeRep.class, NAST.class).invoke(resultType, childASTs, annotationASTs);
			} catch (ClassNotFoundException e) {
				throw new SilverError("Undefined production " + prodName);
			} catch (NoSuchMethodException | IllegalAccessException e) {
				throw new SilverInternalError("Error invoking reify for class " + className, e);
			} catch (InvocationTargetException e) {
				if (e.getTargetException() instanceof SilverException) {
					throw (SilverException)e.getTargetException();
				} else {
					throw new SilverInternalError("Error invoking reify for class " + className, e.getTargetException());
				}
			}
		} else if (ast.getName().equals("core:reflect:listAST")) {
			if (!resultType.baseName.equals("[]")) {
				throw new SilverError("reify is constructing " + resultType.toString() + ", but found list AST.");
			}
			return reifyList(resultType, (NASTs)ast.getChild(0));
		} else {
			String givenTypeName;
			if (ast.getName().equals("core:reflect:stringAST")) {
				givenTypeName = "String";
			} else if (ast.getName().equals("core:reflect:integerAST")) {
				givenTypeName = "Integer";
			} else if (ast.getName().equals("core:reflect:floatAST")) {
				givenTypeName = "Float";
			} else if (ast.getName().equals("core:reflect:booleanAST")) {
				givenTypeName = "Boolean";
			} else if (ast.getName().equals("core:reflect:foreignAST")) {
				givenTypeName = "foreign";
			} else {
				throw new SilverInternalError("Unexpected AST production " + ast.getName());
			}
			if (!givenTypeName.equals(resultType.baseName)) {
				throw new SilverError("reify is constructing " + resultType.toString() + ", but found " + givenTypeName + " AST.");
			}
			return ast.getChild(0);
		}
	}
	private static ConsCell reifyList(final TypeRep resultType, final NASTs asts) {
		if (asts.getName().equals("core:reflect:consAST")) {
			return new ConsCell(reify(resultType.params[0], (NAST)asts.getChild(0)), reifyList(resultType, (NASTs)asts.getChild(1)));
		} else if (asts.getName().equals("core:reflect:nilAST")) {
			return ConsCell.nil;
		} else {
			throw new SilverInternalError("Unexpected ASTs production" + asts.getName());
		}
	}
}
