# Bazel Project using automatically downloaded Drake binaries

This project demonstrates how to use a
[precompiled binary build of Drake](https://drake.mit.edu/from_binary.html)
automatically downloaded via Bazel.

For an introduction to Bazel, refer to
[Getting Started with Bazel](https://bazel.build/start).

## Pre-requisites

You must be using one of Drake's
[Supported Configurations](https://drake.mit.edu/installation.html#supported-configurations).

You must have already installed Bazel or Bazelisk.

The commands given in these instructions assume that your working directory is
`drake-external-examples/drake_bazel_download`.

## Setup

Install the required system packages:

```
bazel run //:install_prereqs
```

## Build

To build and test all apps:
```
bazel test //...
```

As an example to run a binary directly:
```
bazel run //apps:simple_logging_example
```

You may also run the binary directly per the `bazel-bin/...` path that the
above command prints out; however, be aware that your working directories may
cause differences.  This is important when using tools like
`drake::FindResource` / `pydrake.common.FindResource`.
You may generally want to stick to using `bazel run` when able.
