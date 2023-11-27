''
write-ghc-environment-files: always

-- index state, to go along with the cabal.project.freeze file. update the index
-- state by running `cabal update` twice and looking at the index state it
-- displays to you (as the second update will be a no-op)
index-state: 2023-11-10T13:47:13Z

-- For some reason the `clash-testsuite` executable fails to run without
-- this, as it cannot find the related library...
tests: True

package clash-ghc
  ghc-options: +RTS -qn4 -A128M -RTS -j4
  executable-dynamic: True

package clash-prelude
  ghc-options: +RTS -qn4 -A128M -RTS -j4
  -- workaround for plugins not loading in Haddock with GHC-8.6
  haddock-options: --optghc=-fdefer-type-errors
  -- Workaround for Haddock/CPP #if issues https://github.com/haskell/haddock/issues/1382
  haddock-options: --optghc="-optP -P"
  -- Don't pollute docs with 1024 SNat literals
  haddock-options: --optghc=-DHADDOCK_ONLY

  -- Tweak haddock stylesheet to enable word wrapping of types.
  -- We specify the default Linuwial theme as an alnernate
  -- so we're able to import its css file from the custom theme.
  haddock-options: --theme=doc/linuwial-wrap-types.css --theme=Linuwial

package clash-testsuite
  flags: +cosim

package clash-lib
  ghc-options: +RTS -qn4 -A128M -RTS -j4
  flags: +debug

package clash-cores
  -- Tweak haddock stylesheet to enable word wrapping of types.
  -- We specify the default Linuwial theme as an alnernate
  -- so we're able to import its css file from the custom theme.
  haddock-options: --theme=doc/linuwial-wrap-types.css --theme=Linuwial

package clash-benchmark
  executable-dynamic: True

allow-newer:
    brick:base
  , rewrite-inspector:brick
  , rewrite-inspector:hashable
  , tasty-hedgehog:tasty

-- Works around: https://github.com/recursion-schemes/recursion-schemes/issues/128. This
-- shouldn't harm (runtime) performance of Clash, as we only use recursion-schemes with
-- TemplateHaskell.
package recursion-schemes
    optimization: 0

package regex-tdfa
    optimization: 2

-- there are no top level packages. any package can be checked out under the
-- root directory (i.e. patched copies, or forks) and will automatically be
-- preferred by the solver over other versions.
''
