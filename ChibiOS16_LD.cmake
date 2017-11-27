IF(NOT CHIBIOS_PROCESS_STACK_SIZE)
  SET(CHIBIOS_PROCESS_STACK_SIZE 0x400)
  MESSAGE(STATUS "No CHIBIOS_PROCESS_STACK_SIZE specified, using default: ${CHIBIOS_PROCESS_STACK_SIZE}")
ENDIF()

IF(NOT CHIBIOS_MAIN_STACK_SIZE)
  SET(CHIBIOS_MAIN_STACK_SIZE 0x400)
  MESSAGE(STATUS "No CHIBIOS_MAIN_STACK_SIZE specified, using default: ${CHIBIOS_MAIN_STACK_SIZE}")
ENDIF()

IF(USE_SPECS)
  MESSAGE(STATUS "Using ${USE_SPECS}")
  SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -specs ${USE_SPECS}")
ENDIF()

SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -L\"${CHIBIOS_ROOT}/os/common/ports/ARMCMx/compilers/GCC\"")
SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--defsym=__process_stack_size__=${CHIBIOS_PROCESS_STACK_SIZE}")
SET(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -Wl,--defsym=__main_stack_size__=${CHIBIOS_MAIN_STACK_SIZE}")

IF(NOT BOOTLOADER_SIZE)
  SET(BOOTLOADER_SIZE 0)
ENDIF()

IF(NOT CONFIGURATION_SIZE)
  SET(CONFIGURATION_SIZE 0)
ENDIF()

IF(NOT TAGS_SIZE)
  MESSAGE(STATUS "No TAGS_SIZE specified, using default: 0")
  SET(TAGS_SIZE 0)
ENDIF()

# Auto-generate linker script
IF(NOT ChibiOS_LINKER_SCRIPT)
  IF(BOOTLOADER_SIZE GREATER 0)
    IF(BOOTLOADER_TARGET)
      FILE(WRITE ${CMAKE_BINARY_DIR}/chibios_link.ld.in 
	"MEMORY\n"
	"{\n"
	"  flash : org = 0x08000000, len = \${BOOTLOADER_SIZE}\n"
	"  conf1 : org = 0x08000000 + \${BOOTLOADER_SIZE}, len = \${CONFIGURATION_SIZE}\n"
	"  conf2 : org = 0x08000000 + \${BOOTLOADER_SIZE} + \${CONFIGURATION_SIZE}, len = \${CONFIGURATION_SIZE}\n"
	"  user  : org = 0x08000000 + \${BOOTLOADER_SIZE} + \${CONFIGURATION_SIZE} + \${CONFIGURATION_SIZE}, len = \${STM32_FLASH_SIZE} - \${CONFIGURATION_SIZE} - \${CONFIGURATION_SIZE} - \${TAGS_SIZE}\n"
	"  tags  : org = 0x08000000 + \${STM32_FLASH_SIZE} - \${TAGS_SIZE}, len = \${TAGS_SIZE}\n"
	"  vtram : org = 0x20000000, len = 0xc0\n"
	"  ram0  : org = 0x200000c0, len = \${STM32_RAM_SIZE} - 0xc0 - 4\n"
	"  ram1  : org = 0x00000000, len = 0\n"
	"  ram2  : org = 0x00000000, len = 0\n"
	"  ram3  : org = 0x00000000, len = 0\n"
	"  ram4  : org = \${STM32_CCRAM_ORIGIN}, len = \${STM32_CCRAM_SIZE}\n"
	"  ram5  : org = 0x00000000, len = 0\n"
	"  ram6  : org = 0x00000000, len = 0\n"
	"  ram7  : org = 0x00000000, len = 0\n"
	"}\n"
	"REGION_ALIAS(\"MAIN_STACK_RAM\", ram0);\n"
	"REGION_ALIAS(\"PROCESS_STACK_RAM\", ram0);\n"
	"REGION_ALIAS(\"DATA_RAM\", ram0);\n"
	"REGION_ALIAS(\"BSS_RAM\", ram0);\n"
	"REGION_ALIAS(\"HEAP_RAM\", ram0);\n"
	"_user_address_bottom = ORIGIN(user);\n"
	"_user_address_top = ORIGIN(tags) + LENGTH(tags);\n"
	"PROVIDE(user_address_bottom = _user_address_bottom);\n"
	"PROVIDE(user_address_top = _user_address_top);\n"
	"_tags_address_bottom = ORIGIN(tags);\n"
	"_tags_address_top = ORIGIN(tags) + LENGTH(tags);\n"
	"PROVIDE(tags_address_bottom = _tags_address_bottom);\n"
	"PROVIDE(tags_address_top = _tags_address_top);\n"
	"_conf1_address_bottom = ORIGIN(conf1);\n"
	"_conf1_address_top = ORIGIN(conf1) + LENGTH(conf1);\n"
	"PROVIDE(conf1_address_bottom = _conf1_address_bottom);\n"
	"PROVIDE(conf1_address_top = _conf1_address_top);\n"
	"_conf2_address_bottom = ORIGIN(conf2);\n"
	"_conf2_address_top = ORIGIN(conf2) + LENGTH(conf2);\n"
	"PROVIDE(conf2_address_bottom = _conf2_address_bottom);\n"
	"PROVIDE(conf2_address_top = _conf2_address_top);\n"
	"INCLUDE bootloader_rules.ld\n"      
      )
    ELSE()
      FILE(WRITE ${CMAKE_BINARY_DIR}/chibios_link.ld.in 
	"MEMORY\n"
	"{\n"
	"  conf1 : org = 0x08000000 + \${BOOTLOADER_SIZE}, len = \${CONFIGURATION_SIZE}\n"
	"  conf2 : org = 0x08000000 + \${BOOTLOADER_SIZE} + \${CONFIGURATION_SIZE}, len = \${CONFIGURATION_SIZE}\n"
	"  flash : org = 0x08000000 + \${BOOTLOADER_SIZE} + \${CONFIGURATION_SIZE} + \${CONFIGURATION_SIZE}, len = \${STM32_FLASH_SIZE} - \${CONFIGURATION_SIZE} - \${CONFIGURATION_SIZE} - \${TAGS_SIZE}\n"
	"  tags  : org = 0x08000000 + \${STM32_FLASH_SIZE} - \${TAGS_SIZE}, len = \${TAGS_SIZE}\n"
	"  ram0  : org = 0x200000c0, len = \${STM32_RAM_SIZE} - 0xc0 - 4\n"
	"  ram1 : org = 0x00000000, len = 0\n"
	"  ram2 : org = 0x00000000, len = 0\n"
	"  ram3 : org = 0x00000000, len = 0\n"
	"  ram4 : org = \${STM32_CCRAM_ORIGIN}, len = \${STM32_CCRAM_SIZE}\n"
	"  ram5 : org = 0x00000000, len = 0\n"
	"  ram6 : org = 0x00000000, len = 0\n"
	"  ram7 : org = 0x00000000, len = 0\n"
	"}\n"
	"ASSERT(ORIGIN(flash) == ALIGN(ORIGIN(flash), 0x80), \"Start of memory region flash not aligned for startup vector table\");\n"
	"REGION_ALIAS(\"MAIN_STACK_RAM\", ram0);\n"
	"REGION_ALIAS(\"PROCESS_STACK_RAM\", ram0);\n"
	"REGION_ALIAS(\"DATA_RAM\", ram0);\n"
	"REGION_ALIAS(\"BSS_RAM\", ram0);\n"
	"REGION_ALIAS(\"HEAP_RAM\", ram0);\n"
	"_tags_address_bottom = ORIGIN(tags);\n"
	"_tags_address_top = ORIGIN(tags) + LENGTH(tags);\n"
	"PROVIDE(tags_address_bottom = _tags_address_bottom);\n"
	"PROVIDE(tags_address_top = _tags_address_top);\n"
	"_conf1_address_bottom = ORIGIN(conf1);\n"
	"_conf1_address_top = ORIGIN(conf1) + LENGTH(conf1);\n"
	"PROVIDE(conf1_address_bottom = _conf1_address_bottom);\n"
	"PROVIDE(conf1_address_top = _conf1_address_top);\n"
	"_conf2_address_bottom = ORIGIN(conf2);\n"
	"_conf2_address_top = ORIGIN(conf2) + LENGTH(conf2);\n"
	"PROVIDE(conf2_address_bottom = _conf2_address_bottom);\n"
	"PROVIDE(conf2_address_top = _conf2_address_top);\n"
	"INCLUDE rules.ld\n"      
      )
    ENDIF()
  ELSE()
    FILE(WRITE ${CMAKE_BINARY_DIR}/chibios_link.ld.in 
      "MEMORY\n"
      "{\n"
      "  conf1 : org = 0x08000000, len = \${CONFIGURATION_SIZE}\n"
      "  conf2 : org = 0x08000000 + \${CONFIGURATION_SIZE}, len = \${CONFIGURATION_SIZE}\n"
      "  flash : org = 0x08000000 + \${CONFIGURATION_SIZE} + \${CONFIGURATION_SIZE}, len = \${STM32_FLASH_SIZE} - \${CONFIGURATION_SIZE} - \${CONFIGURATION_SIZE} - \${TAGS_SIZE}\n"
      "  tags  : org = 0x08000000 + \${STM32_FLASH_SIZE} - \${TAGS_SIZE}, len = \${TAGS_SIZE}\n"
      "  ram0  : org = 0x20000000, len = \${STM32_RAM_SIZE}\n"
      "  ram1 : org = 0x00000000, len = 0\n"
      "  ram2 : org = 0x00000000, len = 0\n"
      "  ram3 : org = 0x00000000, len = 0\n"
      "  ram4 : org = \${STM32_CCRAM_ORIGIN}, len = \${STM32_CCRAM_SIZE}\n"
      "  ram5 : org = 0x00000000, len = 0\n"
      "  ram6 : org = 0x00000000, len = 0\n"
      "  ram7 : org = 0x00000000, len = 0\n"
      "}\n"
      "REGION_ALIAS(\"MAIN_STACK_RAM\", ram0);\n"
      "REGION_ALIAS(\"PROCESS_STACK_RAM\", ram0);\n"
      "REGION_ALIAS(\"DATA_RAM\", ram0);\n"
      "REGION_ALIAS(\"BSS_RAM\", ram0);\n"
      "REGION_ALIAS(\"HEAP_RAM\", ram0);\n"
	"_tags_address_bottom = ORIGIN(tags);\n"
	"_tags_address_top = ORIGIN(tags) + LENGTH(tags);\n"
	"PROVIDE(tags_address_bottom = _tags_address_bottom);\n"
	"PROVIDE(tags_address_top = _tags_address_top);\n"
	"_conf1_address_bottom = ORIGIN(conf1);\n"
	"_conf1_address_top = ORIGIN(conf1) + LENGTH(conf1);\n"
	"PROVIDE(conf1_address_bottom = _conf1_address_bottom);\n"
	"PROVIDE(conf1_address_top = _conf1_address_top);\n"
	"_conf2_address_bottom = ORIGIN(conf2);\n"
	"_conf2_address_top = ORIGIN(conf2) + LENGTH(conf2);\n"
	"PROVIDE(conf2_address_bottom = _conf2_address_bottom);\n"
	"PROVIDE(conf2_address_top = _conf2_address_top);\n"
    "INCLUDE rules.ld\n"      
    )
  ENDIF()
  SET(ChibiOS_LINKER_SCRIPT ${CMAKE_BINARY_DIR}/chibios_link.ld.in)
ENDIF()     

