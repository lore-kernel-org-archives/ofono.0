Content-Type: multipart/mixed; boundary="===============4991486703802691958=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 3/4] doc: rename CalledLine* properties
Date: Wed, 29 Dec 2010 00:41:01 -0200
Message-ID: <1293590462-3516-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1293590462-3516-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4991486703802691958==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/call-settings-api.txt         |    4 ++--
 doc/supplementaryservices-api.txt |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/call-settings-api.txt b/doc/call-settings-api.txt
index a454621..b6dc1cc 100644
--- a/doc/call-settings-api.txt
+++ b/doc/call-settings-api.txt
@@ -42,7 +42,7 @@ Properties	string CallingLinePresentation [readonly]
 				"enabled",
 				"unknown"
 =

-		string CalledLinePresentation [readonly]
+		string ConnectedLinePresentation [readonly]
 =

 			Contains the value of the connected line identification
 			presentation property.  The value indicates the state
@@ -54,7 +54,7 @@ Properties	string CallingLinePresentation [readonly]
 				"enabled",
 				"unknown"
 =

-		string CalledLineRestriction [readonly]
+		string ConnectedLineRestriction [readonly]
 =

 			Contains the value of the connected line identification
 			restriction property. The value indicates the state of
diff --git a/doc/supplementaryservices-api.txt b/doc/supplementaryservices-=
api.txt
index 0857412..820cce1 100644
--- a/doc/supplementaryservices-api.txt
+++ b/doc/supplementaryservices-api.txt
@@ -89,9 +89,9 @@ The first return argument and the corresponding second re=
turn argument are:
 					dict cf_dict)
 	"CallWaiting"			(string ss_op, dict cw_dict)
 	"CallingLinePresentation"	(string ss_op, string status)
-	"CalledLinePresentation"	(string ss_op, string status)
+	"ConnectedLinePresentation"	(string ss_op, string status)
 	"CallingLineRestriction"	(string ss_op, string clir_status)
-	"CalledLineRestriction"		(string ss_op, string status)
+	"ConnectedLineRestriction"	(string ss_op, string status)
 =

 ss_op contains the supplementary service operation:
 =

-- =

1.7.3.4


--===============4991486703802691958==--

