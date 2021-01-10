Content-Type: multipart/mixed; boundary="===============5784417363480523386=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [RFC PATCH 0/2] gemalto: netmon driver
Date: Sun, 10 Jan 2021 22:44:03 +0300
Message-ID: <20210110194405.1994055-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5784417363480523386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Denis and all,

This patch series implements netmon driver for gemalto modems that are
able to provide basic measurements using AT+CQS and AT^SMONI commands.

This patch series is intendedly marked as RFC. In addition to general
feedback for this v1 I would like to clarify the right way to handle
negative values that can be returned by modem. For instance, this
is the case for the values measured in dBm including EC/n0 and RSCP.
Currently such values are discarded by CELL_INFO_DICT_APPEND macro.

Regards,
Sergey


Sergey Matyukevich (2):
  gemalto: add netmon driver
  plugin: gemalto: enable netmon

 Makefile.am                         |   3 +-
 drivers/gemaltomodem/gemaltomodem.c |   2 +
 drivers/gemaltomodem/gemaltomodem.h |   3 +
 drivers/gemaltomodem/netmon.c       | 609 ++++++++++++++++++++++++++++
 plugins/gemalto.c                   |   6 +
 5 files changed, 622 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gemaltomodem/netmon.c

--===============5784417363480523386==--

