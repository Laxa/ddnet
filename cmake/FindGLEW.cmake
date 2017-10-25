find_package(PkgConfig QUIET)
pkg_check_modules(PC_GLEW libglew)

set_extra_dirs_lib(GLEW glew)
find_library(GLEW_LIBRARY
  NAMES GLEW glew32
  HINTS ${HINTS_GLEW_LIBDIR} ${PC_GLEW_LIBDIR} ${PC_GLEW_LIBRARY_DIRS}
  PATHS ${PATHS_GLEW_LIBDIR}
)
set_extra_dirs_include(GLEW glew "${GLEW_LIBRARY}")
find_path(GLEW_INCLUDEDIR GL
  HINTS ${HINTS_GLEW_INCLUDEDIR} ${PC_GLEW_INCLUDEDIR} ${PC_GLEW_INCLUDE_DIRS}
  PATHS ${PATHS_GLEW_INCLUDEDIR}
)

include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(GLEW DEFAULT_MSG GLEW_LIBRARY GLEW_INCLUDEDIR)

mark_as_advanced(GLEW_LIBRARY GLEW_INCLUDEDIR)

set(GLEW_LIBRARIES ${GLEW_LIBRARY})
set(GLEW_INCLUDE_DIRS ${GLEW_INCLUDEDIR})

is_bundled(IS_BUNDLED "${GLEW_LIBRARY}")
if(IS_BUNDLED AND TARGET_OS STREQUAL "windows")
  set(GLEW_COPY_FILES "${EXTRA_GLEW_LIBDIR}/glew32.dll")
else()
  set(GLEW_COPY_FILES)
endif()
