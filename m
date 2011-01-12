Content-Type: multipart/mixed; boundary="===============4612477187481769518=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 8/9] doc: add CalledLinePresentation property to CallSettings
Date: Wed, 12 Jan 2011 09:27:46 -0200
Message-ID: <1294831667-7447-9-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1294831667-7447-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4612477187481769518==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/call-settings-api.txt |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/doc/call-settings-api.txt b/doc/call-settings-api.txt
index b6dc1cc..44e0dbb 100644
--- a/doc/call-settings-api.txt
+++ b/doc/call-settings-api.txt
@@ -30,6 +30,21 @@ Properties	string CallingLinePresentation [readonly]
 				"enabled",
 				"unknown"
 =

+Properties	string CalledLinePresentation [readonly]
+
+			Contains the value of the called line identification
+			presentation property.  The value indicates the state
+			of the CDIP supplementary service in the network.  If
+			enabled, when receiving a call the network will provide
+			the identification dialed to makee this call.  This is
+			useful when subscriber can be registered with more than
+			one identification.
+
+			Possible values are:
+				"disabled",
+				"enabled",
+				"unknown"
+
 		string CallingNamePresentation [readonly]
 =

 			Contains the value of the calling name identification
-- =

1.7.3.5


--===============4612477187481769518==--

