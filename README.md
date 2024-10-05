# LaTeX-Styling-Stata

Styling Stata graphics with LaTeX.

- waterQuality.csv &nbsp;&nbsp; CSV data.<br />
- waterQuality.do &nbsp;&nbsp; Stata do-file.<br />
- waterQuality.ltx &nbsp;&nbsp; LaTeX file.<br />

The Stata do-file performs Bayesian linear regression for a water quality dataset (CSV format). A traceplot of an MCMC chain is exported in SVG format, then converted to a PDF file if a local Inkscape installation is available. The traceplot PDF file may be styled further with LaTeX markup. E.g., waterQuality.ltx overlays a glyph beyond what's available in Unicode or the Stata Markup and Control Language.

Software Requirements

- CMU Serif (installed system font).<br />
- Inkscape.<br />
- LaTeX.<br />
- LaTeX packages: metsymb, tikz.<br />
- Stata.<br />

Reference: Stenborg, T 2024, "Styling Stata graphics with LaTeX" (submitted).
