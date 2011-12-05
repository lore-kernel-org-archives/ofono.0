Content-Type: multipart/mixed; boundary="===============8236622595196108631=="
MIME-Version: 1.0
From: Guillaume Zajac <guillaume.zajac@linux.intel.com>
Subject: [PATCH_v1 1/2] doc: Add RoamingAllowed property
Date: Mon, 05 Dec 2011 12:04:01 +0100
Message-ID: <1323083042-24416-2-git-send-email-guillaume.zajac@linux.intel.com>
In-Reply-To: <1323083042-24416-1-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8236622595196108631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/cdma-connman-api.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/doc/cdma-connman-api.txt b/doc/cdma-connman-api.txt
index 48699a3..319c973 100644
--- a/doc/cdma-connman-api.txt
+++ b/doc/cdma-connman-api.txt
@@ -45,6 +45,14 @@ Properties	boolean Powered [readwrite]
 			Holds the password to be used for authentication
 			purposes.
 =

+		boolean RoamingAllowed [readwrite]
+
+			Contains whether data roaming is allowed.  In the off
+			setting, if the packet radio registration state
+			indicates that the modem is roaming, oFono will
+			automatically shutdown connection and no further
+			connection establishment will be possible.
+
 		dict Settings [readonly, optional]
 =

 			Holds all the IP network settings
-- =

1.7.1


--===============8236622595196108631==--

