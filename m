Content-Type: multipart/mixed; boundary="===============6112608875350545675=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [RESEND] IPv6 support
Date: Mon, 14 Feb 2011 13:50:32 +0200
Message-ID: <1297684245-9737-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6112608875350545675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

Here are the IPv6 patches again, rebased to current master.

Regards,

	MikaL

[RESEND PATCH 01/13] gprs: factor out common code
[RESEND PATCH 02/13] gprs: Update documentation for IPv6
[RESEND PATCH 03/13] gprs: driver interface changes for IPv6
[RESEND PATCH 04/13] gprs: core support for IPv6
[RESEND PATCH 05/13] test: modify test scripts for IPv6
[RESEND PATCH 06/13] isimodem: IPv6 support
[RESEND PATCH 07/13] atmodem: update to new gprs context interface
[RESEND PATCH 08/13] huaweimodem: update to new gprs context interface
[RESEND PATCH 09/13] mbmmodem: update to new gprs context interface
[RESEND PATCH 10/13] hsomodem: update to new gprs context interface
[RESEND PATCH 11/13] ifxmodem: update to new gprs context interface
[RESEND PATCH 12/13] stemodem: update to new gprs context interface
[RESEND PATCH 13/13] phonesim: add IPv6 support

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

--===============6112608875350545675==--

