Content-Type: multipart/mixed; boundary="===============1991375720105314856=="
MIME-Version: 1.0
From: =?unknown-8bit?q?R=C3=A9mi?= Denis-Courmont <remi.denis-courmont@nokia.com>
Subject: [PATCH 10/11] Bearer documentation
Date: Tue, 11 Jan 2011 16:08:38 +0200
Message-ID: <1294754919-9687-10-git-send-email-remi.denis-courmont@nokia.com>
In-Reply-To: <1294754919-9687-1-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1991375720105314856==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/connman-api.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/doc/connman-api.txt b/doc/connman-api.txt
index 9e7db3b..9c2f6a4 100644
--- a/doc/connman-api.txt
+++ b/doc/connman-api.txt
@@ -152,6 +152,16 @@ Properties	boolean Active [readwrite]
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


--===============1991375720105314856==--

