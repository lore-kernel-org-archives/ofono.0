Content-Type: multipart/mixed; boundary="===============4172876343141245888=="
MIME-Version: 1.0
From: Jonas Bonn <jonas@southpole.se>
Subject: [PATCH 0/4] LTE default bearer APN (QMI)
Date: Thu, 01 Mar 2018 11:48:00 +0100
Message-ID: <20180301104804.24058-1-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4172876343141245888==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

When an LTE default bearer is established, an APN is provided to the
gateway from some default settings in the modem.  This APN may be an
empty string or something meaningful depending on how the modem has
been configured, but nonetheless _something_ is used.

In order for connman to be able to handle transitions between LTE and
non-LTE networks, there can only be a single internet context; therefore,
the LTE and non-LTE APN settings really need to be consistent: relying
on a connection with an empty-string APN does not work.

This patch series provides the ability for QMI modems to set up the
default APN for LTE.  With that, it removes the string 'automatic' that
was used as an APN when we previously couldn't determine what the modem
was using.  With this, connman functions much better across network
technology transitions.

Jonas Bonn (4):
  qmi: add LTE atom driver
  qmimodem: initialize LTE driver
  gobi: add LTE atom
  qmimodem: get LTE default bearer APN from modem

 Makefile.am                 |   1 +
 drivers/qmimodem/gprs.c     |  90 ++++++++++++++++++++--
 drivers/qmimodem/lte.c      | 182 ++++++++++++++++++++++++++++++++++++++++=
++++
 drivers/qmimodem/qmimodem.c |   2 +
 drivers/qmimodem/qmimodem.h |   3 +
 plugins/gobi.c              |   3 +
 6 files changed, 273 insertions(+), 8 deletions(-)
 create mode 100644 drivers/qmimodem/lte.c

-- =

2.14.1


--===============4172876343141245888==--

