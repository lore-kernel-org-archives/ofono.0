Content-Type: multipart/mixed; boundary="===============3003848332737068388=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 2/7] doc: remove RoamingAllowed
Date: Mon, 07 Feb 2011 16:03:07 +0200
Message-ID: <1297087392-31030-2-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <201102071602.20179.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3003848332737068388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/connman-api.txt |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/doc/connman-api.txt b/doc/connman-api.txt
index 22c59dc..4c24701 100644
--- a/doc/connman-api.txt
+++ b/doc/connman-api.txt
@@ -106,14 +106,6 @@ Properties	boolean Attached [readonly]
 			for an appropriate time for GPRS service to resume
 			before taking corrective action.
 =

-		boolean RoamingAllowed [readwrite]
-
-			Contains whether data roaming is allowed.  In the off
-			setting, if the packet radio registration state
-			indicates that the modem is roaming, oFono will
-			automatically detach and no further connection
-			establishment will be possible.
-
 		boolean Powered [readwrite]
 =

 			Controls whether packet radio use is allowed. Setting
-- =

1.7.1


--===============3003848332737068388==--

