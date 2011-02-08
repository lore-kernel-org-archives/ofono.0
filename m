Content-Type: multipart/mixed; boundary="===============5926918986836261036=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [PATCH 02/13] gprs: Update documentation for IPv6
Date: Tue, 08 Feb 2011 17:22:15 +0200
Message-ID: <1297178546-9371-3-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1297178546-9371-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5926918986836261036==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/connman-api.txt |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/doc/connman-api.txt b/doc/connman-api.txt
index 22c59dc..de1b938 100644
--- a/doc/connman-api.txt
+++ b/doc/connman-api.txt
@@ -182,7 +182,7 @@ Properties	boolean Active [readwrite]
 		string Protocol [readwrite]
 =

 			Holds the protocol for this context.  Valid values
-			are: "ip" and "ipv6".
+			are: "ip", "ipv6" and "ipv4v6".
 =

 		string Name [readwrite]
 =

@@ -196,7 +196,7 @@ Properties	boolean Active [readwrite]
 =

 			string Interface [readonly, optional]
 =

-				Holds the interface of the network interface
+				Holds the name of the network interface
 				used by this context (e.g. "ppp0" "usb0")
 =

 			string Method [readonly, optional]
@@ -242,6 +242,11 @@ Properties	boolean Active [readwrite]
 				via this proxy.  All other values are left
 				out in this case.
 =

+			string IPv6Address [readonly, optional]
+
+				Holds the IPv6 link local address for this
+				context.
+
 		string MessageProxy [readwrite, MMS only]
 =

 			Holds the MMS Proxy setting.
-- =

1.7.1


--===============5926918986836261036==--

