Content-Type: multipart/mixed; boundary="===============1087586411738386463=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH 0/3] gemalto: radio-setings driver
Date: Sun, 04 Jul 2021 18:53:45 +0300
Message-ID: <20210704155348.432964-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1087586411738386463==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

This patch series includes Gemalto specific radio-settings driver
and minor ussd fix.

Regards,
Sergey

Sergey Matyukevich (3):
  gemalto: add radio-settings driver
  plugins: gemalto: add radio-settings atom
  plugins: gemalto: move ussd atom to post_online

 Makefile.am                           |   1 +
 drivers/gemaltomodem/gemaltomodem.c   |   2 +
 drivers/gemaltomodem/gemaltomodem.h   |   3 +
 drivers/gemaltomodem/radio-settings.c | 267 ++++++++++++++++++++++++++
 plugins/gemalto.c                     |   6 +-
 5 files changed, 277 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gemaltomodem/radio-settings.c

--===============1087586411738386463==--

