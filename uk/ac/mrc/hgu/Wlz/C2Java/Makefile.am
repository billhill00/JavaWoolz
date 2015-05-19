##
# \file         Makefile.am
# \author       Bill Hill
# \date         May 2015
# \version      $Id: 869f6475f9f5899026691ac6356516ccaf177d28 $
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
# \brief        Process this file with automake to produce Makefile.in
##

WLZINCDIRS		= \
			-I${WOOLZ_DIR}/include

WLZINCLIDES		= \
			${WOOLZ_DIR}/include/Alc.h \
			${WOOLZ_DIR}/include/AlcType.h \
			${WOOLZ_DIR}/include/AlcProto.h \
			${WOOLZ_DIR}/include/Alg.h \
			${WOOLZ_DIR}/include/AlgType.h \
			${WOOLZ_DIR}/include/AlgProto.h \
			${WOOLZ_DIR}/include/Wlz.h \
			${WOOLZ_DIR}/include/WlzError.h \
			${WOOLZ_DIR}/include/WlzType.h \
			${WOOLZ_DIR}/include/WlzDebug.h \
			${WOOLZ_DIR}/include/WlzProto.h \
			${WOOLZ_DIR}/include/WlzMacro.h \
			${WOOLZ_DIR}/include/bibFile.h \
			${WOOLZ_DIR}/include/WlzExtFF.h \
			${WOOLZ_DIR}/include/WlzExtFFType.h \
			${WOOLZ_DIR}/include/WlzExtFFProto.h \
			${WOOLZ_DIR}/include/WlzBnd.h \
			${WOOLZ_DIR}/include/WlzBndType.h \
			${WOOLZ_DIR}/include/WlzBndProto.h

all:		 	binding

clean: 
			$(RM) *.c \
			      *.class \
			      timestamp \
			      Binding/Enum/* \
			      Binding/Struct/* \
			      Binding/WlzObjectC2J.javapp \
			      Binding/WlzObjectC2J.c  \
			      Binding/WlzObjectC2J.h

distclean:		clobber

clobber:		clean
			$(RM)  *.java

binding:		parser timestamp

parser:			WlzC2Java.class


timestamp:		WlzC2Java.c
			$(MKDIR_P) Binding/Enum
			$(MKDIR_P) Binding/Struct
			@JAVA@ WlzC2Java -package uk.ac.mrc.hgu.Wlz \
				WlzC2Java.c
			touch timestamp


WlzC2Java.java:		WlzC2Java.jj
			@JAVACC@ WlzC2Java.jj

WlzC2Java.class:	WlzC2Java.java
			@JAVAC@ WlzC2Java.java

WlzC2Java.c:		WlzC2Java.cpp $(WLZINCLIDES)
			$(CC) -E $(WLZINCDIRS) -DWLZ_EXT_BIND \
			      WlzC2Java.cpp > WlzC2Java.c
