Content-Type: multipart/mixed; boundary="===============9144968234173452526=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 5/6] doc: Remove deregister method documentation
Date: Wed, 19 Jan 2011 23:53:54 +0200
Message-ID: <1295474035-7142-6-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1295474035-7142-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9144968234173452526==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/network-api.txt |    9 ---------
 1 files changed, 0 insertions(+), 9 deletions(-)

diff --git a/doc/network-api.txt b/doc/network-api.txt
index 3e705e6..75187cd 100644
--- a/doc/network-api.txt
+++ b/doc/network-api.txt
@@ -30,12 +30,6 @@ Methods		dict GetProperties()
 =

 			Possible Errors: [service].Error.InvalidArguments
 =

-		void Deregister()
-
-			Completely unregisters from the network
-
-			Possible Errors: [service].Error.InvalidArguments
-
 		array{object,dict} GetOperators()
 =

 			Retrieve array of operator object and properties.
@@ -81,9 +75,6 @@ Properties	string Mode [readonly]
 				           manually. If the operator is
 				           currently not selected, registration
 				           is not attempted
-				"off"      Unregisters from currently selected
-				           network, if any, and does not
-				           attempt to register again.
 =

 		string Status [readonly]
 =

-- =

1.7.1


--===============9144968234173452526==--

