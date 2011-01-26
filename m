Content-Type: multipart/mixed; boundary="===============4969829733799525133=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 3/4] doc: Add documentation for 'auto-only' mode
Date: Wed, 26 Jan 2011 11:19:28 +0200
Message-ID: <1296033569-26774-4-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1296033569-26774-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4969829733799525133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/network-api.txt |   17 ++++++++++-------
 1 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/doc/network-api.txt b/doc/network-api.txt
index 75187cd..2f13a9c 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -69,18 +69,21 @@ Properties	string Mode [readonly]
 			method of an operator is called.
 =

 			The possible values are:
-				"auto"     Network registration is performed
-				           automatically.
-				"manual"   Network operator is selected
-				           manually. If the operator is
-				           currently not selected, registration
-				           is not attempted
+				"auto"       Network registration is performed
+				             automatically.
+				"auto-only"  Network registration is performed
+					     automatically, and manual
+				             selection is disabled.
+				"manual"     Network operator is selected
+				             manually. If the operator is
+				             currently not selected,
+				             registration is not attempted.
 =

 		string Status [readonly]
 =

 			The current registration status of a modem.
 =

-			The possible values are: =

+			The possible values are:
 				"unregistered"  Not registered to any network
 				"registered"    Registered to home network
 				"searching"     Not registered, but searching
-- =

1.7.1


--===============4969829733799525133==--

