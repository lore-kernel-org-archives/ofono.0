Content-Type: multipart/mixed; boundary="===============1998156436410471229=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 0/12] IPv6 support
Date: Thu, 03 Feb 2011 11:03:17 +0200
Message-ID: <1296723809-32676-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1998156436410471229==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

Here a set of patches with IPv6 support for oFono. Based on
feedback to the RFC patches, I've taken out the emulated ipv4v6
context support for modems conforming to 3GPP rel7 or older.
This simplifies the patches quite a bit and hopefully makes
them more accetable at this stage. As a result, only a single
network interface and a single set of interface configuration
parameters is exposed via each oFono gprs context.

It should be noted that the operator requirements I have seen so
far state that IPv6 capable UEs should fall back to parallel
IPv4 and IPv6 contexts if either the network or the UE does
not support the rel8 IPv4v6 combined context. =


This has implications to any IPv6 capable product using a rel7
(or older) modem. Either connman will have to support parallel
IPv4 and IPv6 connections, or the specific oFono modem driver
will have to fake it by providing an emulated ipv4v6 context
underneath oFono.

Whether oFono will be used in any IPv6 capable products with
a rel7 modem is a topic for other forums. People should be aware
of the limitation, though.

Br,

	MikaL

[PATCH 01/12] gprs: Update documentation for IPv6
[PATCH 02/12] gprs: driver interface changes for IPv6
[PATCH 03/12] gprs: core support for IPv6
[PATCH 04/12] test: modify test scripts for IPv6
[PATCH 05/12] isimodem: IPv6 support
[PATCH 06/12] atmodem: update to new gprs context interface
[PATCH 07/12] huaweimodem: update to new gprs context interface
[PATCH 08/12] mbmmodem: update to new gprs context interface
[PATCH 09/12] hsomodem: update to new gprs context interface
[PATCH 10/12] ifxmodem: update to new gprs context interface
[PATCH 11/12] stemodem: update to new gprs context interface
[PATCH 12/12] phonesim: add IPv6 support

 Makefile.am                        |    3 +-
 doc/connman-api.txt                |    9 +-
 drivers/atmodem/gprs-context.c     |   41 +++---
 drivers/hsomodem/gprs-context.c    |   48 ++++---
 drivers/huaweimodem/gprs-context.c |   43 +++---
 drivers/ifxmodem/gprs-context.c    |   36 +++--
 drivers/isimodem/gprs-context.c    |  119 +++++++++------
 drivers/mbmmodem/gprs-context.c    |   65 +++++---
 drivers/stemodem/gprs-context.c    |   31 +++--
 include/gprs-context.h             |   23 +++-
 plugins/phonesim.c                 |   32 +++-
 src/gprs.c                         |  296 +++++++++++++++++++++++---------=
----
 test/list-contexts                 |    6 +-
 test/set-context-property          |   38 +++++
 14 files changed, 514 insertions(+), 276 deletions(-)

--===============1998156436410471229==--

