Content-Type: multipart/mixed; boundary="===============6269071753026395836=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 0/13] IPv6 support (take 2)
Date: Tue, 08 Feb 2011 17:22:13 +0200
Message-ID: <1297178546-9371-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6269071753026395836==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

Here's another go at IPv6 with latest comments hopefully
addressed.

Regards,

	MikaL

[PATCH 01/13] gprs: factor out common code
[PATCH 02/13] gprs: Update documentation for IPv6
[PATCH 03/13] gprs: driver interface changes for IPv6
[PATCH 04/13] gprs: core support for IPv6
[PATCH 05/13] test: modify test scripts for IPv6
[PATCH 06/13] isimodem: IPv6 support
[PATCH 07/13] atmodem: update to new gprs context interface
[PATCH 08/13] huaweimodem: update to new gprs context interface
[PATCH 09/13] mbmmodem: update to new gprs context interface
[PATCH 10/13] hsomodem: update to new gprs context interface
[PATCH 11/13] ifxmodem: update to new gprs context interface
[PATCH 12/13] stemodem: update to new gprs context interface
[PATCH 13/13] phonesim: add IPv6 support

 Makefile.am                        |    3 +-
 doc/connman-api.txt                |    9 +-
 drivers/atmodem/gprs-context.c     |   41 ++--
 drivers/hsomodem/gprs-context.c    |   48 +++--
 drivers/huaweimodem/gprs-context.c |   43 +++--
 drivers/ifxmodem/gprs-context.c    |   36 ++--
 drivers/isimodem/gprs-context.c    |  119 +++++++-----
 drivers/mbmmodem/gprs-context.c    |   65 ++++---
 drivers/stemodem/gprs-context.c    |   31 ++-
 include/gprs-context.h             |   27 ++-
 plugins/phonesim.c                 |   32 +++-
 src/gprs.c                         |  390 ++++++++++++++++++++++++--------=
----
 test/list-contexts                 |    6 +-
 test/set-context-property          |   38 ++++
 14 files changed, 583 insertions(+), 305 deletions(-)

--===============6269071753026395836==--

