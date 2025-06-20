return {
	{
		"echasnovski/mini.ai",
		lazy = true,
		event = {
			"BufReadPre",
			"BufNewFile",
		},
		version = "*",
		config = function()
			require("mini.ai").setup()
		end,
	},
}

-- |Key|     Name      |   Example line   |   a    |   i    |   2a   |   2i   |
-- |---|---------------|-1234567890123456-|--------|--------|--------|--------|
-- | ( |  Balanced ()  | (( *a (bb) ))    |        |        |        |        |
-- | [ |  Balanced []  | [[ *a [bb] ]]    | [2;12] | [4;10] | [1;13] | [2;12] |
-- | { |  Balanced {}  | {{ *a {bb} }}    |        |        |        |        |
-- | < |  Balanced <>  | << *a <bb> >>    |        |        |        |        |
-- |---|---------------|-1234567890123456-|--------|--------|--------|--------|
-- | ) |  Balanced ()  | (( *a (bb) ))    |        |        |        |        |
-- | ] |  Balanced []  | [[ *a [bb] ]]    |        |        |        |        |
-- | } |  Balanced {}  | {{ *a {bb} }}    | [2;12] | [3;11] | [1;13] | [2;12] |
-- | > |  Balanced <>  | << *a <bb> >>    |        |        |        |        |
-- | b |  Alias for    | [( *a {bb} )]    |        |        |        |        |
-- |   |  ), ], or }   |                  |        |        |        |        |
-- |---|---------------|-1234567890123456-|--------|--------|--------|--------|
-- | " |  Balanced "   | "*a" " bb "      |        |        |        |        |
-- | ' |  Balanced '   | '*a' ' bb '      |        |        |        |        |
-- | ` |  Balanced `   | `*a` ` bb `      | [1;4]  | [2;3]  | [6;11] | [7;10] |
-- | q |  Alias for    | '*a' " bb "      |        |        |        |        |
-- |   |  ", ', or `   |                  |        |        |        |        |
-- |---|---------------|-1234567890123456-|--------|--------|--------|--------|
-- | ? |  User prompt  | e*e o e o o      | [3;5]  | [4;4]  | [7;9]  | [8;8]  |
-- |   |(typed e and o)|                  |        |        |        |        |
-- |---|---------------|-1234567890123456-|--------|--------|--------|--------|
-- | t |      Tag      | <x><y>*a</y></x> | [4;12] | [7;8]  | [1;16] | [4;12] |
-- |---|---------------|-1234567890123456-|--------|--------|--------|--------|
-- | f | Function call | f(a, g(*b, c) )  | [6;13] | [8;12] | [1;15] | [3;14] |
-- |---|---------------|-1234567890123456-|--------|--------|--------|--------|
-- | a |   Argument    | f(*a, g(b, c) )  | [3;5]  | [3;4]  | [5;14] | [7;13] |
-- |---|---------------|-1234567890123456-|--------|--------|--------|--------|
-- |   |    Default    |                  |        |        |        |        |
-- |   |   (digits,    | aa_*b__cc___     | [4;7]  | [4;5]  | [8;12] | [8;9]  |
-- |   | punctuation,  | (example for _)  |        |        |        |        |
-- |   | or whitespace)|                  |        |        |        |        |
-- |---|---------------|-1234567890123456-|--------|--------|--------|--------|
