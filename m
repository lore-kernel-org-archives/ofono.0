Content-Type: multipart/mixed; boundary="===============7298121086274616826=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 09/10] Bearer documentation
Date: Mon, 10 Jan 2011 15:15:24 +0200
Message-ID: <1294665325-11937-9-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <201101101515.04596.remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7298121086274616826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/connman-api.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/doc/connman-api.txt b/doc/connman-api.txt
index b13efd1..18185d7 100644
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
+			"none" if no data activity is ongoing, or "unknown"
+			if not known.
+
 		string AccessPointName [readwrite]
 =

 			Holds the name of the access point.  This is
-- =

1.7.1


--===============7298121086274616826==--

