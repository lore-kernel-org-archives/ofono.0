Content-Type: multipart/mixed; boundary="===============6846333380289201670=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH 0/2] Add dormant notification support for speedupcdma modems
Date: Mon, 12 Dec 2011 12:11:35 +0100
Message-ID: <1323688297-2538-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6846333380289201670==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Those 2 patches added dormant notification support for SpeedUp CDMA modems.
The prefix used for notification is the same as Huawei modem one.

Kind regards,
Guillaume

Guillaume Zajac (2):
  cdmamodem: Support speedup dormant notification
  speedupcdma: Tweak plugin to notify dormant state

 drivers/cdmamodem/connman.c |    5 +++++
 plugins/speedupcdma.c       |    7 ++++++-
 2 files changed, 11 insertions(+), 1 deletions(-)


--===============6846333380289201670==--

