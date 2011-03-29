Content-Type: multipart/mixed; boundary="===============5579605824705376347=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] Update overview.txt: add a Modem Emulator paragraph in work
 in progress section.
Date: Tue, 29 Mar 2011 18:33:17 +0200
Message-ID: <1301416397-9639-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5579605824705376347==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/overview.txt |    8 +++++++-
 1 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/doc/overview.txt b/doc/overview.txt
index c93d1ec..8cee617 100644
--- a/doc/overview.txt
+++ b/doc/overview.txt
@@ -156,8 +156,15 @@ Current implemented features:
 Work in progress features:
 =

 	GPRS
+
 		IPv6 PS context support is under development.
 =

+	Modem Emulator
+
+		To enable DialUp Networking (over Bluetooth or USB), and to
+		allow Bluetooth HandsFree / Headset support, oFono will expose
+		some 'fake' modem to enable the communication with car kits, or
+		other devices.
 =

 Not implemented features:
 =

@@ -202,4 +209,3 @@ Not implemented features:
 		prominent.
 =

 		A similar split like with MMS might be a good idea.
-
-- =

1.7.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============5579605824705376347==--

