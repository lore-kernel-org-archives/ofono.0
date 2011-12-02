Content-Type: multipart/mixed; boundary="===============7181239428343384715=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v0 0/5] Add bearer recovery implementation for CDMA modems
Date: Fri, 02 Dec 2011 15:00:49 +0100
Message-ID: <1322834454-451-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7181239428343384715==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Those patches implement bearer recovery based on huaweicdma specifications.
It will be followed by the Radio Access Technology setting for CDMA modem.

Kind regards,
Guillaume

Guillaume Zajac (5):
  doc: Add bearer property
  cdma-connman: Add bearer notification public function declaration
  cdma-connman: Add bearer property implementation
  cdmamodem: Add bearer recovery into connman driver
  huaweicdma: Specify vendor ID while creating cdma-connman atom

 doc/cdma-connman-api.txt    |    8 +++++++
 drivers/cdmamodem/connman.c |   45 +++++++++++++++++++++++++++++++++++++++
 include/cdma-connman.h      |    3 ++
 plugins/huaweicdma.c        |    5 +++-
 src/cdma-connman.c          |   49 +++++++++++++++++++++++++++++++++++++++=
++++
 src/common.h                |    1 +
 6 files changed, 110 insertions(+), 1 deletions(-)


--===============7181239428343384715==--

