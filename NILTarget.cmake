include(CMakeParseArguments)

find_program(OPENOCD openocd)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

cmake_policy(SET CMP0005 NEW)

MACRO( nil_target_module )

SET(BOOTLOADER_TARGET 1)

cmake_parse_arguments( CORE_TARGET "" "MODULE;NAME;OS_VERSION" "OS_COMPONENTS" ${ARGN} )
IF( CORE_TARGET_UNPARSED_ARGUMENTS )
  MESSAGE( FATAL_ERROR "CORE_TARGET_MODULE() called with unused arguments: ${CORE_TARGET_UNPARSED_ARGUMENTS}" )
ENDIF()

ENABLE_LANGUAGE( ASM )

MESSAGE( STATUS "NIL Target Target Module: ${CORE_TARGET_MODULE}" )
MESSAGE( STATUS "NIL Target Target Name: ${CORE_TARGET_NAME}" )
MESSAGE( STATUS "NIL Target Target OS Version: ${CORE_TARGET_OS_VERSION}" )

IF( "${CORE_TARGET_NAME}" STREQUAL "" )
  SET( MODULE_NAME "${CMAKE_PROJECT_NAME}" )
ELSE()
  SET( MODULE_NAME "${CORE_TARGET_NAME}" )
ENDIF()

MESSAGE( STATUS "NIL Target Target Module Name: ${MODULE_NAME}" )

FIND_PACKAGE( WORKSPACE_MODULES CONFIG COMPONENTS ${CORE_TARGET_MODULE} REQUIRED )

IF( CORE_TARGET_OS_COMPONENTS )
  LIST( APPEND MODULE_CHIBIOS_REQUIRED_COMPONENTS ${CORE_TARGET_OS_COMPONENTS} )
ENDIF()

LIST( REMOVE_DUPLICATES MODULE_CHIBIOS_REQUIRED_COMPONENTS )

IF("${CORE_TARGET_OS_VERSION}" STREQUAL "CHIBIOS_3")
  FIND_PACKAGE(ChibiOS 3 COMPONENTS ${MODULE_CHIBIOS_REQUIRED_COMPONENTS} REQUIRED)
ELSEIF("${CORE_TARGET_OS_VERSION}" STREQUAL "CHIBIOS_16")
  FIND_PACKAGE(ChibiOS 16 COMPONENTS ${MODULE_CHIBIOS_REQUIRED_COMPONENTS} REQUIRED)
ENDIF()
  
INCLUDE_DIRECTORIES(
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${ChibiOS_INCLUDE_DIRS}
    ${WORKSPACE_MODULES_INCLUDES}
    ${PROJECT_INCLUDE_DIRECTORIES}
)

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

ADD_DEFINITIONS(-DCORE_MODULE_NAME="${MODULE_NAME}")

IF(STM32_FAMILY STREQUAL "F3")
    ADD_DEFINITIONS(-DCORTEX_USE_FPU=FALSE)
ELSEIF(STM32_FAMILY STREQUAL "F4")
    ADD_DEFINITIONS(-DCORTEX_USE_FPU=FALSE)
ELSE()
    ADD_DEFINITIONS(-DCORTEX_USE_FPU=FALSE)
ENDIF()
ADD_DEFINITIONS(-D${STM32_CHIP})

ADD_DEFINITIONS(-DSTOP_IWDG_ON_DEBUG)

SET(STM32_LINKER_SCRIPT ${ChibiOS_LINKER_SCRIPT})

set(SOURCE_FILES
  ${WORKSPACE_MODULES_SOURCES}
  ${ChibiOS_SOURCES}
  ${PROJECT_SOURCES}
)

add_executable("firmware"
  ${SOURCE_FILES}
)

MESSAGE( STATUS "SOURCE_FILES: ${SOURCE_FILES}" )


TARGET_LINK_LIBRARIES("firmware")

STM32_SET_TARGET_PROPERTIES("firmware")
STM32_ADD_HEX_BIN_TARGETS("firmware")
STM32_PRINT_SIZE_OF_TARGETS("firmware")

IF(OPENOCD)
  IF(STM32_FAMILY STREQUAL "F0")
      SET(TARGET_FILE "stm32f0x_stlink.cfg")
  ELSEIF(STM32_FAMILY STREQUAL "F3")
      SET(TARGET_FILE "stm32f3x_stlink.cfg")
  ELSEIF(STM32_FAMILY STREQUAL "F4")
      SET(TARGET_FILE "stm32f4x_stlink.cfg")
  ELSE()
      SET(TARGET_FILE "- none -")
  ENDIF()
  
  MESSAGE( STATUS "openocd found: ${OPENOCD}" )
  MESSAGE( STATUS "openocd target file: ${TARGET_FILE}" )
  IF(TARGET_FILE STREQUAL "- none -")
    MESSAGE( STATUS "Skipping..." )
  ELSE()
      add_custom_target(flash
        DEPENDS firmware
        COMMAND ${OPENOCD} -f 'interface/stlink-v2.cfg' -f 'target/${TARGET_FILE}'
          -c 'init'
          -c 'reset init'
          -c 'halt'
          -c 'flash write_image erase firmware'
          -c 'shutdown'
      )
  ENDIF()
ENDIF()

ENDMACRO()
