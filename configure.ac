##
# \file         configure.in
# \author       Bill Hill
# \date         May 2015
# \version      $Id: 9e778bef820808796936d6b5ba9fad33d9844a41 $
# \par
# Address:
#               MRC Human Genetics Unit,
#               MRC Institute of Genetics and Molecular Medicine,
#               University of Edinburgh,
#               Western General Hospital,
#               Edinburgh, EH4 2XU, UK.
# \par
# Copyright (C), [2012],
# The University Court of the University of Edinburgh,
# Old College, Edinburgh, UK.
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be
# useful but WITHOUT ANY WARRANTY; without even the implied
# warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
# PURPOSE.  See the GNU General Public License for more
# details.
#
# You should have received a copy of the GNU General Public
# License along with this program; if not, write to the Free
# Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
# Boston, MA  02110-1301, USA.
# \brief        Process this file with autoconf to produce a configure script.
##

m4_define([JAVA_WOOLZ_VERSION], [1.6.15])

AC_INIT(JavaWoolz, JAVA_WOOLZ_VERSION, ma-tech@igmm.ed.ac.uk)
AC_CANONICAL_TARGET

AC_GNU_SOURCE

AM_INIT_AUTOMAKE

AC_CONFIG_MACRO_DIR([m4])

AC_CONFIG_SRCDIR([uk/ac/mrc/hgu/Wlz/C2Java/WlzC2Java.jj])

AC_PROG_MAKE_SET

# Set defaults
AC_PREFIX_DEFAULT(/opt/MouseAtlas)
AC_ENABLE_SHARED
CP="cp"
RM="rm -f"
RMRF="rm -rf"
SIMD=''
CDEF_ARCH=""
USE_CTAGS=1
USE_ETAGS=0
HAVE_JPEG="no"
JPEG_DIR="no"
HAVE_NIFTI="no"
NIFTI_DIR="no"
HAVE_TIFF="no"
TIFF_DIR="no"
ENABLE_JAVA="no"
HAVE_JNI="no"
JDK_DIR="no"
JAR="no"
JAVA="no"
JAVAC="no"
JAVACC="no"
ENABLE_TEST="no"
AC_SUBST(CP)
AC_SUBST(RM)
AC_SUBST(RMRF)

# Check CPU type
echo "Checking target cpu/system type"
case ${target_cpu} in
  i386|i486|i586|i686)
    CDEF_ARCH="-D__x86"
    ;;
  x86_64|amd64)
    CDEF_ARCH="-D__x86"
    ;;
  ia64)
    CDEF_ARCH="-D__x86"
    ;;
  alpha)
    CDEF_ARCH="-D__alpha"
    ;;
  sparc|sparc64)
    CDEF_ARCH="-D__sparc"
    ;;
  ppc|powerpc)
    CDEF_ARCH="-D__ppc"
    ;;
  mips)
    CDEF_ARCH="-D__mpis"
    ;;
  *)
    echo "Warning: CPU type ${target_cpu} unknown."
    ;;
esac

# Check for programs.
AC_PROG_CC
AC_PROG_INSTALL
AC_PROG_LIBTOOL
AC_PROG_MKDIR_P

# Check for header files.
AC_HEADER_STDC
AC_CHECK_HEADERS([	assert.h \
			ctype.h \
			errno.h \
			float.h \
			limits.h \
			stddef.h \
			stdlib.h \
			string.h \
			strings.h \
                  	sys/time.h \
                  	sys/types.h \
			time.h \
			unistd.h])

# Check for typedefs, structures, and compiler characteristics.
AC_C_CONST
AC_TYPE_SIZE_T
AC_HEADER_TIME
AC_STRUCT_TM

# Check for library functions.
AC_FUNC_MKTIME
AC_FUNC_STAT
AC_FUNC_VPRINTF
AC_CHECK_FUNCS([	floor \
		        malloc \
			memset \
			realloc \
			regcmp \
			regcomp \
			strcasecmp \
			strchr \
			strerror \
			strrchr \
                        strstr \
                        strtok \
                        strtok_r])


# Compilation and linking flags
CFLAGS=""
INCL_EXTFF=""
LIBS_EXTFF="-lz"
AC_SUBST(LIBS_EXTFF)
AC_SUBST(INCL_EXTFF)

AC_PROG_CC

AC_ARG_ENABLE(icc,
  [  --enable-icc          build using the Intel C compiler],
  GCC="no"
  CC="icc"
  CXX="icpc"
  LD="xild"
  AR="xiar"
  )

if test "$CC" = "gcc"
then
  CFLAGS="${CFLAGS} -pipe -Wall -Wno-deprecated"
fi
if test "$CC" = "icc"
then
  CFLAGS="${CFLAGS} -w2"
fi

CFLAGS="${CFLAGS} ${CDEF_ARCH}"

# Set target architecture flags
if test "$CC" = "gcc"
then
  case ${target_cpu} in
    i386|i486|i586)
      CFLAGS="${CFLAGS} -m32 -march=i586"
      ;;
    i686)
      CFLAGS="${CFLAGS} -m32 -march=i686"
      ;;
    x86_64|amd64)
      CFLAGS="${CFLAGS} -m64"
      ;;
    *)
      ;;
  esac
else
  #Intel CC
  if test "$CC" = "icc"
  then
    case ${target_cpu} in
      i386|i486|i586)
	CFLAGS="${CFLAGS} -m32 -xK"
	;;
      i686)
	CFLAGS="${CFLAGS}  -xN"
	;;
      x86_64|amd64)
	CFLAGS="${CFLAGS} -m64"
	;;
      *)
	;;
    esac
  fi
fi

CPP="cpp"

AC_ARG_ENABLE(debug,
  [  --enable-debug	build with debugging flags set],
    CFLAGS="${CFLAGS} -g -fPIC -DDEBUG"
    LDFLAGS="${LDFLAGS} -g -DDEBUG")

AC_ARG_ENABLE(optimise,
  [  --enable-optimise	build with optimisation flags set],
  [
    # GNU CC
    if test "$CC" = "gcc"
    then
      case ${target_cpu} in
	i386|i486|i586|i686)
	  CFLAGS="${CFLAGS} -fPIC -O2 -fomit-frame-pointer"
	  ;;
	x86_64|amd64)
	  if test "x$SIMD" = "x"
	  then
	    SIMD="-msse3"
	  fi
          CFLAGS="${CFLAGS} -fPIC -O3"
	  ;;
        *)
          CFLAGS="${CFLAGS} -fPIC -O2"
	  ;;
      esac
    else
      #Intel CC
      if test "$CC" = "icc"
      then
	CFLAGS="${CFLAGS} -fPIC -O3 -ip"
      else
	# AIX CC
	if test "`uname`" = "AIX"
	then
	  CFLAGS="${CFLAGS} -O3"
	fi
	# SGI CC
	if test "`uname`" = "IRIX" || test "`uname`" = "IRIX64"
	then
	  CFLAGS="${CFLAGS} -Ofast"
	  LDDFLAGS="${LDFLAGS} -IPA"
	fi
	# HP-UX CC
	if test "`uname`" = "HP-UX"
	then
	  CFLAGS="${CFLAGS} -fast"
	fi
	# Sun CC
	if test "`uname`" = "SunOS"
	then
	  CFLAGS="${CFLAGS} -fast"
	fi
      fi
    fi
    ])

AC_ARG_ENABLE(avx2,
  [AC_HELP_STRING([--enable-avx2],[enable AVX2 SIMD optimizations])],
  SIMD='-mavx2')

AC_ARG_ENABLE(openmp,
  [  --enable-openmp	build with openmp flags set],
    # GNU CC
    if test "$CC" = "gcc"
    then
      CFLAGS="${CFLAGS} -fopenmp"
    fi
    # Intel CC
    if test "$CC" = "icc"
    then
      CFLAGS="${CFLAGS} -openmp"
    fi)

AC_ARG_ENABLE(test,
  [  --enable-test		build test programs],
     ENABLE_TEST="yes",
     ENABLE_TEST="no")
AM_CONDITIONAL([BUILD_TEST], [test x"$ENABLE_TEST" = x"yes"])

if test ${USE_CTAGS} = 1
then
  AC_CHECK_PROG(GNC_CTAGS_FILE, ctags, tags)
fi

dnl Check for Woolz
AC_ARG_WITH(static-woolz,
            [ --with-static-woolz=WOOLZ_DIR   Directory containing the Woolz
                          include and lib directories.],
            WOOLZ_DIR=$withval, WOOLZ_DIR=no)
if test ${WOOLZ_DIR} = "no"
then
  AC_ARG_WITH(woolz,
              [ --with-woolz=WOOLZ_DIR   Directory containing the Woolz
                            include and lib directories.],
              WOOLZ_DIR=$withval, WOOLZ_DIR=no)
  if test ${WOOLZ_DIR} = "no"
  then
    AC_CHECK_HEADER(WlzExtFF.h,
                    AC_CHECK_LIB(WlzExtFF, WlzEffNumberOfFormats,
                                 [
                 HAVE_WLZ="yes"
                 LIBS_WLZ="-lWlzExtFF -lbibfile -lhguDlpList -lWlz -lAlg -lAlc"
               ]))
  else
    HAVE_WLZ="yes"
    INCL_WLZ="-I${WOOLZ_DIR}/include"
    LIBS_WLZ="-L${WOOLZ_DIR}/lib -lWlzExtFF -lbibfile -lhguDlpList"
    LIBS_WLZ="${LIBS_WLZ} -lWlz -lAlg -lAlc"
  fi
else
  HAVE_WLZ="yes"
  INCL_WLZ="-I${WOOLZ_DIR}/include"
  LIBS_WLZ="${WOOLZ_DIR}/lib/libWlzBnd.a"
  LIBS_WLZ="${LIBS_WLZ} ${WOOLZ_DIR}/lib/libWlzExtFF.a"
  LIBS_WLZ="${LIBS_WLZ} ${WOOLZ_DIR}/lib/libbibfile.a"
  LIBS_WLZ="${LIBS_WLZ} ${WOOLZ_DIR}/lib/libhguDlpList.a"
  LIBS_WLZ="${LIBS_WLZ} ${WOOLZ_DIR}/lib/libWlz.a"
  LIBS_WLZ="${LIBS_WLZ} ${WOOLZ_DIR}/lib/libAlg.a"
  LIBS_WLZ="${LIBS_WLZ} ${WOOLZ_DIR}/lib/libAlc.a"
fi
if test ${HAVE_WLZ} = "yes"
then
  CFLAGS="$CFLAGS -DHAVE_WLZ=1 $INCL_WLZ"
  LDFLAGS="$LDFLAGS $LIBS_WLZ"
  AC_SUBST(WOOLZ_DIR)
else
  CFLAGS="$CFLAGS -DHAVE_WLZ=0"
  AC_MSG_ERROR(Could not find Woolz.);
fi

dnl Check for NIFTI
AC_ARG_WITH(static-nifti,
            [ --with-static-nifti=NIFTI_DIR   Directory containing the NIFTI
                          include and lib directories.],
            NIFTI_DIR=$withval, NIFTI_DIR=no)
if test ${NIFTI_DIR} = "no"
then
  AC_ARG_WITH(nifti,
              [ --with-nifti=NIFTI_DIR   Directory containing the NIFTI
                            include and lib directories.],
              NIFTI_DIR=$withval, NIFTI_DIR=no)
  if test ${NIFTI_DIR} = "no"
  then
    HAVE_NIF=no
    CFLAGS="${CFLAGS} -DHAVE_NIFTI=0"
  else
    HAVE_NIF="yes"
    INCL_NIF="-I${NIFTI_DIR}/include"
    LIBS_NIF="-L${NIFTI_DIR}/lib -lniftiio -lznz"
  fi
else
  HAVE_NIF="yes"
  INCL_NIF="-I${NIFTI_DIR}/include"
  LIBS_NIF="${NIFTI_DIR}/lib/libniftiio.a ${NIFTI_DIR}/lib/libznz.a"
fi
if test ${HAVE_NIF} = "yes"
then
  CFLAGS="$CFLAGS -DHAVE_NIFTI=1 $INCL_NIF"
  LDFLAGS="$LDFLAGS $LIBS_NIF"
else
  CFLAGS="$CFLAGS -DHAVE_NIFTI=0"
  AC_MSG_ERROR(Could not find NIfTI.);
fi

dnl Check for TIFF
AC_ARG_WITH(static-tiff,
            [ --with-static-tiff=TIFF_DIR     Directory containing the Tiff
                          include and lib directories.],
            TIFF_DIR=$withval, TIFF_DIR=no)
if test ${TIFF_DIR} = "no"
then
  AC_ARG_WITH(tiff,
              [ --with-tiff=TIFF_DIR     Directory containing the Tiff
                            include and lib directories.],
              TIFF_DIR=$withval, TIFF_DIR=no)
  if test ${TIFF_DIR} = "no"
  then
    AC_CHECK_HEADER(tiff.h, [
                              HAVE_TIF=yes
                              LIBS_TIF="-ltiff"
                            ])
  else
    HAVE_TIF="yes"
    INCL_TIF="-I${TIFF_DIR}/include"
    LIBS_TIF="-L${TIFF_DIR}/lib -ltiff"
  fi
else
  HAVE_TIF="yes"
  INCL_TIF="-I${TIFF_DIR}/include"
  LIBS_TIF="${TIFF_DIR}/lib/libtiff.a"
fi
if test ${HAVE_TIF} = "yes"
then
  CFLAGS="$CFLAGS -DHAVE_TIFF=1 $INCL_TIF"
  LDFLAGS="$LDFLAGS $LIBS_TIF"
else
  CFLAGS="$CFLAGS -DHAVE_TIFF=0"
  AC_MSG_ERROR(Could not find Tiff);
fi

dnl Check for Jpeg
AC_ARG_WITH(static-jpeg,
            [ --with-static-jpeg=JPEG_DIR     Directory containing the JPEG
                          include and lib directories.],
            JPEG_DIR=$withval, JPEG_DIR=no)
if test ${JPEG_DIR} = "no"
then
  AC_ARG_WITH(jpeg,
              [ --with-jpeg=JPEG_DIR     Directory containing the JPEG
                            include and lib directories.],
              JPEG_DIR=$withval, JPEG_DIR=no)
  if test ${JPEG_DIR} = "no"
  then
    AC_CHECK_HEADER(jpeglib.h, [
                                 HAVE_JPG=yes
                                 LIBS_JPG="-ljpeg"
                               ])
  else
    HAVE_JPG=yes
    INCL_JPG="-I${JPEG_DIR}/include"
    LIBS_JPG="-L${JPEG_DIR}/lib -ljpeg"
  fi
else
  HAVE_JPG=yes
  INCL_JPG="-I${JPEG_DIR}/include"
  LIBS_JPG="${JPEG_DIR}/lib/libjpeg.a"
fi
if test ${HAVE_JPG} = "yes"
then
  CFLAGS="$CFLAGS -DHAVE_JPEG=1 $INCL_JPG"
  LDFLAGS="$LDFLAGS $LIBS_JPG"
else
  CFLAGS="$CFLAGS -DHAVE_JPEG=0"
  AC_MSG_ERROR(Could not find Jpeg);
fi

AC_ARG_WITH(jdk, [  --with-jdk=DIR          Directory with Java development
			kit defaults to the value of the JAVA_HOME
			environment variable.],
		   JDK_DIR=$withval, JDK_DIR=no)
if test ${JDK_DIR} = "no"
then
    # no --with-jdk argument given
    if test x${JAVA_HOME} = "x"
    then
      AC_MSG_ERROR([JDK base directory required, use --with-jdk=DIR.])
    else
      JDK_DIR=${JAVA_HOME}
    fi
fi
if test ${JDK_DIR} != "no"
then
  JAR=${JDK_DIR}/bin/jar
  JAVA=${JDK_DIR}/bin/java
  JAVAC=${JDK_DIR}/bin/javac
fi
AC_ARG_WITH(javacc, [  --with-javacc=PATH      Full path of the javacc
			executable, by default the standard paths are
			searched.],
		   JAVACC=$withval, JAVACC=no)
if test ${JAVACC} = "no"
then
  AC_PATH_PROG(JAVACC, javacc)
  if test x${JAVACC} = "x"
  then
    AC_MSG_ERROR([Program javacc required, use --with-javacc=PATH.])
  fi
fi
AC_SUBST(JAVA)
AC_SUBST(JAVAC)
AC_SUBST(JAVACC)
AC_CONFIG_FILES([     uk/ac/mrc/hgu/Wlz/C2Java/Makefile \
		      uk/ac/mrc/hgu/Wlz/C/Makefile \
		      uk/ac/mrc/hgu/Wlz/Java/Makefile ])

if test x${ENABLE_TEST} = "xyes"
then
  AC_CONFIG_FILES([   uk/ac/mrc/hgu/Wlz/Test/Makefile ])
fi

case $host in
  *mingw*)
    LIBS="-lregex $LIBS"
    ;;
  *cygwin*)
    LIBS="-lregex $LIBS"
    ;;
esac

AS_IF([ test "$CC" = "gcc" -a "x$enable_optimise" = "xyes" ],
      CFLAGS="$CFLAGS $SIMD")

AC_OUTPUT(Makefile)

AC_MSG_RESULT([
JavaWoolz has been configured on ${host} with

  Source directory:                 ${srcdir}
  Installation directory:           ${prefix}
  Target CPU:                       ${target_cpu}
  C compiler:                       ${CC}
  C++ compiler:                     ${CXX}
  Linker:                           ${LD}
  Archiver:                         ${AR}
  CFLAGS:                         ${CFLAGS}
  LIBS needed for configure:       ${LIBS_EXTFF} ${LIBS}
  Woolz external file format code:  ${ENABLE_EXTFF}
  JDK directory:                    ${JDK_DIR}
  jar:                              ${JAR}
  java:                             ${JAVA}
  javac:                            ${JAVAC}
  javacc:                           ${JAVACC}
  Test programs:                    ${ENABLE_TEST}

To JavaWoolz:                       make
To install JavaWoolz:               make install
])

