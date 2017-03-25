Content-Type: multipart/mixed; boundary="===============0994829285146397169=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH qmi 0/5] QMI patches
Date: Sat, 25 Mar 2017 17:57:50 +0100
Message-ID: <20170325165755.28114-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0994829285146397169==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a series of cleanups related to QMI modems.

You might want to consider patch 5 as an object for review more than
submission.  It's what I'm currently using with my UC21.

Jonas Bonn (5):
  qmimodem: fix typo
  qmimodem: add WDA service string
  gobi: query presence of WDA service
  gobi: take LLP-matching code from qmimodem
  udevng: add qmiwwan modem driver

 drivers/qmimodem/gprs-context.c | 74 +------------------------------------=
--
 drivers/qmimodem/qmi.c          |  4 ++-
 plugins/gobi.c                  | 77 +++++++++++++++++++++++++++++++++++++=
++++
 plugins/udevng.c                | 41 ++++++++++++++++++++++
 4 files changed, 122 insertions(+), 74 deletions(-)

-- =

2.9.3


--===============0994829285146397169==--

