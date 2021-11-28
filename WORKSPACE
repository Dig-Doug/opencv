workspace(name = "opencv_archive")

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

http_archive(
    name = "bazel_skylib",
    sha256 = "c6966ec828da198c5d9adbaa94c05e3a1c7f21bd012a0b29ba8ddbccb2c93b0d",
    urls = [
        "https://github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-skylib/releases/download/1.1.1/bazel-skylib-1.1.1.tar.gz",
    ],
)

local_repository(
    name = "rules_foreign_cc",
    path = "/home/doug/Development/thirdparty/rules_foreign_cc",
)
#http_archive(
#    name = "rules_foreign_cc",
#    sha256 = "73737d50f2908c77e431946cfba41bad7c2530b602efb974cdc3cbc5dcd068f0",
#    strip_prefix = "rules_foreign_cc-32e222aeff1220605b80b9c36377db27e7a76555",
#    urls = [
#        "https://github.com/bazelbuild/rules_foreign_cc/archive/32e222aeff1220605b80b9c36377db27e7a76555.tar.gz",
#    ],
#)

load("@rules_foreign_cc//foreign_cc:repositories.bzl", "rules_foreign_cc_dependencies")

rules_foreign_cc_dependencies()

load("//bazel:configure.bzl", "OPENCV_ALL_MODULES", "opencv_configure")

opencv_configure(
    name = "opencv",
    modules = OPENCV_ALL_MODULES,
)
