## Test environments
* local OS X install, R 3.6.0
* Ubuntu Linux 16.04 LTS, R-release, GCC, R-release and R-devel, via r-hub
* Fedora Linux, R-devel, clang, gfortran, R-release and R-devel, via r-hub
* Windows Server 2008 R2 SP1, R-devel, 32/64 bit, R-release and R-devel, via r-hub

## R CMD check results

0 errors | 0 warnings | 0 note

* Per Message from Prof. Brian Ripley on 2019-04-11 that the package was
failing in a Latin-1 locale, I have replaced en-dashes in the README with
Latin-1 dashes.
