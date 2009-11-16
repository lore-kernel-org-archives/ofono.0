Content-Type: multipart/mixed; boundary="===============6750177963000487238=="
MIME-Version: 1.0
From: Martin Xu <martin.xu@intel.com>
Subject: [PATCH 1/1] add Settings property description to
 dataconnectionmanger-api.txt
Date: Mon, 16 Nov 2009 12:05:04 +0800
Message-ID: <1258344304-981-1-git-send-email-martin.xu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6750177963000487238==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/dataconnectionmanager-api.txt |   35 +++++++++++++++++++++++----------=
--
 1 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/doc/dataconnectionmanager-api.txt b/doc/dataconnectionmanager-=
api.txt
index 41fc02f..7afdf99 100644
--- a/doc/dataconnectionmanager-api.txt
+++ b/doc/dataconnectionmanager-api.txt
@@ -161,24 +161,35 @@ Properties	boolean Activated [readwrite]
 			purposes.  This value cannot be changed when the
 			context is active.
 =

-		string Interface [readonly, optional]
+		dict Settings [readonly, optonal]
 =

-			Holds the interface of the network interface created
-			by this context (e.g. "ppp0")
+			Holds all the IP network settings
 =

-		string Address [readonly, optional]
+			string Interface [readonly, optional]
 =

-			Holds the IP address for this context.
+				Holds the interface of the network interface used
+				by this context (e.g. "ppp0" "usb0")
 =

-		string Netmask [readonly, optional]
+			string Method [readonly, optional]
 =

-			Holds the Netmask for this context.
+				Holds the IP network config method
+					"static"- Set IP network statically
+					"dhcp"  - Set IP network through DHCP
 =

-		array{string} DomainNameServers [readonly, optional]
+			string Address [readonly, optional]
 =

-			Holds the list of domain name servers for this
-			context.
+				Holds the IP address for this context.
 =

-		string Gateway [readonly, optional]
+			string Netmask [readonly, optional]
+
+				Holds the Netmask for this context.
+
+			array{string} DomainNameServers [readonly, optional]
+
+				Holds the list of domain name servers for this
+				context.
+
+			string Gateway [readonly, optional]
+
+				Holds the gateway IP for this connection.
 =

-			Holds the gateway IP for this connection.
-- =

1.6.1.3


--===============6750177963000487238==--

