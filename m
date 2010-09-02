Content-Type: multipart/mixed; boundary="===============2018810865253957157=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] doc: clarify password usage in call barring api
Date: Thu, 02 Sep 2010 16:26:08 +0300
Message-ID: <1283433968-11970-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2018810865253957157==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 doc/call-barring-api.txt |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/doc/call-barring-api.txt b/doc/call-barring-api.txt
index 41ae4b1..9c615c7 100644
--- a/doc/call-barring-api.txt
+++ b/doc/call-barring-api.txt
@@ -26,11 +26,11 @@ Methods		dict GetProperties()
 =

 			Disables barrings for outgoing calls.
 =

-		void SetProperty(string property, variant value, string pin2)
+		void SetProperty(string property, variant value, string netpwd)
 =

 			Sets the given property value to that specified in
-			call parameter.  For all properties, the password
-			(typically PIN2) must be provided.
+			call parameter.  For all properties, the network
+			password must be provided.
 =

 Signals		PropertyChanged(string property, variant value)
 =

-- =

1.7.0.4


--===============2018810865253957157==--

