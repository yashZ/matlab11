Author: Finale Doshi-Velez, finale@alum.mit.edu

Maintaining author: Finale Doshi-Velez, finale@alum.mit.edu
With significant input and debugging from Jurgen Van Gael and Kurt Miller
      
Requests: 
  * Please don't use this code for commercial applications without asking first.
  * Feedback welcome.
  * Bug fixes very welcome :)  

Contents: these files allow one to play with just solving a POMDP
using PBVI and testing the solution.  The PBVI implementation has been
optimized to take advantage of Matlab vectorization tricks.  The files
are:
* initDialogSkewed -- creates a model struct
* SampleBeliefs -- creates a supporting belief set
  -- uses SampleDist to sample multinomials
* RunPBVILean -- solves the POMDP model
* pbviTester -- simulates the POMDP model solution
  -- uses episodeEnded to determine when a trial is complete
  -- uses GetAction to select an action given a belief, V
  -- uses sampleDist to choose observations
The POMDP format is very similar to Spaan's Matlab POMDP format used
in his Perseus implementation.

Notes: This code has been extensively used, but I make no promises
about bugs.  Use at your own risk!  I will try to fix bugs as time
allows.
