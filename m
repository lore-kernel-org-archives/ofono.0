Content-Type: multipart/mixed; boundary="===============1277561697001873693=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: Ofono in Maemo scratchbox--compilation failed.
Date: Mon, 12 Jul 2010 12:26:04 +0800
Message-ID: <33AB447FBD802F4E932063B962385B351F7702A5@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1278683702.10421.116.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1277561697001873693==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Arun,

Marcel Holtmann wrote:
> Hi Arun,
> =

>> I am trying to compile Ofono in Maemo Scratchbox SDK enviornment.
>> =

>> Here is the bootstrap-configure output:
>> =

> ---------------------------------------------------------------
> ---------------------------------------------------------------
> -----------------
>> [sbox-FREMANTLE_X86: ~/ofono] > ./bootstrap-configure
>> configure.ac: installing `./install-sh'
>> configure.ac: installing `./missing'
>> Makefile.am: installing `./compile'
>> Makefile.am: installing `./depcomp'
>> checking for a BSD-compatible install...
>> /scratchbox/tools/bin/install -c checking whether build environment
>> is sane... yes =

>> checking for gawk... gawk
>> checking whether make sets $(MAKE)... yes
>> checking whether to enable maintainer-specific portions of
>> Makefiles... yes checking for pkg-config...
>> /scratchbox/tools/bin/pkg-config =

>> checking pkg-config is at least version 0.9.0... yes
>> checking for style of include used by make... GNU
>> checking for gcc... gcc
>> checking for C compiler default output file name... a.out
>> checking whether the C compiler works... yes
>> checking whether we are cross compiling... no
>> checking for suffix of executables...
>> checking for suffix of object files... o
>> checking whether we are using the GNU C compiler... yes
>> checking whether gcc accepts -g... yes
>> checking for gcc option to accept ISO C89... none needed
>> checking dependency style of gcc... gcc3
>> checking for C/C++ restrict keyword... no
>> checking for gcc... (cached) gcc
>> checking whether we are using the GNU C compiler... (cached) yes
>> checking whether gcc accepts -g... (cached) yes
>> checking for gcc option to accept ISO C89... (cached) none needed
>> checking dependency style of gcc... (cached) gcc3
>> checking whether gcc and cc understand -c and -o together... yes
>> checking whether gcc accepts -fPIE... yes
>> checking for a BSD-compatible install...
>> /scratchbox/tools/bin/install -c checking for a sed that does not
>> truncate =

>> output... /scratchbox/tools/bin/sed
>> checking for gawk... (cached) gawk
>> checking build system type... i486-pc-linux-gnu
>> checking host system type... i486-pc-linux-gnu
>> checking for a sed that does not truncate
>> output... /scratchbox/tools/bin/sed
>> checking for grep that handles long lines and
>> -e... /scratchbox/tools/bin/grep
>> checking for egrep... /scratchbox/tools/bin/grep -E
>> checking for ld used by
>> gcc...
> /scratchbox/compilers/cs2007q3-glibc2.5-i486/i486-pc-linux-gnu/bin/ld
>> checking if the linker
>> =

> (/scratchbox/compilers/cs2007q3-glibc2.5-i486/i486-pc-linux-gnu
> /bin/ld) is GNU ld... yes
>> checking
>> for
> /scratchbox/compilers/cs2007q3-glibc2.5-i486/i486-pc-linux-gnu/
> bin/ld option to reload object files... -r
>> checking for BSD-compatible nm... /scratchbox/compilers/bin/nm -B
>> checking whether ln -s works... yes
>> checking how to recognize dependent libraries... pass_all
>> checking how to run the C preprocessor... gcc -E
>> checking for ANSI C header files... yes
>> checking for sys/types.h... yes
>> checking for sys/stat.h... yes
>> checking for stdlib.h... yes
>> checking for string.h... yes
>> checking for memory.h... yes
>> checking for strings.h... yes
>> checking for inttypes.h... yes
>> checking for stdint.h... yes
>> checking for unistd.h... yes
>> checking dlfcn.h usability... yes
>> checking dlfcn.h presence... yes
>> checking for dlfcn.h... yes
>> checking the maximum length of command line arguments... 98304
>> checking command to parse /scratchbox/compilers/bin/nm -B output
>> from gcc object... failed checking for objdir... .libs
>> checking for ar... ar
>> checking for ranlib... ranlib
>> checking for strip... strip
>> checking if gcc supports -fno-rtti -fno-exceptions... no
>> checking for gcc option to produce PIC... -fPIC
>> checking if gcc PIC flag -fPIC works... yes
>> checking if gcc static flag -static works... yes
>> checking if gcc supports -c -o file.o... yes
>> checking whether the gcc linker
>> =

> (/scratchbox/compilers/cs2007q3-glibc2.5-i486/i486-pc-linux-gnu
> /bin/ld) supports shared libraries... yes
>> checking whether -lc should be explicitly linked in... no
>> checking dynamic linker characteristics... GNU/Linux ld.so
>> checking how to hardcode library paths into programs... immediate
>> checking whether stripping libraries is possible... yes
>> checking if libtool supports shared libraries... yes
>> checking whether to build shared libraries... yes
>> checking whether to build static libraries... no
>> configure: creating libtool
>> checking for BSD-compatible nm...
>> (cached) /scratchbox/compilers/bin/nm -B
>> checking for signalfd in -lc... yes
>> checking for dlopen in -ldl... yes
>> checking for GLIB... yes
>> checking for DBUS... yes
>> checking for dbus_watch_get_unix_fd in -ldbus-1... yes
>> checking for dbus_connection_can_send_type in -ldbus-1... no
>> checking for UDEV... yes checking for CAPNG... yes
>> configure: creating ./config.status
>> config.status: creating Makefile
>> config.status: creating include/version.h
>> config.status: creating config.h
>> config.status: executing depfiles commands
>> -------------------------------------------------------------------
>> =

>> =

>> But while running make, i get the following error.
>> =

>> [sbox-FREMANTLE_X86: ~/ofono] > make
>> make --no-print-directory all-am
>> include/ofono
>> make[1]: include/ofono: Command not found
>> make[1]: *** [include/ofono/log.h] Error 127
>> make: *** [all] Error 2
>> =

> ---------------------------------------------------------------
> -------------
>> =

>> What could be the reason? Could anyone help?

Automake in the scrachbox is 1.9. On Ubuntu 9.10, I am using automake 1.11 =
and it works fine for me. You might need to try newer version automake/auto=
conf.

> the reason is that the include/ofono symlink is not created correctly.
> Must be an issue in the scratchbox setup. You need to find someone
> that actually knows more about it. =

> =

> Regards
> =

> Marcel
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono



Regards,
Zhenhua


--===============1277561697001873693==--

