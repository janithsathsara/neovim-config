return {
    'echasnovski/mini.surround',
    version = '*',
    config = function()
        require("mini.surround").setup(
        -- No need to copy this inside `setup()`. Will be used automatically.
            {
                -- Add custom surroundings to be used on top of builtin ones. For more
                -- information with examples, see `:h MiniSurround.config`.
                custom_surroundings = nil,

                -- Duration (in ms) of highlight when calling `MiniSurround.highlight()`
                highlight_duration = 500,

                -- Module mappings. Use `''` (empty string) to disable one.
                mappings = {
                    add = 'xa',            -- Add surrounding in Normal and Visual modes
                    delete = 'xd',         -- Delete surrounding
                    find = 'xf',           -- Find surrounding (to the right)
                    find_left = 'xF',      -- Find surrounding (to the left)
                    highlight = 'xh',      -- Highlight surrounding
                    replace = 'xr',        -- Replace surrounding
                    update_n_lines = 'xn', -- Update `n_lines`

                    suffix_last = 'l',     -- Suffix to search with "prev" method
                    suffix_next = 'n',     -- Suffix to search with "next" method
                },

                -- Number of lines within which surrounding is searched
                n_lines = 20,

                -- Whether to respect selection type:
                -- - Place surroundings on separate lines in linewise mode.
                -- - Place surroundings on each line in blockwise mode.
                respect_selection_type = false,

                -- How to search for surrounding (first inside current line, then inside
                -- neighborhood). One of 'cover', 'cover_or_next', 'cover_or_prev',
                -- 'cover_or_nearest', 'next', 'prev', 'nearest'. For more details,
                -- see `:h MiniSurround.config`.
                search_method = 'cover',

                -- Whether to disable showing non-error feedback
                -- This also affects (purely informational) helper messages shown after
                -- idle time if user input is required.
                silent = false,
            }
        )
    end
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

