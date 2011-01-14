Content-Type: multipart/mixed; boundary="===============3354368704480470413=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH] doc: add CalledLinePresentation property to CallSettings
Date: Fri, 14 Jan 2011 11:47:14 -0200
Message-ID: <1295012834-5691-1-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <AANLkTimBgcxwOns3LBSFTBXKHV-XmKDpwSMYyjOfUisz@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3354368704480470413==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/call-settings-api.txt |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/doc/call-settings-api.txt b/doc/call-settings-api.txt
index b6dc1cc..46a1059 100644
--- a/doc/call-settings-api.txt
+++ b/doc/call-settings-api.txt
@@ -30,6 +30,21 @@ Properties	string CallingLinePresentation [readonly]
 				"enabled",
 				"unknown"
 =

+		string CalledLinePresentation [readonly]
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


--===============3354368704480470413==--

