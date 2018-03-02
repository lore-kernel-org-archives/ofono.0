Content-Type: multipart/mixed; boundary="===============7589964595427047348=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH v2 0/3] LTE default bearer APN
Date: Fri, 02 Mar 2018 16:12:18 +0100
Message-ID: <20180302151221.18063-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7589964595427047348==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Here's a reworked version of my series for getting the APN for LTE
default bearer.

In this version, we use 'Get LTE Attach Parameters' to query the modem
as to which APN it actually negotiated with the gateway.

Furthermore, the LTE atom now queries the default context and resets
it before allowing the LTE default APN to be set.  This ensures that
the network attach is reproducible and doesn't depend on context
settings that the modem may have persisted.

This patch series provides the ability for QMI modems to set up the
default APN for LTE.  With that, it removes the string 'automatic' that
was used as an APN when we previously couldn't determine what the modem
was using.  With this, connman functions much better across network
technology transitions.

Jonas Bonn (3):
  qmi: add LTE atom driver
  gobi: add LTE atom
  qmimodem: get LTE default bearer APN from modem

 Makefile.am                 |   1 +
 drivers/qmimodem/gprs.c     | 162 +++++++++++++++++++++++++--
 drivers/qmimodem/lte.c      | 266 ++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/qmimodem/qmimodem.c |   2 +
 drivers/qmimodem/qmimodem.h |   3 +
 plugins/gobi.c              |   3 +
 6 files changed, 428 insertions(+), 9 deletions(-)
 create mode 100644 drivers/qmimodem/lte.c

-- =

2.14.1


--===============7589964595427047348==--

