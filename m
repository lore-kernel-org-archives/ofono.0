Content-Type: multipart/mixed; boundary="===============6579486618127818543=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v2 0/3] gemalto: USB ethernet data path for ELS81x
Date: Tue, 18 Aug 2020 23:43:44 +0300
Message-ID: <20200818204347.29516-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6579486618127818543==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis and all,

This patch series enables USB ethernet data path for gemalto modems
that support this feature, in particular for ELS81x devices.

Regards,
Sergey

v1 -> v2

- replace g_try_new0 by use g_new0
- drop patch with incorrect fix for modem init


Sergey Matyukevich (3):
  drivers: gemalto: add gprs-context driver
  plugins: udevng: detect gemalto network interfaces
  plugins: gemalto: alternative gprs-context driver

 Makefile.am                         |   3 +-
 drivers/gemaltomodem/gemaltomodem.c |   4 +-
 drivers/gemaltomodem/gemaltomodem.h |   3 +
 drivers/gemaltomodem/gprs-context.c | 278 ++++++++++++++++++++++++++++
 plugins/gemalto.c                   |  12 +-
 plugins/udevng.c                    |  14 +-
 6 files changed, 308 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gemaltomodem/gprs-context.c

-- =

2.28.0

--===============6579486618127818543==--

