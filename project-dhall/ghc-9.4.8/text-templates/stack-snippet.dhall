\(_stackage-resolver : Optional Text) ->
  ''
  user-message: "WARNING: This stack project is generated."

  ghc-options:
    "$locals": -fhide-source-paths
    clash-ghc: +RTS -qn4 -A128M -RTS -j4
    clash-prelude: +RTS -qn4 -A128M -RTS -j4
    clash-lib: +RTS -qn4 -A128M -RTS -j4
    recursion-schemes: -O0
    regex-tdfa: -O2

  flags:
    clash-lib:
      debug: true
    clash-testsuite:
      cosim: true

  allow-newer: true
  allow-newer-deps:
    - brick
    - rewrite-inspector
    - tasty-hedgehog
  ''
