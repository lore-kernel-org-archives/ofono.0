Content-Type: multipart/mixed; boundary="===============4820657270124588656=="
MIME-Version: 1.0
From: Dario <djdas@djdas.net>
Subject: Openmoko Freerunner Toolchain
Date: Fri, 26 Mar 2010 22:23:36 +0100
Message-ID: <4BAD25D8.3080801@djdas.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4820657270124588656==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,
as per an IRC conversation with Denis, I post here a link [1] to the =

toolchain me and the Neophysis team use to compile test applications and =

libraries without the need to use our build server.
The toolchain is provided as a .tar.bz2 archive, you can unpack it in =

/usr/local dir to rebuild the correct path ( /usr/local/neophysis ) or =

optionally unpack it everywhere you like and create a soft link in =

/usr/local/neophysis pointing at the unpacked dir.
The toolchain is built from the OpenEmbedded build server we use to =

build packages and rootfs images and periodically we upgrade it to stay =

up to date with the libraries versions.
It is able to build even Qt4 programs so I post it here because I think =

it could be useful for someone.
In the source dir you can find some (a bit outdated but just issue a =

"git pull" to upgrade them) samples: oFono and Phonesim, which you can =

compile with the following instructions:

1) initialize the toolchain by issuing the following command in a =

shell/terminal:
. /usr/local/neophysis/qt4-env
2) cd into the source dir of the project you want to build;
3) use the toolchain customized "./configure" command by issuing:
oe_runconf
4) build the project by issuing:
make
5) [optional] install the programs/libraries by issuing:
make install DESTDIR=3D$(pwd)/pkg

As you can see the build procedure is similar to the common sequence =

"./configure && make && make install", but the oe_runconf command lets =

you configure the cross compiling environment (its an alias to a more =

complex command sequence), while in point 5) you install (obviously the =

Makefile should provide installation using the variable DESTDIR as per =

the autotools standard) all in the pkg dir created inside the sources dir.
Finally you can tar the pkg dir and copy it to the Freerunner untarring =

the archive in its / directory to install the program.
For further information please feel free to see our wiki (sorry in =

Italian but you can google-translate) here [2] or contact me by email.
Thank you very much, best regards,
Dario.

[1] =

http://sourceforge.net/projects/neophysis/files/toolchains/neophysis_toolch=
ain_20100122.tar.bz2/download
[2] http://neophysis.sourceforge.net


--===============4820657270124588656==--

