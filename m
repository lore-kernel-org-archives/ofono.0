Content-Type: multipart/mixed; boundary="===============4439168988533144441=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 6/6] Bearer documentation
Date: Thu, 25 Nov 2010 17:14:38 +0200
Message-ID: <1290698078-18803-6-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <201011251714.19241.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4439168988533144441==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/connman-api.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/doc/connman-api.txt b/doc/connman-api.txt
index b13efd1..709418c 100644
--- a/doc/connman-api.txt
+++ b/doc/connman-api.txt
@@ -150,6 +150,16 @@ Properties	boolean Active [readwrite]
 			Holds whether the context is activated.  This value
 			can be set to activate / deactivate the context.
 =

+		string Bearer [readonly, optional]
+
+			Contains the current packet switched bearer of the
+			connection context.
+
+			Possible values are the same as for the Technology
+			property the NetworkRegistration object, plus
+			"none" if no data is ongoing, or "unknown" if not
+			known.
+
 		string AccessPointName [readwrite]
 =

 			Holds the name of the access point.  This is
-- =

1.7.1


--===============4439168988533144441==--

