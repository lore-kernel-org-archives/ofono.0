Content-Type: multipart/mixed; boundary="===============3016311466180963858=="
MIME-Version: 1.0
From: Christophe Ronco <c.ronco@kerlink.fr>
Subject: [PATCH 0/2] huawei E3372: add LTE support
Date: Wed, 06 Sep 2017 11:42:24 +0200
Message-ID: <1504690946-11705-1-git-send-email-c.ronco@kerlink.fr>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3016311466180963858==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Here is a first version of patches to support LTE with E3372 USB keys.

Huawei has two AT command sets to deal with band and mode (technologies).
Standard AT commands set (AT^SYSCFG, AT^SYSINFO, ^MODE, ...) handle 2G and =
3G technologies only.
Extended AT commands set (AT^SYSCFGEX, AT^SYSINFOEX, ^HSCQ, ...) handle 2G,=
 3G and 4G technologies.
Extended commands are described in this document (downloadable on the web): =

HUAWEI ME906s LTE Module AT Command Interface Specification-(V100R001_01, 0=
English).pdf

Huawei driver in Ofono uses standard AT command set. When it says to use an=
y band in any technology to connect, this disable 4G. =

Fix consists in using the other command set to do the same thing when it is=
 supported.

^HCSQ notification is also able to report LTE attachment while ^MODE report=
s UMTS attachment when modem is attached in 4G.

Tests have been done only with E3372, with 3G and 4G SIM cards. I don't hav=
e any 3G only huawei modem.


Technology report in network-registration.c works only because notification=
 come in this order:
1) PCUI: < \r\n^MODE: 5,4\r\n
2) PCUI: < \r\n^HCSQ:"LTE",38,34,101,28\r\n
3) PCUI: < \r\n^SRVST: 2\r\n\r\n+CREG: 1,"C0FA","00107202"\r\n

I have never seen notifications in other order but I don't have a Huawei do=
cument saying it won't happen.

I will be happy to have your comments on these patches.

Best Regards,

Christophe Ronco

Christophe Ronco (2):
  huawei: add LTE support
  atmodem: correctly report lte bearer for huawei modems

 drivers/atmodem/gprs.c                 |  22 ++++
 drivers/atmodem/network-registration.c |  25 ++++
 drivers/huaweimodem/radio-settings.c   | 213 +++++++++++++++++++++++++++++=
+---
 3 files changed, 244 insertions(+), 16 deletions(-)

-- =

2.7.4


--===============3016311466180963858==--

