Content-Type: multipart/mixed; boundary="===============1208110820227071344=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v3 0/4] CDMA Network registration
Date: Fri, 04 Nov 2011 16:28:03 +0100
Message-ID: <1320420487-16334-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1208110820227071344==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

Change log from v2:
	- remove roaming, will be sent separately.
	- remove atom watch, only find_atom when network status is needed.
	- fix issue in ofono_cdma_connman_deactivated()

Kind regards,
Guillaume

Guillaume Zajac (4):
  dbus: Add new D-Bus error message NotRegistered
  cdma-connman: Check cdma-netreg status to enable data call
  cdma-connman: Add public api definition
  cdmamodem: Notify when connection is lost

 drivers/cdmamodem/connman.c |    2 +-
 src/cdma-connman.c          |   45 +++++++++++++++++++++++++++++++++++++++=
+--
 src/dbus.c                  |    7 ++++++
 src/ofono.h                 |    1 +
 4 files changed, 51 insertions(+), 4 deletions(-)


--===============1208110820227071344==--

