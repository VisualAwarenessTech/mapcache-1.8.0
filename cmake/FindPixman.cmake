MESSAGE("Specialized FindProg Called")
if( NOT $ENV{PIXMAN_LIBRARY} STREQUAL "" )
  SET(PIXMAN_LIBRARY $ENV{PIXMAN_LIBRARY})

  if( NOT $ENV{PIXMAN_INCLUDE_DIR} STREQUAL "" )
     SET(PIXMAN_INCLUDE_DIR $ENV{PIXMAN_INCLUDE_DIR})
  else()
     SET(PIXMAN_INCLUDE_DIR "PixmanIncludeDir")
  endif()
  SET(PIXMAN_FOUND TRUE)
  MESSAGE("FindPixman Set By Envionment")

else()

FIND_PACKAGE(PkgConfig)
PKG_CHECK_MODULES(PC_PIXMAN pixman) 
if(NOT PC_PIXMAN_FOUND)
  PKG_CHECK_MODULES(PC_PIXMAN pixman-1)
endif(NOT PC_PIXMAN_FOUND)
 

FIND_PATH(PIXMAN_INCLUDE_DIR
    NAMES pixman.h
    HINTS ${PC_PIXMAN_INCLUDEDIR}
          ${PC_PIXMAN_INCLUDE_DIR}
    PATH_SUFFIXES pixman pixman-1
)

FIND_LIBRARY(PIXMAN_LIBRARY
    NAMES pixman pixman-1
    HINTS ${PC_PIXMAN_LIBDIR}
          ${PC_PIXMAN_LIBRARY_DIRS}
)
endif()

set(PIXMAN_INCLUDE_DIRS ${PIXMAN_INCLUDE_DIR})
set(PIXMAN_LIBRARIES ${PIXMAN_LIBRARY})
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(PIXMAN DEFAULT_MSG PIXMAN_LIBRARY PIXMAN_INCLUDE_DIR)
mark_as_advanced(PIXMAN_LIBRARY PIXMAN_INCLUDE_DIR)
