Content-Type: multipart/mixed; boundary="===============1888848764309312658=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: [PATCH 4/7] extended support for LTE and NR. Some minor fixes. part 4
 of 7
Date: Wed, 19 Sep 2018 07:37:30 +0200
Message-ID: <1537335453-21498-4-git-send-email-gciofono@gmail.com>
In-Reply-To: <1537335453-21498-1-git-send-email-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1888848764309312658==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/emergency-call-handling.txt |  2 +-
 doc/lte-api.txt                 | 37 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 2 deletions(-)

diff --git a/doc/emergency-call-handling.txt b/doc/emergency-call-handling.=
txt
index 69b217d..0436047 100644
--- a/doc/emergency-call-handling.txt
+++ b/doc/emergency-call-handling.txt
@@ -14,7 +14,7 @@ What oFono will do:
 	- Post online atoms will be created.
 	- Upon reception of Dial request, Emergency mode is activated.
 	- Once the call is ended, Emergency mode is deactivated.
-	- Modem remains in online mode with full funcationality.
+	- Modem remains in online mode with full functionality.
 =

 Case 2: Call in SIM Present and PIN required state
 =

diff --git a/doc/lte-api.txt b/doc/lte-api.txt
index 8a2a97d..22ba7b5 100644
--- a/doc/lte-api.txt
+++ b/doc/lte-api.txt
@@ -25,11 +25,46 @@ Signals		PropertyChanged(string property, variant value)
 			This signal indicates a changed value of the given
 			property.
 =

-Properties	string DefaultAccessPointName [readwrite]
+Properties	string Protocol [readwrite]
+
+			Holds the protocol for this context.  Valid values
+			are: "ip", "ipv6" and "dual".
+
+		string AccessPointName [readwrite]
 =

 			On LongTermEvolution, contexts activate automatically.
 			This property allows selection of an APN to be used on
 			next automatic activation.
+			By setting this property AT+CGDCONT is sent,
+			followed by AT+CGAUTH if needed.
 =

 			Setting this property to an empty string clears the
 			default APN from the modem.
+
+		string AuthenticationMethod [readwrite]
+
+			Sets the Method used for the authentication
+			for the default APN.
+			The authentication information is sent to the module
+			when the AccessPointName property is set
+
+			Available values are "none", "pap" and "chap".
+			Default is "none".
+
+			"pap" and "chap" authentication methods require
+			both Username and Password set to nonempty values
+
+		string Username [readwrite]
+
+			Holds the username to be used for authentication
+			purposes.
+			The authentication information is sent to the module
+			when the AccessPointName property is set
+
+		string Password [readwrite]
+
+			Holds the password to be used for authentication
+			purposes.
+			The authentication information is sent to the module
+			when the AccessPointName property is set
+
-- =

1.9.1


--===============1888848764309312658==--

