
// Path initialisation.
global path "C:\StataData"

// Set the working directory.
cd "${path}"


// Import target data.
// Imported variables:
//
//    name           type    units   description
//    ----           ----    -----   -----------
//    catchment      float   km^2    Catchment area
//    quality        float   IBI     Water quality
//    logCatchment   float   -       Log, base 10, of the catchment area value
//
//  N.B. IBI is index of biological integrity. High values indicate good water 
//  quality, low values represent poor water quality.
//
import delimited "waterQuality.csv"

// Perform Bayesian linear regression of water quality (units).
//    - A random seed was used for reproducible results.
//	  - Four chains were used.
//    - Dots were output to the display as progress indicators.
//    - Results were saved to "simdata.dta".
//
// N.B. Stata's default prior distributions:
//
//    - regression coefficients: normal(0,10000)
//         i.e. normal of mean = 0 and variance = 10,000.
//
//    - variance: igamma(0.01,0.01)
//         i.e. inverse-gamma with scale = 0.01 and shape = 0.01.
//
// N.B. Stata's default MCMC parameters are:
//
//    - MCMC iterations: 12,500.
//    - Burn-in: 2,500.
//
//    Here, 30,000 MCMC iterations (and 3,000 burn-in) were used. The increased
//    burn-in period, compared with the Stata default, addressed an issue with
//    adaptation tolerance.
//
bayes, burnin(3000) dots(5000) mcmcsize(30000) nchains(4) rseed(117) ///
   saving(simdata, replace): regress quality logcatchment


// Set the default graphics font to an implementation of Computer Modern.
// This is done for visual harmony with LaTeX documents.
graph set window fontface "CMU Serif"

// Disable printing if the Stata logo on exorted graphs.
graph set print logo off

// Display a traceplot for the first chain.
// N.B. Use 'note("")' to disable the chain label.
bayesgraph trace {quality:logcatchment}, chains(1) lcolor(black) note("") ///
   title("Trace of Estimated Regression Slope", size(huge)) ///
   xtitle("Iteration", size(vlarge)) ytitle("MCMC Draw", size(vlarge)) ///
   xlabel(, labsize(large)) ylabel(, labsize(large))

// Export the graph to pdf, overwriting any existing version.
graph export traceplot.svg, fontface("CMU Serif") replace

// Assuming Inkscape is installed, convert from svg to pdf.
shell "C:\Program Files\inkscape\bin\inkscape.com" --export-type="pdf" ///
   "${path}\traceplot.svg"

// (Optional) Export the graph to other image formats.
// graph export traceplot.eps, fontface("CMU Serif")  // Font not preserved.
// graph export traceplot.jpg, fontface("CMU Serif")
// graph export traceplot.png
// graph export traceplot.ps, fontface("CMU Serif")  // Font not preserved.
// graph export traceplot.tif
