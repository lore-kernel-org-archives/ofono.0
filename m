Content-Type: multipart/mixed; boundary="===============1848531594307400399=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [RESEND 3 PATCH 00/13] IPv6 Support
Date: Mon, 07 Mar 2011 16:02:26 +0200
Message-ID: <1299506559-32365-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1848531594307400399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

Patches rebased to current master.

Regards,

	MikaL

"IPv6 host walked into a bar. No-one would talk to it."

[RESEND 3 PATCH 01/13] gprs: factor out common code
[RESEND 3 PATCH 02/13] gprs: Update documentation for IPv6
[RESEND 3 PATCH 03/13] gprs: driver interface changes for IPv6
[RESEND 3 PATCH 04/13] gprs: core support for IPv6
[RESEND 3 PATCH 05/13] test: modify test scripts for IPv6
[RESEND 3 PATCH 06/13] isimodem: IPv6 support
[RESEND 3 PATCH 07/13] atmodem: update to new gprs context interface
[RESEND 3 PATCH 08/13] huaweimodem: update to new gprs context interface
[RESEND 3 PATCH 09/13] mbmmodem: update to new gprs context interface
[RESEND 3 PATCH 10/13] hsomodem: update to new gprs context interface
[RESEND 3 PATCH 11/13] ifxmodem: update to new gprs context interface
[RESEND 3 PATCH 12/13] stemodem: update to new gprs context interface
[RESEND 3 PATCH 13/13] phonesim: add IPv6 support

 Makefile.am                        |    3 +-
 doc/connman-api.txt                |    9 +-
 drivers/atmodem/gprs-context.c     |   41 ++--
 drivers/hsomodem/gprs-context.c    |   48 +++--
 drivers/huaweimodem/gprs-context.c |   43 +++--
 drivers/ifxmodem/gprs-context.c    |   36 ++--
 drivers/isimodem/gprs-context.c    |  119 +++++++-----
 drivers/mbmmodem/gprs-context.c    |   65 ++++---
 drivers/stemodem/gprs-context.c    |   30 ++-
 include/gprs-context.h             |   27 ++-
 plugins/phonesim.c                 |   32 +++-
 src/gprs.c                         |  390 ++++++++++++++++++++++++--------=
----
 test/set-context-property          |   38 ++++
 13 files changed, 580 insertions(+), 301 deletions(-)

--===============1848531594307400399==--

