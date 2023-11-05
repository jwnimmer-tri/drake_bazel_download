# SPDX-License-Identifier: MIT-0

# This file is used by WORKSPACE.bazel to probe which Drake binary needs to be
# downloaded. Check the comments in WORKSPACE.bazel for details. If you decide
# to hard-code your WORKSPACE.bazel to a single operating system, then you can
# delete this file.

def _calc_codename(repo_ctx):
    """Returns the Drake binary codename for the current operating system."""
    os_name = repo_ctx.os.name  # "linux" or "mac os x"
    os_arch = repo_ctx.os.arch  # "amd64" or "aarch64"
    if os_name == "linux":
        result = repo_ctx.execute(["/usr/bin/lsb_release", "-sr"])
        if result.return_code != 0:
            fail("Failure during /usr/bin/lsb_release -sr")
        os_release = result.stdout.strip()
        if os_release == "22.04":
            return "jammy"
        elif os_release == "20.04":
            return "focal"
        else:
            fail("Unknown OS release '{}'".format(os_release))
    elif os_name == "mac os x":
        if os_arch == "aarch64":
            return "mac-arm64"
        else:
            return "mac"
    else:
        fail("Unknown OS name '{}'".format(os_name))

def _os_codename_repository_impl(repo_ctx):
    codename = _calc_codename(repo_ctx)
    repo_ctx.file("BUILD.bazel", "")
    repo_ctx.file("defs.bzl", "OS_CODENAME = {}".format(repr(codename)))

os_codename_repository = repository_rule(
    implementation = _os_codename_repository_impl,
    doc = "Provides the OS_CODENAME constant in a defs.bzl file.",
)
