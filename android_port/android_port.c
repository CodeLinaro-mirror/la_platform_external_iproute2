/*============================================================================
  FILE:         android_port.c

  OVERVIEW:     Creates dummy functions for iproute2 to interface with.

  DEPENDENCIES: No file containing "xfrm" in the title should be compiled in
                the iproute2 source code's 'ip' directory.
============================================================================*/

/*
 * Copyright (c) 2010, Code Aurora Forum. All rights reserved.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 and
 * only version 2 as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
 * 02110-1301, USA.
 */


/*----------------------------------------------------------------------------
 * Include Files
 * -------------------------------------------------------------------------*/
#include <stdio.h>
#include <string.h>

/*----------------------------------------------------------------------------
 * Preprocessor Definitions and Constants
 * -------------------------------------------------------------------------*/
#define GETLINE_ERROR -1

/*----------------------------------------------------------------------------
 * Type Declarations
 * -------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
 * Global Data Definitions
 * -------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
 * Static Variable Definitions
 * -------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------
 * FUNCTION      getLine

 * DESCRIPTION   Reads in a line of input from the inputted pointer location up
                 to the next newline charcter in memory (or EOF). Returns the
                 number of characters read in, or -1 in the case of an error.

 * DEPENDENCIES  None

 * RETURN VALUE  size_t

 * SIDE EFFECTS  None
 *--------------------------------------------------------------------------*/
size_t getline(char **linePtr, size_t *lengthPtr, FILE *in)
{
  fgets(*linePtr, *lengthPtr, in);

  if (NULL == *linePtr)
  {
    return GETLINE_ERROR;
  }

  return strlen(*linePtr);
}


/*----------------------------------------------------------------------------
 * FUNCTION      do_xfrm

 * DESCRIPTION   Replaces a function in ipxfrm.c, which is not being compiled,
                 to ensure iproute2 compiles correctly.

 * DEPENDENCIES  None

 * RETURN VALUE  Returns an int error code - 0 if successful.

 * SIDE EFFECTS  iproute2 xfrm functions will not execute.
 *--------------------------------------------------------------------------*/
int do_xfrm(int argc, char **argv) {
  return 0;
}
