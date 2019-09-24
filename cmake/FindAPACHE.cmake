#
#  APACHE_FOUND - System has APACHE
#  APACHE_INCLUDE_DIR - The APACHE include directory
#
#  APACHE_LOCATION
#   setting this enables search for apache libraries / headers in this location

#
# Include directories
#
MESSAGE("Specialized FindGeos Called")

if( NOT $ENV{APACHE_LIBRARY} STREQUAL "" )
  SET(APACHE_LIBRARY  $ENV{APACHE_LIBRARY})

  if( NOT $ENV{APACHE_INCLUDE_DIR} STREQUAL "" )
     SET(APACHE_INCLUDE_DIR  $ENV{APACHE_INCLUDE_DIR})
  else()
     SET(APACHE_INCLUDE_DIR "ApacheIncDir")
  endif()
  SET(APACHE_INCLUDE_DIRS ${APACHE_INCLUDE_DIR})
  SET(APACHE_LIBRARYS ${APACHE_LIBRARY})

  if( NOT $ENV{APACHE_MODULE_DIR} STREQUAL "" )
     SET(APACHE_MODULE_DIR  $ENV{APACHE_MODULE_DIR})
  else()
     SET(APACHE_MODUL_DIR "ApacheMODULEDir")
  endif()
 
  MARK_AS_ADVANCED(APACHE_LIBRARY APACHE_INCLUDE_DIR)
  SET(APACHE_FOUND TRUE)
  MESSAGE("FindAPACHE Set By Envionment")

else()

find_path(APACHE_INCLUDE_DIR
          NAMES httpd.h 
          PATH_SUFFIXES httpd apache apache2 apache22 apache24
)

if(NOT DEFINED APACHE_MODULE_DIR)
   find_program(APXS_BIN NAMES apxs apxs2
             PATH_SUFFIXES httpd apache apache2
   )

   if(APXS_BIN)
      EXEC_PROGRAM(${APXS_BIN}
         ARGS -q LIBEXECDIR
         OUTPUT_VARIABLE APACHE_MODULE_DIR )
   endif(APXS_BIN)
endif(NOT DEFINED APACHE_MODULE_DIR)

include(FindPackageHandleStandardArgs)
# handle the QUIETLY and REQUIRED arguments and set APACHE_FOUND to TRUE if 
# all listed variables are TRUE
find_package_handle_standard_args(APACHE DEFAULT_MSG APACHE_INCLUDE_DIR )
mark_as_advanced(APACHE_INCLUDE_DIR)

endif()