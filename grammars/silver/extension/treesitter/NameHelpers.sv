function productionElemToTsIdentifier
String ::= prod::NamedSignatureElement
{
  return toTsIdentifier(prod.typerep.typeName);
}

{-- Transform a string in Silver/Copper to a treesitter string --}
function toTsDeclaration
String ::= str::String
{
  return substitute(":", "_", str);
}

function prefixToUseTreesitterName
Pair<String String> ::= pre::Pair<String String>
{
  return pair(toTsDeclaration(pre.fst), pre.snd);
}

{-- To cause terminals or nonterminals to not appear in the parse tree
  generated by tree sitter, they must begin with an _.
  Used for ignore terminals in Silver that do not specify a syntax coloring.
  TODO: Since coloring information is now separate from the Silver specification,
        determine when to make rules ignore rules.
        Option 1: ALl ignore terminals are - treesitter grammar modified if coloring provided later
        Option 2: No ignore terminals. Determine effect on performance. If necessary for performance, do later in script.
-}
function toTsIgnoreDeclaration
String ::= str::String
{
  -- include ignore declarations in the parse tree
  -- return "_" ++ toTsDeclaration(str)
  return toTsDeclaration(str);
}

function TsDeclToIgnoreDecl
String ::= str::String
{
  -- include ignore declarations in the parse tree
  -- return "_" ++ str
  return str;
}

{-- When identifying a tree sitter terminal or nonterminal it must be begin with
  $.
-}
function toTsIdentifier
String ::= str::String
{
  return "$." ++ substitute(":", "_", str);
}

function TsDeclToIdentifier
String ::= str::String
{
  return "$." ++ str;
}

function TsIdentifierToDecl
String ::= str::String
{
  -- remove the $.
  return substring(2, length(str), str);
}

function removeEscapesForStringLiteral
String ::= str::String
{
  -- 4 \ necessary because 2 are escaped here leading to 1 when escaped
  -- in java
  -- remove all escapes then add back in escapes for backslashes and double quotes.
  return substitute("\"", "\\\"", 
         substitute("\\", "\\\\", 
         substituteRegex("\\\\(.)", "$1", str)));
}

function removeEscapesNotNecessaryForTreesitterRegexs
String ::= str::String
{
  -- most regex regStrings don't need the escapes for some characters 
  -- namely so far spaces and underscores and @ signs.
  return substitute("\\_", "_", 
         substitute("\\@", "@", 
         substitute("\\ ", " ", str)));
}
