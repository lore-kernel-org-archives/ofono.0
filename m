Content-Type: multipart/mixed; boundary="===============6287208356845923657=="
MIME-Version: 1.0
From: Jarkko Tulla <jarkko.tulla@tieto.com>
Subject: Re: [PATCH 0/5 v4] Neighbor Cell Info Atom
Date: Tue, 01 Mar 2011 10:25:38 +0200
Message-ID: <4D6CAD82.3060309@tieto.com>
In-Reply-To: <1297695412-22259-1-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6287208356845923657==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 02/14/2011 04:56 PM, Antti Paila wrote:
>   This series of patches implements an interface for client
>   applications to fetch the ECID information of neighboring
>   cells using DBUS. Since the 1st version the DBUS api has
>   been refactored to use new naming for method and to use
>   flat data format for the cell information. Also, the
>   internal datatypes have been optimized. Since the 2nd
>   version MNC and MCC are converted to strings and CPICH-RSCP
>   re-typed. Since 3rd version multiradio support is added and
>   interfaces are renamed.
>
> Antti Paila (5):
>    cell-info: CellInfo DBUS interface definition
>    cell-info: Header files for neighbor cell info
>    cell-info: Atom for neighbor cell info
>    cell-info: New files included in compilation
>    cell-info: Documentation
>
>   Makefile.am         |    9 +-
>   doc/cell-info.txt   |  122 +++++++++++++
>   include/cell-info.h |  126 ++++++++++++++
>   include/dbus.h      |    1 +
>   src/cell-info.c     |  475 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   src/ofono.h         |    1 +
>   6 files changed, 731 insertions(+), 3 deletions(-)
>   create mode 100644 doc/cell-info.txt
>   create mode 100644 include/cell-info.h
>   create mode 100644 src/cell-info.c
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Hi, is there any timetable for getting this Anttis' patch to core? I am =

asking because I have almost ready STE modem implementation for getting =

cell information.


BR,
Jarkko

--===============6287208356845923657==--

