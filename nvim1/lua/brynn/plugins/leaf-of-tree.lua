return {
	{
		"leafOfTree/vim-matchtag",
		config = function()
			vim.g.matchtag_always_search = 1
			vim.g.matchtag_files =
				"*.html,*.xhtml,*.phtml,*.php,*.jsx,*.js,*.ts,*.tsx,*.vue,*.svelte,*.xml,*.twig,*.css,*.scss,*.sass,*.less,*.stylus,*.styl,*.md,*.markdown,*.mdx,*.rmd,*.rmarkdown,*.yaml,*.yml,*.json,*.graphql,*.toml,*.rs,*.go,*.java,*.py,*.rb,*.php,*.c,*.cpp,*.h,*.hpp,*.hh,*.hxx,*.cc,*.cxx,*.cs,*.scala,*.sh,*.zsh,*.bash,*.fish,*.bat,*.ps1,*.vbs,*.lua,*.vim,*.vimrc,*.ex,*.exs,*.eex,*.leex,*.svelte,*.ml,*.mli,*.cmx,*.cmi,*.js.flow,*.jsx.flow,*.ts.flow,*.tsx.flow,*.vue.flow,*.php.flow,*.twig.flow,*.html.flow,*.htm.flow,*.css.flow,*.scss.flow,*.sass.flow,*.less.flow,*.stylus.flow,*.styl.flow,*.md.flow,*.markdown.flow,*.mdx.flow,*.rmd.flow,*.rmarkdown.flow,*.yaml.flow,*.yml.flow,*.json.flow,*.graphql.flow,*.toml.flow,*.rs.flow,*.go.flow,*.java.flow,*.py.flow,*.rb.flow,*.php.flow,*.c.flow,*.cpp.flow,*.h.flow,*.hpp.flow,*.hh.flow,*.hxx.flow,*.cc.flow,*.cxx.flow,*.cs.flow,*.scala.flow,*.sh.flow,*.zsh.flow,*.bash.flow,*.fish.flow,*.bat.flow,*.ps1.flow,*.vbs.flow,*.lua.flow,*.vim.flow,*.vimrc.flow,*.ex.flow,*.exs.flow,*.eex.flow,*.leex.flow,*.svelte.flow,*.ml.flow,*.mli.flow,*.cmx.flow,*.cm"
			vim.cmd([[
        augroup matchtag
          autocmd!
          " Define your auto-commands here, if any
          " autocmd FileType html,xml,markdown let b:matchtag_files = '*.html,*.xml,*.markdown'
        augroup END
]])
		end,
	},
}
