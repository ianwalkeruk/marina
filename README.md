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
* Why 'marina?'

  Because it's a collection of docks, usually grouped together, providing a mixture of features
  depending on the different needs of the boats it services. Also it's quite a nice little name
  and I was pretty surprised it wasn't already in use!

* Who are you?

  I'm a freelance DevOps platform engineer, currently working for a large internet retailer.
 
* Why is it written in PowerShell?

  Because it's what I'm good at. Everything is PowerShell 6 compatible, and so it is
  cross-platform. Feel free to re-write it in something else if it upsets you!
  
* OMG! XML! The noughties called and they want their encoding back.

  See above, regarding 'what I'm good at.' Also, Powershell has an annoying quirk when using
  JSON, that it imports the file as an immutable object that has to be magically handwaved into
  a form suitable for manipulation. Whereas XML support has been in PowerShell since the beginning
  and it's very solid and comprehensive.
  
  There's a very deliberate design decision to explicitly load the configuration into a memory-based
  object, which allows for future expansion into loading alternative formats. If you are manually editing the
  the configuration, then you're doing it wrong.
  
* I am in the 0.00027% of people who think using PowerShell and XML to control Docker is a goood idea.
  What can I do to help?
  
  Write a feature specification for what you want to implement, then add Gherkin functions to the
  steps file to test those specifications. Now run Invoke-Gherkin and add code until it's completely green,
  then send a pull request.
  
  If you haven't worked this way before, it feels a bit weird to write tests for code that doesn't exist
  but once you get the hang of it, you'll (hopefully) find that it keeps you focused on delivering what you
  need and nothing extra.
  
* This has saved my bacon. How can I ever repay you?

  Honestly, I just write this to make my own life easier. If you're in a position of needing
  a freelancer who does this sort of thing, maybe consider hiring me?
  
