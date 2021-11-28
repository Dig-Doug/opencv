package(default_visibility = ["//visibility:public"])

load("@rules_foreign_cc//foreign_cc:defs.bzl", "cmake")

cmake(
    name = "opencv",
    cache_entries = {
        "CMAKE_BUILD_TYPE": "Release",
        "ENABLE_PRECOMPILED_HEADERS": "OFF",
        "BUILD_SHARED_LIBS": "ON",
        "%{cache_key}": "%{cache_value}",
    },
    lib_source = "@opencv_archive//:all_files",
    out_include_dir = "include/opencv4",
    out_shared_libs = [
        "%{shared_libs}",
    ],
)
