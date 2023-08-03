# libxslt-config.cmake
# --------------------
#
# libxlst CMake module.
# This module sets the following variables:
#
# ::
#
#   LIBXSLT_INCLUDE_DIR         - directory where libxslt headers are located
#   LIBXSLT_INCLUDE_DIRS        - list of the include directories needed to use libxslt
#   LIBXSLT_LIBRARY             - path to the libxslt library
#   LIBXSLT_LIBRARIES           - xslt libraries to link against
#   LIBXSLT_DEFINITIONS         - the compiler switches required for using libxslt
#   LIBXSLT_VERSION_MAJOR       - the major version of libxslt
#   LIBXSLT_VERSION_MINOR       - the minor version of libxslt
#   LIBXSLT_VERSION_PATCH       - the patch version of libxslt
#   LIBXSLT_VERSION             - libxslt version number as a string (ex: "1.1.34")
#   LIBXSLT_XSLTPROC_EXECUTABLE - path to xsltproc
#
#   LIBXSLT_EXSLT_INCLUDE_DIR   - directory where libexslt headers are located
#   LIBXSLT_EXSLT_INCLUDE_DIRS  - list of the include directories needed to use libexslt
#   LIBXSLT_EXSLT_LIBRARY       - path to the libexslt library
#   LIBXSLT_EXSLT_LIBRARIES     - exslt libraries to link against
#   LIBXSLT_EXSLT_DEFINITIONS   - the compiler switches required for using libexslt
#   LIBEXSLT_VERSION_MAJOR      - the major version of libexslt
#   LIBEXSLT_VERSION_MINOR      - the minor version of libexslt
#   LIBEXSLT_VERSION_PATCH      - the patch version of libexslt
#   LIBEXSLT_VERSION            - libexslt version number as a string (ex: "0.8.20")
#
# The following targets are defined:
#
#   LibXslt::LibXslt            - the libxslt library
#   LibXslt::LibExslt           - the libexslt library
#   LibXslt::xsltproc           - the xsltproc command-line executable

set(LIBXSLT_VERSION "1.1.35")
set(LIBXSLT_VERSION_MAJOR "1")
set(LIBXSLT_VERSION_MINOR "1")
set(LIBXSLT_VERSION_PATCH "35")

set(LIBEXSLT_VERSION "0.8.20")
set(LIBEXSLT_VERSION_MAJOR "0")
set(LIBEXSLT_VERSION_MINOR "8")
set(LIBEXSLT_VERSION_PATCH "20")

get_filename_component(PACKAGE_PREFIX_DIR ${CMAKE_CURRENT_LIST_DIR}/../../../ ABSOLUTE)

set(LIBXSLT_DEFINITIONS "")
set(LIBXSLT_INCLUDE_DIR "${PACKAGE_PREFIX_DIR}/include")
set(LIBXSLT_LIBRARY_DIR "${PACKAGE_PREFIX_DIR}/lib")
set(LIBXSLT_EXSLT_DEFINITIONS "")
set(LIBXSLT_EXSLT_INCLUDE_DIR "${PACKAGE_PREFIX_DIR}/include")
set(LIBXSLT_EXSLT_LIBRARY_DIR "${PACKAGE_PREFIX_DIR}/lib")

find_library(LIBXSLT_LIBRARY NAMES xslt HINTS ${LIBXSLT_LIBRARY_DIR} NO_DEFAULT_PATH)
find_library(LIBXSLT_EXSLT_LIBRARY NAMES exslt HINTS ${LIBXSLT_EXSLT_LIBRARY_DIR} NO_DEFAULT_PATH)
find_program(LIBXSLT_XSLTPROC_EXECUTABLE NAMES xsltproc HINTS ${PACKAGE_PREFIX_DIR}/bin NO_DEFAULT_PATH)

set(LIBXSLT_INCLUDE_DIRS ${LIBXSLT_INCLUDE_DIR})
set(LIBXSLT_LIBRARIES ${LIBXSLT_LIBRARY})
set(LIBXSLT_EXSLT_INCLUDE_DIRS ${LIBXSLT_EXSLT_INCLUDE_DIR})
set(LIBXSLT_EXSLT_LIBRARIES ${LIBXSLT_EXSLT_LIBRARY})
unset(LIBXSLT_INTERFACE_LINK_LIBRARIES)
unset(LIBXSLT_EXSLT_INTERFACE_LINK_LIBRARIES)

include(CMakeFindDependencyMacro)

set(LIBXSLT_WITH_CRYPTO 0)

find_dependency(LibXml2 CONFIG)
list(APPEND LIBXSLT_INCLUDE_DIRS ${LIBXML2_INCLUDE_DIRS})
list(APPEND LIBXSLT_LIBRARIES ${LIBXML2_LIBRARIES})
list(APPEND LIBXSLT_INTERFACE_LINK_LIBRARIES "LibXml2::LibXml2")

if(LIBXSLT_WITH_CRYPTO)
	list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_LIST_DIR})
	find_dependency(Gcrypt)
	list(APPEND LIBXSLT_EXSLT_LIBRARIES ${GCRYPT_LIBRARIES})
	list(APPEND LIBXSLT_EXSLT_INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:Gcrypt::Gcrypt>")
endif()

if(UNIX)
	list(APPEND LIBXSLT_LIBRARIES m)
	list(APPEND LIBXSLT_INTERFACE_LINK_LIBRARIES "\$<LINK_ONLY:m>")
endif()

list(APPEND LIBXSLT_EXSLT_INCLUDE_DIRS ${LIBXSLT_INCLUDE_DIRS})
list(APPEND LIBXSLT_EXSLT_LIBRARIES ${LIBXSLT_LIBRARIES})
list(APPEND LIBXSLT_EXSLT_INTERFACE_LINK_LIBRARIES "LibXslt::LibXslt")

mark_as_advanced(LIBXSLT_LIBRARY LIBXSLT_EXSLT_LIBRARY LIBXSLT_XSLTPROC_EXECUTABLE)

if(NOT TARGET LibXslt::LibXslt AND DEFINED LIBXSLT_LIBRARY AND DEFINED LIBXSLT_INCLUDE_DIRS)
  add_library(LibXslt::LibXslt UNKNOWN IMPORTED)
  set_target_properties(LibXslt::LibXslt PROPERTIES IMPORTED_LOCATION "${LIBXSLT_LIBRARY}")
  set_target_properties(LibXslt::LibXslt PROPERTIES INTERFACE_COMPILE_OPTIONS "${LIBXSLT_DEFINITIONS}")
  set_target_properties(LibXslt::LibXslt PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${LIBXSLT_INCLUDE_DIRS}")
  set_target_properties(LibXslt::LibXslt PROPERTIES INTERFACE_LINK_LIBRARIES "${LIBXSLT_INTERFACE_LINK_LIBRARIES}")
endif()

if(NOT TARGET LibXslt::LibExslt AND DEFINED LIBXSLT_EXSLT_LIBRARY AND DEFINED LIBXSLT_EXSLT_INCLUDE_DIRS)
  add_library(LibXslt::LibExslt UNKNOWN IMPORTED)
  set_target_properties(LibXslt::LibExslt PROPERTIES IMPORTED_LOCATION "${LIBXSLT_EXSLT_LIBRARY}")
  set_target_properties(LibXslt::LibExslt PROPERTIES INTERFACE_COMPILE_OPTIONS "${LIBXSLT_EXSLT_DEFINITIONS}")
  set_target_properties(LibXslt::LibExslt PROPERTIES INTERFACE_INCLUDE_DIRECTORIES "${LIBXSLT_EXSLT_INCLUDE_DIRS}")
  set_target_properties(LibXslt::LibExslt PROPERTIES INTERFACE_LINK_LIBRARIES "${LIBXSLT_EXSLT_INTERFACE_LINK_LIBRARIES}")
endif()

if(NOT TARGET LibXslt::xsltproc AND DEFINED LIBXSLT_XSLTPROC_EXECUTABLE)
  add_executable(LibXslt::xsltproc IMPORTED)
  set_target_properties(LibXslt::xsltproc PROPERTIES IMPORTED_LOCATION "${LIBXSLT_XSLTPROC_EXECUTABLE}")
endif()
