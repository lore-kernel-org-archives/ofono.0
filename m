Content-Type: multipart/mixed; boundary="===============4434644147225086243=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 0/4] Support for fast formancy
Date: Thu, 07 Oct 2010 16:21:54 +0300
Message-ID: <1286457718-9051-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4434644147225086243==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

The following four patches add core support for fast dormancy.
I have tested the changes with a backend for isimodem. However,
the isimodem implementation has triggered some fairly extensive
revectoring of gisi. The final isimodem patches will be submitted
once the gisi changes are complete.

Br,

	MikaL
--
[PATCH 1/4] radio settings: allow for more than one property
[PATCH 2/4] radio settings: add FastDormancy property
[PATCH 3/4] radio settings: document FastDormancy property
[PATCH 4/4] test: add scripts to enable and disable fast dormancy

 Makefile.am                |    4 +-
 doc/radio-settings-api.txt |   22 ++++++
 include/radio-settings.h   |   12 +++
 src/call-settings.c        |    2 +-
 src/common.c               |    2 +-
 src/radio-settings.c       |  160 ++++++++++++++++++++++++++++++++++++----=
----
 test/disable-fast-dormancy |   20 ++++++
 test/enable-fast-dormancy  |   20 ++++++
 8 files changed, 210 insertions(+), 32 deletions(-)

--===============4434644147225086243==--

