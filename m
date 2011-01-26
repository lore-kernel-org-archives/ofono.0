Content-Type: multipart/mixed; boundary="===============8718344484857932864=="
MIME-Version: 1.0
From: Mika Liljeberg <mika.liljeberg@nokia.com>
Subject: [RFC 1/5] gprs: Update documentation for IPv6
Date: Wed, 26 Jan 2011 18:22:46 +0200
Message-ID: <1296058970-11815-2-git-send-email-mika.liljeberg@nokia.com>
In-Reply-To: <1296058970-11815-1-git-send-email-mika.liljeberg@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8718344484857932864==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/connman-api.txt |   48 +++++++++++++++++++++++++++++++++++++++++++-----
 1 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/doc/connman-api.txt b/doc/connman-api.txt
index 22c59dc..b885725 100644
--- a/doc/connman-api.txt
+++ b/doc/connman-api.txt
@@ -152,6 +152,15 @@ Properties	boolean Active [readwrite]
 			Holds whether the context is activated.  This value
 			can be set to activate / deactivate the context.
 =

+			When the "Protocol" property is set to "ipv4v6",
+			oFono will first try to activate a combined "ipv4v6"
+			context (3GPP rel 8). Based on the result, oFono may
+			fall back to an IPv4 only or an IPv6 only context, or
+			activate separate IPv4 and IPv6 contexts under the
+			hood. The Protocol attribute is updated accordingly.
+			The "Settings" and "IPv6Settings" attributes will only
+			appear if the contained network settings are valid.
+
 		string AccessPointName [readwrite]
 =

 			Holds the name of the access point.  This is
@@ -182,7 +191,7 @@ Properties	boolean Active [readwrite]
 		string Protocol [readwrite]
 =

 			Holds the protocol for this context.  Valid values
-			are: "ip" and "ipv6".
+			are: "ip", "ipv6" and "ipv4v6".
 =

 		string Name [readwrite]
 =

@@ -196,8 +205,13 @@ Properties	boolean Active [readwrite]
 =

 			string Interface [readonly, optional]
 =

-				Holds the interface of the network interface
-				used by this context (e.g. "ppp0" "usb0")
+				Holds the name of the IPv4 network interface
+				used by this context (e.g. "ppp0" "usb0").
+
+				For combined IPv4v6 context (3GPP rel 8) the
+				same network interface may be used for both
+				IPv4 and IPv6. IPv4 and IPv6 may also be
+				offered via separate network interfaces.
 =

 			string Method [readonly, optional]
 =

@@ -215,8 +229,8 @@ Properties	boolean Active [readwrite]
 =

 			array{string} DomainNameServers [readonly, optional]
 =

-				Holds the list of domain name servers for this
-				context.
+				Holds the list of domain name servers accessible
+				via this network interface.
 =

 			string Gateway [readonly, optional]
 =

@@ -242,6 +256,30 @@ Properties	boolean Active [readwrite]
 				via this proxy.  All other values are left
 				out in this case.
 =

+		dict IPv6Settings [readonly, optional]
+
+			Holds all the IPv6 network settings.
+
+			string Interface [readonly, optional]
+
+				Holds the name of the IPv6 network interface
+				used by this context (e.g. "ppp0" "usb0").
+
+				For combined IPv4v6 context (3GPP rel 8) the
+				same network interface may be used for both
+				IPv4 and IPv6. IPv4 and IPv6 may also be
+				offered via separate network interfaces.
+
+			string LinkLocal [readonly, optional]
+
+				Holds the IPv6 link local address for this
+				context.
+
+			array{string} DomainNameServers [readonly, optional]
+
+				Holds the list of domain name servers accessible
+				via this network interface.
+
 		string MessageProxy [readwrite, MMS only]
 =

 			Holds the MMS Proxy setting.
-- =

1.7.1


--===============8718344484857932864==--

