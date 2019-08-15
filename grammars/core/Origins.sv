grammar core;
import core:originsimpl;

nonterminal OriginInfo;
nonterminal OriginNote;
nonterminal OriginLink;

synthesized attribute notepp :: String occurs on OriginNote;

synthesized attribute nextOrigin :: Maybe<OriginInfo> occurs on OriginLink;
 -- ^This attribute's implementation is generated automatically. For nonterminals with origins
 -- information it's just(their-origininfo-annotation's-value), for nonterminals without
 -- origins information it's nothing().

synthesized attribute isNewlyConstructed :: Boolean occurs on OriginInfo;
synthesized attribute originNotes :: [OriginNote] occurs on OriginInfo;
synthesized attribute mOriginLink :: Maybe<OriginLink> occurs on OriginInfo;
synthesized attribute mOwnRedexLink :: Maybe<OriginLink> occurs on OriginInfo;
synthesized attribute mOwnRedexNotes :: Maybe<[OriginNote]> occurs on OriginInfo;

abstract production otherOriginInfo
top::OriginInfo ::= source::String notes::[OriginNote]
{
	top.isNewlyConstructed = true;
	top.originNotes = notes;
	top.mOriginLink = nothing();
	top.mOwnRedexLink = nothing();
	top.mOwnRedexNotes = nothing();
}

abstract production bogusOriginInfo
top::OriginInfo ::=
{
	top.isNewlyConstructed = true;
	top.originNotes = [];
	top.mOriginLink = nothing();
	top.mOwnRedexLink = nothing();
	top.mOwnRedexNotes = nothing();
}

abstract production originOriginInfo
top::OriginInfo ::= origin :: OriginLink
				 originNotes :: [OriginNote]
				 newlyConstructed :: Boolean
{
	top.isNewlyConstructed = newlyConstructed;
	top.originNotes = originNotes;
	top.mOriginLink = just(origin);
	top.mOwnRedexLink = nothing();
	top.mOwnRedexNotes = nothing();
}

abstract production originAndRedexOriginInfo
top::OriginInfo ::= origin :: OriginLink
				 originNotes :: [OriginNote]
				 redex :: OriginLink
				 redexNotes :: [OriginNote]
				 newlyConstructed :: Boolean
{
	top.isNewlyConstructed = newlyConstructed;
	top.originNotes = originNotes;
	top.mOriginLink = just(origin);
	top.mOwnRedexLink = just(redex);
	top.mOwnRedexNotes = just(redexNotes);
}

aspect default production
top::OriginNote ::=
{
	top.notepp = "<" ++ hackUnparse(top) ++ ">";
}

abstract production originDbgNote
top::OriginNote ::= string::String
{
	
}

abstract production dbgNote
top::OriginNote ::= string::String
{
	
}

abstract production ruleLocNote
top::OriginNote ::= attributeName::String sourceGrammar::String prod::String nt::String sourceLocation::Location
{
	
}

-- function getOriginChain
-- [OriginInfo] ::= l::OriginInfo
-- {
-- 	return case l.mOriginLink of
-- 		| just(o) -> case o.nextOrigin of
-- 			| just(n) -> n :: getOriginChain(n)
-- 			| nothing() -> []
-- 		end
-- 		| nothing() -> []
-- 	end;
-- }

function getOrigin
OriginInfo ::= arg::a
{
	return case javaGetOrigin(arg) of
		| just(x) -> x
		| nothing() -> bogusOriginInfo()
	end;
}

function printObjectPairForOriginsViz
IO ::= start::a stop::b io::IO
{
	return print(
		"\n\n\n---SVDRAW2 START---" ++
		"\n" ++ sexprify(start) ++
        "\n" ++ sexprify(stop) ++
        "\n" ++ "---SVDRAW2 END---\n\n\n", io);
}