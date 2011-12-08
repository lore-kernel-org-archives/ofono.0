Content-Type: multipart/mixed; boundary="===============2445270541489818386=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v1 0/4] Manage Dormant property notification for CDMA modems
Date: Thu, 08 Dec 2011 12:00:26 +0100
Message-ID: <1323342030-9175-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2445270541489818386==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Change log from v0:
	- Only notify the dormant state to the cdma-connman atom
	- A new set of patches will be sent to control dormancy
	  mode.

Kind regards,
Guillaume

Guillaume Zajac (4):
  cdma-connman: Add dormant state notification API
  cdma-connman: Add dormant state notification API definition
  huaweicdma: Tweak plugin to notify dormant state
  cdmamodem: Register dormant state callback for huawei modems

 drivers/cdmamodem/connman.c |   42 +++++++++++++++++++++++++++++++++++++++=
+++
 include/cdma-connman.h      |    3 +++
 plugins/huaweicdma.c        |    7 ++++++-
 src/cdma-connman.c          |   17 +++++++++++++++++
 4 files changed, 68 insertions(+), 1 deletions(-)


--===============2445270541489818386==--

