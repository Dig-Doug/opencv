load("@bazel_tools//tools/build_defs/repo:utils.bzl", "maybe")
load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

OPENCV_MODULE_CORE = "core"
OPENCV_MODULE_FLANN = "flann"
OPENCV_MODULE_IMGPROC = "imgproc"
OPENCV_MODULE_ML = "ml"
OPENCV_MODULE_PHOTO = "photo"
OPENCV_MODULE_DNN = "dnn"
OPENCV_MODULE_IMGCODECS = "imgcodecs"
OPENCV_MODULE_VIDEOIO = "videoio"
OPENCV_MODULE_HIGHGUI = "highgui"
OPENCV_MODULE_FEATURES2D = "features2d"
OPENCV_MODULE_CALIB3D = "calib3d"
OPENCV_MODULE_OBJDETECT = "objdetect"
OPENCV_MODULE_STITCHING = "stitching"
OPENCV_MODULE_VIDEO = "video"

OPENCV_ALL_MODULES = [
    OPENCV_MODULE_CORE,
    OPENCV_MODULE_FLANN,
    OPENCV_MODULE_IMGPROC,
    OPENCV_MODULE_ML,
    OPENCV_MODULE_PHOTO,
    OPENCV_MODULE_DNN,
    OPENCV_MODULE_IMGCODECS,
    OPENCV_MODULE_VIDEOIO,
    OPENCV_MODULE_HIGHGUI,
    OPENCV_MODULE_FEATURES2D,
    OPENCV_MODULE_CALIB3D,
    OPENCV_MODULE_OBJDETECT,
    OPENCV_MODULE_STITCHING,
    OPENCV_MODULE_VIDEO,
]

def _opencv_configure(rctx):
    for module in rctx.attr.modules:
        if module not in OPENCV_ALL_MODULES:
            fail("Invalid module: %s -- Is there a typo? Try using one of the constants instead of a string, e.g. OPENCV_MODULE_IMGPROC")

    entries = []
    shared_libs = []
    for module in OPENCV_ALL_MODULES:
        value = "OFF"
        if module in rctx.attr.modules:
            value = "ON"
            shared_libs.append('"libopencv_%s.so.%s"' % (module, rctx.attr.version))
        entries.append('"BUILD_opencv_%s": "%s"' % (module, value))

    rctx.template(
        "BUILD.bazel",
        Label("//bazel:BUILD.bazel.tpl"),
        {
            '"%{cache_key}": "%{cache_value}"': ",\n        ".join(entries),
            '"%{shared_libs}"': ",\n        ".join(shared_libs),
        },
    )

opencv_configure = repository_rule(
    implementation = _opencv_configure,
    attrs = {
        "modules": attr.string_list(
            default = [
                OPENCV_MODULE_CORE,
            ],
            doc = "List of modules to build",
        ),
        # TODO: Can we detect this version?
        "version" : attr.string(
            default = "4.5",
            doc = "The opencv version",
        )
    },
)
