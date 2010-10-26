Content-Type: multipart/mixed; boundary="===============2787920172342527705=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 0/6] Fast dormancy support
Date: Tue, 26 Oct 2010 18:31:47 +0300
Message-ID: <1288107113-2740-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2787920172342527705==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

Here's another go at fast dormancy.

Br,

	MikaL

[PATCH 1/6] radio settings: fix mode initializion
[PATCH 2/6] stemodem: add default case
[PATCH 3/6] radio settings: add FastDormancy property
[PATCH 4/6] test: add script to control fast dormancy
[PATCH 5/6] isimodem: add support for FastDormancy property
[PATCH 6/6] TODO: mark fast dormancy as done

 Makefile.am                       |    3 +-
 TODO                              |   20 ------
 doc/features.txt                  |    8 +++
 drivers/isimodem/radio-settings.c |   91 ++++++++++++++++++++++++++++-
 drivers/stemodem/radio-settings.c |    2 +-
 include/radio-settings.h          |   22 ++++++-
 src/radio-settings.c              |  116 +++++++++++++++++++++++++++++++++=
+--
 test/set-fast-dormancy            |   25 ++++++++
 8 files changed, 253 insertions(+), 34 deletions(-)

--===============2787920172342527705==--

