MESSAGE( STATUS "CHIBIOS_ROOT: ${CHIBIOS_ROOT}" )
SET(FATFS ${CHIBIOS_ROOT}/ext/fatfs)

IF( NOT EXISTS ${FATFS})
  MESSAGE( FATAL_ERROR "${FATFS} does not exists. Have you extracted the archive there?" )
ENDIF()

SET(FATFSSRC
	${FATFS}/src/ff.c
	${FATFS}/src/option/unicode.c
)

SET(FATFSBINDINGSSRC
	${CHIBIOS_ROOT}/os/various/fatfs_bindings/fatfs_diskio.c
	${CHIBIOS_ROOT}/os/various/fatfs_bindings/fatfs_syscall.c
)

SET(FATFS_SOURCES ${FATFSSRC} ${FATFSBINDINGSSRC})

SET( FATFS_INCLUDE_DIRS
        ${CHIBIOS_ROOT}/os/various/fatfs_bindings
        ${FATFS}/src
)

LIST( REMOVE_DUPLICATES FATFS_SOURCES )
LIST( REMOVE_DUPLICATES FATFS_INCLUDE_DIRS )

INCLUDE( FindPackageHandleStandardArgs )
FIND_PACKAGE_HANDLE_STANDARD_ARGS( FATFS DEFAULT_MSG FATFS_SOURCES FATFS_INCLUDE_DIRS )
