Content-Type: multipart/mixed; boundary="===============7371757375991638270=="
MIME-Version: 1.0
From: Philip Paeps <philip@paeps.cx>
Subject: [PATCH 5/5] doc: describe the AuthenticationMethod property
Date: Thu, 19 Jun 2014 12:07:09 +0200
Message-ID: <1403172429-26289-6-git-send-email-philip@paeps.cx>
In-Reply-To: <1403172429-26289-1-git-send-email-philip@paeps.cx>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7371757375991638270==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/connman-api.txt |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/connman-api.txt b/doc/connman-api.txt
index 2227ab8..8f72087 100644
--- a/doc/connman-api.txt
+++ b/doc/connman-api.txt
@@ -180,6 +180,10 @@ Properties	boolean Active [readwrite]
 				"wap" - Used by WAP related services
 				"ims" - Used by IMS related services
 =

+		string AuthenticationMethod [readwrite]
+			Holds the PPP authentication method to use.  Valid
+			values are "pap" and "chap".  Defaults to "chap".
+
 		string Username [readwrite]
 =

 			Holds the username to be used for authentication
-- =

1.7.10.4


--===============7371757375991638270==--

