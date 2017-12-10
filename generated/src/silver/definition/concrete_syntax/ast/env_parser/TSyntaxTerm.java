
package silver.definition.concrete_syntax.ast.env_parser;

import edu.umn.cs.melt.copper.runtime.engines.semantics.VirtualLocation;
import core.NLocation;

public class TSyntaxTerm extends common.Terminal {
  public TSyntaxTerm(final String lexeme, final VirtualLocation vl, final int index, final int endIndex) {
    super(lexeme, vl, index, endIndex);
  }

  public TSyntaxTerm(final common.StringCatter lexeme, final NLocation location) {
    super(lexeme, location);
  }

  @Override
  public String getName() { return "silver:definition:concrete_syntax:ast:env_parser:SyntaxTerm"; }

  private static String[] lexerclasses = null;
  @Override
  public String[] getLexerClasses() {
    // Avoid doing more work at class-load time, in case we don't need this
    if (lexerclasses == null) {
      lexerclasses = new String[] {"silver:definition:env:env_parser:C_1"};
    }
    return lexerclasses;
  }
}
