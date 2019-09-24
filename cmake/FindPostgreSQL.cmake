# - Find PostgreSQL
# Find the PostgreSQL includes and client library
# This module defines
#  POSTGRESQL_INCLUDE_DIR, where to find POSTGRESQL.h
#  POSTGRESQL_LIBRARY, the libraries needed to use POSTGRESQL.
#  POSTGRESQL_FOUND, If false, do not try to use PostgreSQL.
#
# Copyright (c) 2013 Thomas Bonfort, Andy Colson
#
MESSAGE("Specialized FindPostGRESQL Called")

if( NOT $ENV{POSTGRESQL_LIBRARY} STREQUAL "" )
  SET(PostgreSQL_LIBRARY $ENV{POSTGRESQL_LIBRARY})
  MESSAGE("FindPostGRESQL Setting POSTGRESQL_LIBRARY =" ${PostgreSQL_LIBRARY})

  if( NOT $ENV{POSTGRESQL_INCLUDE_DIR} STREQUAL "" )
     SET(PostgreSQL_INCLUDE_DIR $ENV{PostgreSQL_INCLUDE_DIR})
  else()
     SET(PostgreSQL_INCLUDE_DIR "PostGreSQLIncDir")
  endif()
  SET(PostgreSQL_INCLUDE_DIRS ${PostgreSQL_INCLUDE_DIR})
  SET(PostgreSQL_LIBRARIES ${PostgreSQL_LIBRARY})

  MARK_AS_ADVANCED(PostgreSQL_LIBRARY PostgreSQL_INCLUDE_DIR)

  MESSAGE("FindPostGRESQL POSTGRESQL_LIBRARY " ${PostgreSQL_LIBRARY})
  MESSAGE("FindPostGRESQL POSTGRESQL_INCLUDE_DIR " ${PostgreSQL_INCLUDE_DIR})

  SET(PostgreSQL_FOUND TRUE)
  MESSAGE("FindPostGRESQL Set By Envionment")

else()

find_program(PG_CONFIG NAMES pg_config
   PATHS
   $ENV{ProgramFiles}/PostgreSQL/*/bin
   $ENV{SystemDrive}/PostgreSQL/*/bin
)

if (PG_CONFIG)
   exec_program( ${PG_CONFIG} ARGS "--includedir" OUTPUT_VARIABLE PG_INC_PATH )
   exec_program( ${PG_CONFIG} ARGS "--libdir" OUTPUT_VARIABLE PG_LIB_PATH )
else()
   message(WARNING "pg_config not found, will try some defaults")
endif()

find_path(POSTGRESQL_INCLUDE_DIR libpq-fe.h
  ${PG_INC_PATH}
  /usr/include/server
  /usr/include/postgresql
  /usr/include/pgsql/server
  /usr/local/include/pgsql/server
  /usr/include/postgresql/server
  /usr/include/postgresql/*/server
  /usr/local/include/postgresql/server
  /usr/local/include/postgresql/*/server
  $ENV{ProgramFiles}/PostgreSQL/*/include/server
  $ENV{SystemDrive}/PostgreSQL/*/include/server
)

find_library(POSTGRESQL_LIBRARY NAMES pq libpq
  PATHS
  ${PG_LIB_PATH}
  /usr/lib
  /usr/local/lib
  /usr/lib/postgresql
  /usr/lib64
  /usr/local/lib64
  /usr/lib64/postgresql
  $ENV{ProgramFiles}/PostgreSQL/*/lib/ms
  $ENV{SystemDrive}/PostgreSQL/*/lib/ms
)

set(POSTGRESQL_INCLUDE_DIRS ${POSTGRESQL_INCLUDE_DIR})
set(POSTGRESQL_LIBRARIES ${POSTGRESQL_LIBRARY})
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(POSTGRESQL DEFAULT_MSG POSTGRESQL_LIBRARY POSTGRESQL_INCLUDE_DIR)
mark_as_advanced(POSTGRESQL_LIBRARY POSTGRESQL_INCLUDE_DIR)

endif()