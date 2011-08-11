Content-Type: multipart/mixed; boundary="===============3822028266622836595=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 0/2] Add CDMA features to load/save credentials
Date: Thu, 11 Aug 2011 18:02:37 +0200
Message-ID: <1313078559-13780-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3822028266622836595==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Change log from v1 is:
	- pass to post_sim state when serial is received
	- cdma-connman atom can load settings as mode serial is received before
	  its creation.
	- create new devinfo API to pass serial to cdma-connman atom

Guillaume Zajac (2):
  modem: Change to online state when serial is set
  cdma-connman: Add feature to load/save credentials

 include/devinfo.h  |    2 +
 src/cdma-connman.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/modem.c        |   23 +++++++++++++++--
 3 files changed, 89 insertions(+), 3 deletions(-)


--===============3822028266622836595==--

