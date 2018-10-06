Content-Type: multipart/mixed; boundary="===============0003350736393363516=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 1/5] connman-api: added "none" auth_method
Date: Sat, 06 Oct 2018 07:45:16 +0200
Message-ID: <20181006054520.26737-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0003350736393363516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/connman-api.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/doc/connman-api.txt b/doc/connman-api.txt
index 9220d0de..578b9755 100644
--- a/doc/connman-api.txt
+++ b/doc/connman-api.txt
@@ -192,7 +192,8 @@ Properties	boolean Active [readwrite]
 =

 		string AuthenticationMethod [readwrite]
 			Holds the PPP authentication method to use.  Valid
-			values are "pap" and "chap".  Defaults to "chap".
+			values are "pap", "chap" and "none".
+			Defaults to "chap".
 =

 		string Username [readwrite]
 =

-- =

2.17.1


--===============0003350736393363516==--

