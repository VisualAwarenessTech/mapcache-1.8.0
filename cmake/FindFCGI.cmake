MESSAGE("Specialized FindFCGI Called")

if( NOT $ENV{FCGI_LIBRARY} STREQUAL "" )
  SET(FCGI_LIBRARY  $ENV{FCGI_LIBRARY})

  if( NOT $ENV{FCGI_INCLUDE_DIR} STREQUAL "" )
     SET(FCGI_INCLUDE_DIR  $ENV{FCGI_INCLUDE_DIR})
  else()
     SET(FCGI_INCLUDE_DIR "FCGIIncDir")
  endif()
  SET(FCGI_INCLUDE_DIRS ${FCGI_INCLUDE_DIR})
  SET(FCGI_LIBRARYS ${FCGI_LIBRARY})

  MARK_AS_ADVANCED(FCGI_LIBRARY FCGI_INCLUDE_DIR)
  SET(FCGI_FOUND TRUE)
  MESSAGE("FindFCGI Set By Envionment")

else()
# Look for the header file.
find_path(FCGI_INCLUDE_DIR NAMES fastcgi.h)

# Look for the library.
find_library(FCGI_LIBRARY NAMES fcgi libfcgi)

set(FCGI_INCLUDE_DIRS ${FCGI_INCLUDE_DIR})
set(FCGI_LIBRARIES ${FCGI_LIBRARY})
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(FCGI DEFAULT_MSG FCGI_LIBRARY FCGI_INCLUDE_DIR)
mark_as_advanced(FCGI_LIBRARY FCGI_INCLUDE_DIR)
endif()