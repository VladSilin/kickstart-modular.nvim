local ls = require 'luasnip'
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node

return {
  -- Document template
  s('doc', {
    t { '\\documentclass{article}', '\\usepackage{amsmath}', '\\usepackage{amssymb}', '', '\\begin{document}', '' },
    i(1),
    t { '', '\\end{document}' },
  }),

  -- Sections
  s('sec', {
    t '\\section{',
    i(1, 'Section Title'),
    t '}',
  }),

  s('ssec', {
    t '\\subsection{',
    i(1, 'Subsection Title'),
    t '}',
  }),

  -- Environments
  s('beg', {
    t '\\begin{',
    i(1, 'environment'),
    t { '}', '\t' },
    i(2),
    t { '', '\\end{' },
    f(function(args)
      return args[1][1]
    end, { 1 }),
    t '}',
  }),

  s('eq', {
    t { '\\begin{equation}', '\t' },
    i(1),
    t { '', '\\end{equation}' },
  }),

  s('eqn', {
    t { '\\begin{equation}', '\t' },
    i(1),
    t { '', '\\label{eq:' },
    i(2, 'label'),
    t { '}', '\\end{equation}' },
  }),

  s('align', {
    t { '\\begin{align}', '\t' },
    i(1),
    t { '', '\\end{align}' },
  }),

  s('fig', {
    t { '\\begin{figure}[htbp]', '\t\\centering', '\t\\includegraphics[width=0.8\\textwidth]{' },
    i(1, 'filename'),
    t { '}', '\t\\caption{' },
    i(2, 'caption'),
    t { '}', '\t\\label{fig:' },
    i(3, 'label'),
    t { '}', '\\end{figure}' },
  }),

  s('tab', {
    t { '\\begin{table}[htbp]', '\t\\centering', '\t\\begin{tabular}{' },
    i(1, 'c|c'),
    t { '}', '\t\t\\hline', '\t\t' },
    i(2),
    t { ' \\\\', '\t\t\\hline', '\t\\end{tabular}', '\t\\caption{' },
    i(3, 'caption'),
    t { '}', '\t\\label{tab:' },
    i(4, 'label'),
    t { '}', '\\end{table}' },
  }),

  s('item', {
    t { '\\begin{itemize}', '\t\\item ' },
    i(1),
    t { '', '\\end{itemize}' },
  }),

  s('enum', {
    t { '\\begin{enumerate}', '\t\\item ' },
    i(1),
    t { '', '\\end{enumerate}' },
  }),

  -- Math
  s('frac', {
    t '\\frac{',
    i(1, 'num'),
    t '}{',
    i(2, 'denom'),
    t '}',
  }),

  s('sum', {
    t '\\sum_{',
    i(1, 'i=1'),
    t '}^{',
    i(2, 'n'),
    t '}',
  }),

  s('int', {
    t '\\int_{',
    i(1, 'a'),
    t '}^{',
    i(2, 'b'),
    t '}',
  }),

  -- Text formatting
  s('bf', {
    t '\\textbf{',
    i(1),
    t '}',
  }),

  s('it', {
    t '\\textit{',
    i(1),
    t '}',
  }),

  s('tt', {
    t '\\texttt{',
    i(1),
    t '}',
  }),
}
