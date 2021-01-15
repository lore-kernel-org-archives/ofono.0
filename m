Content-Type: multipart/mixed; boundary="===============9110840648869579239=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH v2 0/3]  gemalto: netmon driver
Date: Fri, 15 Jan 2021 19:25:44 +0300
Message-ID: <20210115162547.17156-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9110840648869579239==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis and all,

This patch series implements netmon driver for gemalto modems that are
able to provide basic measurements using AT+CQS and AT^SMONI commands.
For now netmon driver is enabled for ELS81x modems.

Regards,
Sergey

v1 -> v2

- use g_new0 instead of g_try_new0
- remove rssi scaling: keep using 27.007 range
- scale modem measurement reports to ranges recommended by 27.007

Sergey Matyukevich (3):
  gemalto: add netmon driver
  plugin: gemalto: enable netmon
  gemalto: netmon measurements scaling

 Makefile.am                         |   3 +-
 drivers/gemaltomodem/gemaltomodem.c |   2 +
 drivers/gemaltomodem/gemaltomodem.h |   3 +
 drivers/gemaltomodem/netmon.c       | 649 ++++++++++++++++++++++++++++
 plugins/gemalto.c                   |   6 +
 5 files changed, 662 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gemaltomodem/netmon.c

--===============9110840648869579239==--

