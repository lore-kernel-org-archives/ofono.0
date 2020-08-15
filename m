Content-Type: multipart/mixed; boundary="===============0904426191074648348=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [RFC PATCH 0/4] gemalto: USB ethernet data path for ELS81x
Date: Sun, 16 Aug 2020 00:43:54 +0300
Message-ID: <20200815214358.69100-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0904426191074648348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis and all,

This patch series suggests several updates and fixes for gemalto modems,
in particular for ELS81x device. Major change enables data path via USB
ethernet interface for modems supporting this feature.

Before submitting this patch series, I figured out that similar changes
have been already submitted to ofono mailing list back in 2017. At that
time they were aimed at PLS8 device:

https://lists.syncevolution.org/hyperkitty/list/ofono(a)ofono.org/thread/CH=
QZ2LY6D7J75MLYENACM6JDFHNN5GJ5/#3JB3RF5WVW2U6R65UHA6POSRROUNV6ET

It looks like not all the pieces from the original patches finally
landed in the ofono code base. I am not sure why they were not
merged, so I marked this series as RFC.

Regards,
Sergey

Sergey Matyukevich (4):
  drivers: gemalto: add gprs-context driver
  plugins: udevng: detect gemalto network interfaces
  plugins: gemalto: add optional gprs-context driver
  plugins: gemalto: fix incomplete at-chat shutdown

 Makefile.am                         |   3 +-
 drivers/gemaltomodem/gemaltomodem.c |   4 +-
 drivers/gemaltomodem/gemaltomodem.h |   3 +
 drivers/gemaltomodem/gprs-context.c | 280 ++++++++++++++++++++++++++++
 plugins/gemalto.c                   |  20 +-
 plugins/udevng.c                    |  14 +-
 6 files changed, 318 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gemaltomodem/gprs-context.c

-- =

2.28.0

--===============0904426191074648348==--

