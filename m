Content-Type: multipart/mixed; boundary="===============1164621571699086438=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v2 0/6] CDMA Network registration
Date: Wed, 02 Nov 2011 11:37:55 +0100
Message-ID: <1320230281-20743-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1164621571699086438==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi all,

Change log from v1:
	- create new D-Bus message error whenever modem is not registered to
	  the network
	- manage roaming case.
	- notify cdma-connman atom when data connection is lost.
	- remove cdma-netreg status watches.

Kind regards,
Guillaume

Guillaume Zajac (6):
  dbus: Add new D-Bus error message NotRegistered
  doc: Add RoamingAllowed property
  cdma-connman: Rely on roaming and cdma-netreg status to enable data
    call
  cdma-connman: Add public api to notify connection is lost
  cdma-connman: Add public api definition
  cdmamodem: Notify when connection is lost

 doc/cdma-connman-api.txt    |    8 ++++
 drivers/cdmamodem/connman.c |    2 +-
 include/cdma-connman.h      |    2 +
 src/cdma-connman.c          |   83 +++++++++++++++++++++++++++++++++++++++=
++--
 src/dbus.c                  |    7 ++++
 src/ofono.h                 |    1 +
 6 files changed, 99 insertions(+), 4 deletions(-)


--===============1164621571699086438==--

