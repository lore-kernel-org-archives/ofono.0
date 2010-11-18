Content-Type: multipart/mixed; boundary="===============6014058136996744498=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH] doc: fix typos
Date: Thu, 18 Nov 2010 17:11:45 +0200
Message-ID: <1290093105-6362-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6014058136996744498==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/voicecallmanager-api.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
index 11af23a..d960f3c 100644
--- a/doc/voicecallmanager-api.txt
+++ b/doc/voicecallmanager-api.txt
@@ -18,10 +18,10 @@ Methods		array{object,dict} GetCalls()
 		object Dial(string number, string hide_callerid)
 =

 			Initiates a new outgoing call. Returns the object path
-			to the newly created call. The clir variable holds
-			the CLIR override for this call.
+			to the newly created call. The hide_callerid variable
+			holds the CLIR override for this call.
 			The defines values are:
-				"" or "default" - Default (Netowrk) CLIR mode
+				"" or "default" - Default (Network) CLIR mode
 							is used
 				"enabled" - Hides callerid, CLIR Invocation
 						is used
-- =

1.7.1


--===============6014058136996744498==--

