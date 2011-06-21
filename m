Content-Type: multipart/mixed; boundary="===============2466336014571681877=="
MIME-Version: 1.0
From: Caiwen Zhang <caiwen.zhang@windriver.com>
Subject: [PATCH] doc: Add dial-number/username/password Property
Date: Tue, 21 Jun 2011 17:53:07 +0800
Message-ID: <1308649987-2438-1-git-send-email-caiwen.zhang@windriver.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2466336014571681877==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Some network's dial-number isn't #777 and user name and password
are required when setup data connection. =


---
 doc/cdma-connman-api.txt |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/doc/cdma-connman-api.txt b/doc/cdma-connman-api.txt
index e486c09..f76a2c5 100644
--- a/doc/cdma-connman-api.txt
+++ b/doc/cdma-connman-api.txt
@@ -35,6 +35,20 @@ Properties	boolean Powered [readwrite]
 			Contains whether the connection is dormant.  Will
 			always be false if the connection is not powered.
 =

+		string DialNumber [readwrite]
+
+			Holds the dialed number.
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
+
 		dict Settings [readonly, optional]
 =

 			Holds all the IP network settings
-- =

1.7.5


--===============2466336014571681877==--

