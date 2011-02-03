Content-Type: multipart/mixed; boundary="===============8275031896869289445=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 6/6] doc: Add documentation for Alphabet property
Date: Thu, 03 Feb 2011 15:20:36 +0200
Message-ID: <1296739236-24391-7-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1296739236-24391-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8275031896869289445==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/message-api.txt |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/doc/message-api.txt b/doc/message-api.txt
index 1c68aee..d5a7b15 100644
--- a/doc/message-api.txt
+++ b/doc/message-api.txt
@@ -24,3 +24,17 @@ Properties	string State
 				"pending",
 				"sent",
 				"failed"
+
+		string Alphabet
+
+			Contains the alphabet setting for outgoing SMSs.
+			Possible values are:
+
+				"default" - Default GSM alphabet
+				"turkish" - Turkish alphabet
+				"spanish" - Spanish alphabet
+				"portuguese" - Portuguese alphabet
+
+			The standard, language-specific alphabets are defined in
+			3GPP TS23.038, Annex A.  By default, oFono uses "default"
+			setting.
-- =

1.7.1


--===============8275031896869289445==--

