Content-Type: multipart/mixed; boundary="===============7578870274340231957=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH v8 1/5] lte-api: protocol and authentication properties
Date: Fri, 19 Oct 2018 13:31:37 +0200
Message-ID: <20181019113141.20734-2-gciofono@gmail.com>
In-Reply-To: <20181019113141.20734-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7578870274340231957==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

added 4 properties for handling the type of context and the
authentication method, exactly like in any gprs context handling.
The properties are named after the equivalent gprs-context one, for
compatibility and uniformity.

Co-authored-by: Martin Baschin <martin.baschin@googlemail.com>
---
 doc/lte-api.txt | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/doc/lte-api.txt b/doc/lte-api.txt
index 8a2a97d9..c9544f60 100644
--- a/doc/lte-api.txt
+++ b/doc/lte-api.txt
@@ -33,3 +33,42 @@ Properties	string DefaultAccessPointName [readwrite]
 =

 			Setting this property to an empty string clears the
 			default APN from the modem.
+
+		string Protocol [readwrite]
+
+			Holds the protocol for this context.  Valid values
+			are: "ip", "ipv6" and "dual". Default value is "ip".
+
+		string AuthenticationMethod [readwrite]
+
+			Sets the Method used for the authentication
+			for the default APN.
+
+			Available values are "none", "pap" and "chap".
+			Default is "none".
+
+			If the AuthenticationMethod is set to 'none' it remove
+			the authentication for the DefaultAPN.
+			In case of AuthenticationMethod 'none',
+			if the Username and Password properties are not empty,
+			the values are preserved in the properties, but they
+			are not used or transmitted to the module.
+			Conversely, if Username or Password are empty, the
+			authentication method selected internally is 'none',
+			but the property AuthenticationMethod is left unchanged.
+
+			If the default APN supports authentication and it
+			fails, then it is up to the network how to proceed.
+			In general LTE access is denied and the modem can
+			fallback to a legacy technology if capable and another
+			radio technology is available.
+
+		string Username [readwrite]
+
+			Holds the username to be used for authentication
+			purposes.
+
+		string Password [readwrite]
+
+			Holds the password to be used for authentication
+			purposes.
-- =

2.17.1


--===============7578870274340231957==--

