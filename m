Content-Type: multipart/mixed; boundary="===============7198398675860024494=="
MIME-Version: 1.0
From: Gustavo F. Padovan <padovan@profusion.mobi>
Subject: [PATCH 12/14] doc: add CallingNamePresentation property to
 CallSettings
Date: Mon, 06 Dec 2010 18:12:40 -0200
Message-ID: <1291666362-19128-12-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291666362-19128-11-git-send-email-padovan@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7198398675860024494==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/call-settings-api.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/doc/call-settings-api.txt b/doc/call-settings-api.txt
index e98ce0c..a454621 100644
--- a/doc/call-settings-api.txt
+++ b/doc/call-settings-api.txt
@@ -30,6 +30,18 @@ Properties	string CallingLinePresentation [readonly]
 				"enabled",
 				"unknown"
 =

+		string CallingNamePresentation [readonly]
+
+			Contains the value of the calling name identification
+			presentation property.  The value indicates
+			the state of the CNAP supplementary service in the
+			network.  If enabled, the network will provide
+			the name of the calling party for incoming calls.
+			Possible values are:
+				"disabled",
+				"enabled",
+				"unknown"
+
 		string CalledLinePresentation [readonly]
 =

 			Contains the value of the connected line identification
-- =

1.7.3.2


--===============7198398675860024494==--

