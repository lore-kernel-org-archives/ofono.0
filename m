Content-Type: multipart/mixed; boundary="===============7378381366064186998=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] CDMA ConnMan API: add username and password for PPP
 authentication.
Date: Wed, 20 Jul 2011 10:07:52 +0200
Message-ID: <1311149272-5251-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7378381366064186998==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/cdma-connman-api.txt |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/doc/cdma-connman-api.txt b/doc/cdma-connman-api.txt
index e486c09..48699a3 100644
--- a/doc/cdma-connman-api.txt
+++ b/doc/cdma-connman-api.txt
@@ -35,6 +35,16 @@ Properties	boolean Powered [readwrite]
 			Contains whether the connection is dormant.  Will
 			always be false if the connection is not powered.
 =

+		string Username [readwrite]
+
+			Holds the username to be used for authentication
+			purposes.
+
+		string Password [readwrite]
+
+			Holds the password to be used for authentication
+			purposes.
+
 		dict Settings [readonly, optional]
 =

 			Holds all the IP network settings
-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============7378381366064186998==--

