#.rst:
# OpenCTR-Toolchain
# -----------------
# 
# CMake toolchain for enabling OpenCTR support.
# 
# This file may be included into a CMake project by either of the 
# following methods:
# 
#  1. ``-DCMAKE_TOOLCHAIN_FILE=/path/to/OpenCTR-Toolchain.cmake``
#  2. ``include(/path/to/OpenCTR-Toolchain.cmake)``
# 
# 

######################################################################
# This file is part of libctr.
# 
# libctr is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# libctr is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with libctr.  If not, see <http://www.gnu.org/licenses/>.
######################################################################

######################################################################

# Include guard
if(__OPENCTR_TOOLCHAIN)
	return()
endif()
set(__OPENCTR_TOOLCHAIN TRUE)

######################################################################

# Was this file included through CMAKE_TOOLCHAIN_FILE or 
# include()
if(CMAKE_TOOLCHAIN_FILE STREQUAL CMAKE_CURRENT_LIST_FILE)
	set(TOOLCHAIN_MODE TRUE)
else()
	set(TOOLCHAIN_MODE FALSE)
endif()

######################################################################

# Export variables, depending on if this file was included by 
# CMAKE_TOOLCHAIN_FILE or through INCLUDE().
function(ctrexport var val)
	if(TOOLCHAIN_MODE)
		set(${var} ${val} CACHE INTERNAL "${var}" FORCE)
	else()
		set(${var} ${val} PARENT_SCOPE)
	endif()
endfunction()

######################################################################

# Find ``arm-none-eabi-gcc``
find_program(CMAKE_C_COMPILER_EXE 
	NAMES
		arm-none-eabi-gcc
	PATHS
		${CTR_ROOT}
	PATH_SUFFIXES
		bin
	DOC
		"Find the arm-none-eabi-gcc compiler"
)

# Error if arm-none-eabi-gcc was not found
if(NOT CMAKE_C_COMPILER_EXE)
	message(FATAL_ERROR "OpenCTR-Toolchain: arm-none-eabi-gcc not found")
endif()

######################################################################

# Find arm-none-eabi-g++
find_program(CMAKE_CXX_COMPILER_EXE 
	NAMES
		arm-none-eabi-g++
	PATHS
		${CTR_ROOT}
	PATH_SUFFIXES
		bin
	DOC
		"Find the arm-none-eabi-g++ compiler"
	NO_DEFAULT_PATH
)

# Error if arm-none-eabi-g++ was not found
if(NOT CMAKE_CXX_COMPILER_EXE)
	message(FATAL_ERROR "OpenCTR-Toolchain: arm-none-eabi-g++ not found")
endif()

######################################################################

# CMake System Information
ctrexport(CMAKE_SYSTEM_NAME "Generic")
ctrexport(CMAKE_SYSTEM_VERSION 1)
ctrexport(CMAKE_SYSTEM_PROCESSOR "ARM")

# CMake find_xxx() paths
ctrexport(CMAKE_FIND_ROOT_PATH "${CTR_ROOT}")
ctrexport(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
ctrexport(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
ctrexport(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# CMAKE_C_COMPILER
ctrexport(CMAKE_C_COMPILER "${CMAKE_C_COMPILER_EXE}")
ctrexport(CMAKE_C_COMPILER_ID "GNU")
ctrexport(CMAKE_C_COMPILER_ID_RUN TRUE)
ctrexport(CMAKE_C_COMPILER_FORCED TRUE)
ctrexport(CMAKE_C_OUTPUT_EXTENSION ".o")
ctrexport(CMAKE_COMPILER_IS_GNUCC TRUE)

# CMAKE_CXX_COMPILER
ctrexport(CMAKE_CXX_COMPILER "${CMAKE_CXX_COMPILER_EXE}")
ctrexport(CMAKE_CXX_COMPILER_ID "GNU")
ctrexport(CMAKE_CXX_COMPILER_ID_RUN TRUE)
ctrexport(CMAKE_CXX_COMPILER_FORCED TRUE)
ctrexport(CMAKE_CXX_OUTPUT_EXTENSION ".o")
ctrexport(CMAKE_COMPILER_IS_GNUCXX TRUE)

# Set platform properties
ctrexport(UNIX TRUE)
ctrexport(APPLE FALSE)
ctrexport(WIN32 FALSE)
ctrexport(CYGWIN FALSE)
ctrexport(MSVC FALSE)

# Enable C/C++ Support
enable_language(C)
enable_language(CXX)

# Various CMake properties
ctrexport(CMAKE_CROSSCOMPILING TRUE)
ctrexport(CMAKE_EXECUTABLE_SUFFIX ".elf")
ctrexport(CMAKE_SKIP_RPATH TRUE)
ctrexport(BUILD_SHARED_LIBS FALSE)
ctrexport(CMAKE_STATIC_LIBRARY_PREFIX "lib")
ctrexport(CMAKE_STATIC_LIBRARY_SUFFIX ".a")
ctrexport(CMAKE_SIZEOF_VOID_P "4")
ctrexport(CMAKE_STANDARD_LIBRARIES "-lc -lm")

# Get directory that ``arm-none-eabi-gcc`` is installed in.
get_filename_component(BIN_DIR "${CMAKE_C_COMPILER}" DIRECTORY)

# Set ``CMAKE_AR`` and ``CMAKE_RANLIB``
ctrexport(CMAKE_AR "${BIN_DIR}/arm-none-eabi-ar")
ctrexport(CMAKE_RANLIB "${BIN_DIR}/arm-none-eabi-ranlib")

######################################################################
