Content-Type: multipart/mixed; boundary="===============2232797456938082687=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 3/3] doc: rename CalledLine* properties in call-settings
Date: Tue, 28 Dec 2010 17:22:36 -0200
Message-ID: <1293564156-3628-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1293564156-3628-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2232797456938082687==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/call-settings-api.txt |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

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
-- =

1.7.3.4


--===============2232797456938082687==--

