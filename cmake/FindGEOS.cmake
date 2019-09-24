# Find the native GEOS(Geometry Engine - Open Source) includes and libraries.
#
# This module defines:
#
# GEOS_INCLUDE_DIR, where to find geos.h, etc.
# GEOS_LIBRARY, libraries to link against to use GEOS, using the geos_c library
# GEOS_FOUND, True if found, false if one of the above are not found.

#---
# Find include path:
# Note: Version < 3.3.0 do not have geos.h in the geos sub directory; hence,
# the check for both "geos/geos.h" and "geos.h".
#---
MESSAGE("Specialized FindGeos Called")

if( NOT $ENV{GEOS_LIBRARY} STREQUAL "" )
  SET(GEOS_LIBRARY  $ENV{GEOS_LIBRARY})

  if( NOT $ENV{GEOS_INCLUDE_DIR} STREQUAL "" )
     SET(GEOS_INCLUDE_DIR  $ENV{GEOS_INCLUDE_DIR})
  else()
     SET(GEOS_INCLUDE_DIR "GeosIncDir")
  endif()
  SET(GEOS_INCLUDE_DIRS ${GEOS_INCLUDE_DIR})
  SET(GEOS_LIBRARYS ${GEOS_LIBRARY})

  MARK_AS_ADVANCED(GEOS_LIBRARY GEOS_INCLUDE_DIR)
  SET(GEOS_FOUND TRUE)
  MESSAGE("FindGeos Set By Envionment")

else()

find_path( GEOS_INCLUDE_DIR geos_c.h
           PATHS 
           /usr/include
           /usr/local/include
           SUFFIXES geos)

# Find GEOS C library:
find_library( GEOS_LIBRARY NAMES geos_c geos_c_i
              PATHS 
              /usr/lib64 
              /usr/lib 
              /usr/local/lib )

set(GEOS_INCLUDE_DIRS ${GEOS_INCLUDE_DIR})
set(GEOS_LIBRARIES ${GEOS_LIBRARY})
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args( GEOS DEFAULT_MSG 
                                   GEOS_LIBRARY 
                                   GEOS_INCLUDE_DIR )

MARK_AS_ADVANCED(GEOS_LIBRARY GEOS_INCLUDE_DIR)

endif()
