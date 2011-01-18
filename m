Content-Type: multipart/mixed; boundary="===============2582063535396417256=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 3/5] doc: Add documentation for 'forced-mode'
Date: Tue, 18 Jan 2011 15:19:05 +0200
Message-ID: <1295356747-29758-4-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1295356747-29758-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2582063535396417256==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/network-api.txt |   24 ++++++++++++++----------
 1 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/doc/network-api.txt b/doc/network-api.txt
index c252988..c46e81b 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -75,21 +75,25 @@ Properties	string Mode [readonly]
 			method of an operator is called.
 =

 			The possible values are:
-				"auto"     Network registration is performed
-				           automatically.
-				"manual"   Network operator is selected
-				           manually. If the operator is
-				           currently not selected, registration
-				           is not attempted
-				"off"      Unregisters from currently selected
-				           network, if any, and does not
-				           attempt to register again.
+				"auto"         Network registration is performed
+				               automatically.
+				"forced-auto"  Network registration is performed
+					       automatically while manual
+				               selection is disabled.
+				"manual"       Network operator is selected
+				               manually. If the operator is
+				               currently not selected,
+				               registration is not attempted.
+				"off"          Unregisters from currently
+				               selected network, if any, and
+				               does not attempt to register
+				               again.
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


--===============2582063535396417256==--

