Content-Type: multipart/mixed; boundary="===============3454065994816025207=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [PATCH 4/4] Add documentation for the Alphabet property
Date: Thu, 02 Sep 2010 10:52:40 +0300
Message-ID: <1283413960-31490-4-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1283413960-31490-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3454065994816025207==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/message-api.txt |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/doc/message-api.txt b/doc/message-api.txt
index 693a111..9e8ea33 100644
--- a/doc/message-api.txt
+++ b/doc/message-api.txt
@@ -64,3 +64,18 @@ Properties	string ServiceCenterAddress
 				"ps-preferred" - Use CS if PS is unavailable
 =

 			By default oFono uses "cs-preferred" setting.
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
+				"reduced" - Non-standard extension that adds
+					translit support to the default alphabet
+
+			The standard, language-specific alphabets are defined in
+			3GPP TS23.038, Annex A.
-- =

1.7.0.4


--===============3454065994816025207==--

