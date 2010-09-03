Content-Type: multipart/mixed; boundary="===============3268191583974643569=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: [alphabets-PATCHv2 5/5] Add documentation for the Alphabet property
Date: Fri, 03 Sep 2010 16:23:00 +0300
Message-ID: <1283520180-20700-5-git-send-email-aki.niemi@nokia.com>
In-Reply-To: <1283520180-20700-1-git-send-email-aki.niemi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3268191583974643569==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/message-api.txt |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/doc/message-api.txt b/doc/message-api.txt
index 693a111..bd8e960 100644
--- a/doc/message-api.txt
+++ b/doc/message-api.txt
@@ -64,3 +64,19 @@ Properties	string ServiceCenterAddress
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
+			3GPP TS23.038, Annex A.  By default, oFono uses "default"
+			setting.
-- =

1.7.0.4


--===============3268191583974643569==--

