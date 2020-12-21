Content-Type: multipart/mixed; boundary="===============8040360524462238673=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [PATCH 0/5] gemalto: gprs context driver updates
Date: Mon, 21 Dec 2020 23:01:28 +0300
Message-ID: <20201221200133.522933-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8040360524462238673==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis and all,

This patch series includes several updates and fixes for gemalto gprs
context driver based on testing and troubleshooting in several regions.
Major changes include support for automatic context activation and fixes
for gprs context deactivation.

Besides support for automatic context activation uncovered an issue with
normal activation sequence. According to modem specs, AT+CGACT should
not be used for contexts handled by AT^SWWAN. However wrong sequence
used to work when re-activating contexts already activated automatically,
while correct sequence produced incorrect modem DHCP responces.

Regards,
Sergey

Sergey Matyukevich (5):
  plugin: gemalto: fix source of gprs notifications
  gemalto: gprs: cgev gprs context deactivation
  gemalto: gprs: support automatic context activation
  gemalto: gprs: support different gprs protocols
  gemalto: gprs: support authentication settings

 drivers/gemaltomodem/gprs-context.c | 176 ++++++++++++++++++++--------
 plugins/gemalto.c                   |   2 +-
 2 files changed, 125 insertions(+), 53 deletions(-)

-- =

2.29.2

--===============8040360524462238673==--

