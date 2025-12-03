# ------------------------------------------------------------------------------
# Quick & dirty LibIGL+CMake support for CloudCompare
# ------------------------------------------------------------------------------

# libIGL library https://libigl.github.io/
set( LIBIGL_INCLUDE_DIR "" CACHE PATH "libigl include directory" )
set( LIBIGL_RELEASE_LIBRARY_FILE "" CACHE FILEPATH "libigl library file (release mode)" )
if (WIN32)
	set( LIBIGL_DEBUG_LIBRARY_FILE "" CACHE FILEPATH "libigl library file (debug mode)" )
endif()

if ( NOT LIBIGL_INCLUDE_DIR )
	message( SEND_ERROR "No libigl include dir specified (LIBIGL_INCLUDE_DIR)" )
else()
	target_include_directories( ${PROJECT_NAME} PRIVATE ${LIBIGL_INCLUDE_DIR}
	)
endif()

set( EIGEN_ROOT_DIR "" CACHE PATH "Eigen root (contains the Eigen directory)" )
if ( NOT EIGEN_ROOT_DIR )
	message( SEND_ERROR "No Eigen root directory specified (EIGEN_ROOT_DIR)" )
else()
	target_include_directories( ${PROJECT_NAME} PRIVATE ${EIGEN_ROOT_DIR} )
endif()

find_package( CGAL REQUIRED COMPONENTS Core )

# Link project with libigl library
function( target_link_libIGL ) # 1 argument: ARGV0 = project name
	# libigl is a header-only library, so we only need to link CGAL
	target_link_libraries( ${ARGV0} CGAL::CGAL CGAL::CGAL_Core)

	# Optional: if library files are provided (for non-header-only build)
	if( LIBIGL_RELEASE_LIBRARY_FILE )
		target_link_libraries( ${ARGV0} optimized ${LIBIGL_RELEASE_LIBRARY_FILE} )

		#optional: debug mode
		if ( LIBIGL_DEBUG_LIBRARY_FILE )
			target_link_libraries( ${ARGV0} debug ${LIBIGL_DEBUG_LIBRARY_FILE} )
		endif()
	endif()
endfunction()
