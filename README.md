# marina
A framework for maintaining mutiple Docker image builds in a moderately sane way

## Rationale
Maintaining a set of container images for a large organisation can easily become
a headache. It only needs two teams to be on different versions of a build tool and
arguments about what should be in a "core" image versus a "team" or "dev" image will
start to crop up. The trade-off between maintainability and flexibility is non-trivial.

Marina aims to solve that problem by providing a way to end the arguments through capturing
the various dependencies and automatically generating every viable Dockerfile so that a CI
tool can follow up and create every viable image. Effectively the approach is to make
maintaining multiple images simple, allowing the balance to tip over to flexibility.

## FAQ
* Who are you?

  I'm a freelance DevOps platform engineer, currently working for a large internet retailer.
 
* Why is it written in PowerShell?

  Because it's what I'm good at. Everything is PowerShell 6 compatible, and so it is
  cross-platform. Feel free to re-write it in something else if it upsets you!
  
* This has saved my bacon. How can I ever repay you?

  Honestly, I just write this to make my own life easier. If you're in a position of needing
  a freelancer who does this sort of thing, maybe consider hiring me?
  