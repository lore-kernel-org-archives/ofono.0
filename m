Content-Type: multipart/mixed; boundary="===============7618400072981089817=="
MIME-Version: 1.0
From: mario@tokarz.eu
Subject: [PATCH 0/2] Some boiler plate code for dunmodem
Date: Wed, 03 Aug 2011 13:48:28 +0200
Message-ID: <1312372110-23541-1-git-send-email-mario@tokarz.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7618400072981089817==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mario Tokarz <mario.tokarz@bmw-carit.de>

Hi, =


I saw Marcel being active on that one. I need to apologize for my
suboptimal time management, but still here's some boiler plate I wrote
which might save some typing.


Best,
Mario

Mario Tokarz (2):
  bluetooth: Add UUID for DUN.
  dunmodem: Add stub for gprs.

 Makefile.am                 |    3 +-
 drivers/dunmodem/dunmodem.c |    2 +
 drivers/dunmodem/dunmodem.h |    3 +
 drivers/dunmodem/gprs.c     |   99 +++++++++++++++++++++++++++++++++++++++=
++++
 plugins/bluetooth.h         |    1 +
 5 files changed, 107 insertions(+), 1 deletions(-)
 create mode 100644 drivers/dunmodem/gprs.c

-- =

1.7.4.1


--===============7618400072981089817==--

