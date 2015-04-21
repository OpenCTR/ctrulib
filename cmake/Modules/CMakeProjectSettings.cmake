#####################################################################
#  This software is provided 'as-is', without any express or implied
#  warranty.  In no event will the authors be held liable for any
#  damages arising from the use of this software.
#
#  Permission is granted to anyone to use this software for any
#  purpose, including commercial applications, and to alter it and
#  redistribute it freely, subject to the following restrictions:
#
#  1. The origin of this software must not be misrepresented; you
#     must not claim that you wrote the original software. If you use
#     this software in a product, an acknowledgment in the product
#     documentation would be appreciated but is not required.
#  2. Altered source versions must be plainly marked as such, and
#     must not be misrepresented as being the original software.
#  3. This notice may not be removed or altered from any source
#     distribution.
#####################################################################

if(NOT DEFINED CTR_ROOT)
	message(SEND_ERROR "CTR_ROOT is not set")
	return()
endif()

find_program(CMAKE_ASM_COMPILER_EXE 
	NAMES
		arm-none-eabi-as
	PATHS
		${CTR_ROOT}
	PATH_SUFFIXES
		bin
	DOC
		"Find the arm-none-eabi-as assembler"
	NO_DEFAULT_PATH
)

if(NOT CMAKE_ASM_COMPILER_EXE)
	message(SEND_ERROR "Could not find arm-none-eabi-as")
	return()
endif()

set(CMAKE_ASM_COMPILER "${CMAKE_ASM_COMPILER_EXE}")
set(CMAKE_ASM_COMPILER_ID "GNU")
set(CMAKE_ASM_COMPILER_ID_RUN TRUE)
set(CMAKE_ASM_COMPILER_FORCED TRUE)

# Enable assembly
enable_language(ASM)

if(WIN32)
	set(CMAKE_PREFIX_PATH "${CTR_ROOT}/CMake")
else()
	set(CMAKE_PREFIX_PATH "${CTR_ROOT}/share/cmake")
endif()
