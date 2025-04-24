return {
	"echasnovski/mini.surround",
	version = "*",
	config = function()
		require("mini.surround").setup({
			custom_surroundings = nil,
			highlight_duration = 500,
			mappings = {
				add = "sa", -- Add surrounding in Normal and Visual modes
				delete = "sd", -- Delete surrounding
				find = "sf", -- Find surrounding (to the right)
				find_left = "sF", -- Find surrounding (to the left)
				highlight = "sh", -- Highlight surrounding
				replace = "sr", -- Replace surrounding
				update_n_lines = "sn", -- Update `n_lines`

				suffix_last = "l", -- Suffix to search with "prev" method
				suffix_next = "n", -- Suffix to search with "next" method
			},

			n_lines = 20,
			respect_selection_type = false,
			search_method = "cover",
			silent = false,
		})
	end,
}

-- |Key|     Name      |  Example line |    Delete   |     Replace     |
-- |---|---------------|---------------|-------------|-----------------|
-- | ( |  Balanced ()  | !( *a (bb) )! |  !aa (bb)!  | ( ( aa (bb) ) ) |
-- | [ |  Balanced []  | ![ *a [bb] ]! |  !aa [bb]!  | [ [ aa [bb] ] ] |
-- | { |  Balanced {}  | !{ *a {bb} }! |  !aa {bb}!  | { { aa {bb} } } |
-- | < |  Balanced <>  | !< *a <bb> >! |  !aa <bb>!  | < < aa <bb> > > |
-- |---|---------------|---------------|-------------|-----------------|
-- | ) |  Balanced ()  | !( *a (bb) )! | ! aa (bb) ! | (( aa (bb) ))   |
-- | ] |  Balanced []  | ![ *a [bb] ]! | ! aa [bb] ! | [[ aa [bb] ]]   |
-- | } |  Balanced {}  | !{ *a {bb} }! | ! aa {bb} ! | {{ aa {bb} }}   |
-- | > |  Balanced <>  | !< *a <bb> >! | ! aa <bb> ! | << aa <bb> >>   |
-- | b |  Alias for    | !( *a {bb} )! | ! aa {bb} ! | (( aa {bb} ))   |
-- |   |  ), ], or }   |               |             |                 |
-- |---|---------------|---------------|-------------|-----------------|
-- | q |  Alias for    | !'aa'*a'aa'!  | !'aaaaaa'!  | "'aa'aa'aa'"    |
-- |   |  ", ', or `   |               |             |                 |
-- |---|---------------|---------------|-------------|-----------------|
-- | ? |  User prompt  | !e * o!       | ! a !       | ee a oo         |
-- |   |(typed e and o)|               |             |                 |
-- |---|---------------|---------------|-------------|-----------------|
-- | t |      Tag      | !<x>*</x>!    | !a!         | <y><x>a</x></y> |
-- |   |               |               |             | (typed y)       |
-- |---|---------------|---------------|-------------|-----------------|
-- | f | Function call | !f(*a, bb)!   | !aa, bb!    | g(f(*a, bb))    |
-- |   |               |               |             | (typed g)       |
-- |---|---------------|---------------|-------------|-----------------|
-- |   |    Default    | !_a*a_!       | !aaa!       | __aaa__         |
-- |   |   (typed _)   |               |             |                 |
-- |---|---------------|---------------|-------------|-----------------|
