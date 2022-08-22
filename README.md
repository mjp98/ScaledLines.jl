# ScaledLines

[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://mjp98.github.io/ScaledLines.jl/dev)
[![Build Status](https://github.com/mjp98/ScaledLines.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/mjp98/ScaledLines.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/mjp98/ScaledLines.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/mjp98/ScaledLines.jl)

An experimental Julia package implementing line domains extending from $-a\infty$ to $+a\infty$ for use with ApproxFun.jl and application to Wiener--Hopf problems.

Provides a wrapper type `ScaledLine` consisting of a domain and a scale. `stieltjes` is extended from SingularIntegralEquations.jl
