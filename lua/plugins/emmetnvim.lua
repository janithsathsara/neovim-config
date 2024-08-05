return {
    'mattn/emmet-vim',
    event = { "BufEnter *.html", "BufEnter *.tsx", "BufEnter *.jsx" }
    --  1. Expand abbreviation            |emmet-expand-abbr|              |<C-y>,|
    --  2. Expand word                    |emmet-expand-word|              |<C-y>;|
    --  3. Update tag                     |emmet-update-tag|               |<C-y>u|
    --  4. Wrap with abbreviation         |emmet-wrap-with-abbreviation|   |v_<C-y>,|
    --  5. Balance tag inward             |emmet-balance-tag-inward|       |<C-y>d|
    --  6. Balance tag outward            |emmet-balance-tag-outward|      |<C-y>D|
    --  7. Go to next edit point          |emmet-goto-next-point|          |<C-y>n|
    --  8. Go to previous edit point      |emmet-goto-previous-point|      |<C-y>N|
    --  9. Add and update <img> size      |emmet-update-image-size|        |<C-y>i|
    -- 10. Merge lines                    |emmet-merge-lines|              |<C-y>m|
    -- 11. Remove tag                     |emmet-remove-tag|               |<C-y>k|
    -- 12. Split/join tag                 |emmet-split-join-tag|           |<C-y>j|
    -- 13. Toggle comment                 |emmet-toggle-comment|           |<C-y>/|
    -- 14. Make anchor from URL           |emmet-make-anchor-url|          |<C-y>a|
    -- 15. Make quoted text from URL      |emmet-quoted-text-url|          |<C-y>A|
    -- 16. Code pretty                    |emmet-code-pretty|              |<C-y>c|
}
