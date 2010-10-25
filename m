Content-Type: multipart/mixed; boundary="===============4387588418651234691=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 0/6] radio settings: fast dormancy support
Date: Mon, 25 Oct 2010 16:28:04 +0300
Message-ID: <1288013290-6124-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4387588418651234691==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi All,

Here's another go at fast dormancy. I hope I managed to address
the concerns about the previous patch set. A driver implementation
for isimodem is now included.

Br,

	MikaL


[PATCH 1/6] radio settings: add FastDormancy property
[PATCH 2/6] radio settings: document FastDormancy property
[PATCH 3/6] test: add scripts to enable and disable fast dormancy
[PATCH 4/6] isimodem: add support for FastDormancy property
[PATCH 5/6] TODO: mark fast dormancy as done
[PATCH 6/6] AUTHORS: add myself

 AUTHORS                           |    1 +
 Makefile.am                       |    4 +-
 TODO                              |   20 ------
 doc/features.txt                  |    8 ++
 doc/radio-settings-api.txt        |   59 +++++++++++-----
 drivers/isimodem/radio-settings.c |   91 +++++++++++++++++++++++++-
 include/radio-settings.h          |   11 +++
 src/radio-settings.c              |  134 +++++++++++++++++++++++++++++++++=
---
 test/disable-fast-dormancy        |   20 ++++++
 test/enable-fast-dormancy         |   20 ++++++
 10 files changed, 316 insertions(+), 52 deletions(-)

--===============4387588418651234691==--

