Content-Type: multipart/mixed; boundary="===============5531298304427184677=="
MIME-Version: 1.0
From: Nandini Rebello <nandini.rebello@intel.com>
Subject: [PATCH] doc: add support for 8 additional sms alphabets
Date: Fri, 12 Oct 2018 13:40:55 +0530
Message-ID: <1539331855-3439-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5531298304427184677==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Adding support for hindi,kannada,malayalam,oriya,punjabi,tamil,
telugu and urdu for GSM 7 bit.
---
 doc/messagemanager-api.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/messagemanager-api.txt b/doc/messagemanager-api.txt
index 8d85a1b..6f3a21c 100644
--- a/doc/messagemanager-api.txt
+++ b/doc/messagemanager-api.txt
@@ -106,6 +106,14 @@ Properties	string ServiceCenterAddress
 				"portuguese" - Portuguese alphabet
 				"bengali" - Bengali alphabet
 				"gujarati" - Gujarati alphabet
+				"hindi" - Hindi alphabet
+				"kannada" - Kannada alphabet
+				"malayalam" - Malayalam alphabet
+				"oriya" - Oriya alphabet
+				"punjabi"- Punjabi alphabet
+				"tamil" - Tamil alphabet
+				"telugu" - Telugu alphabet
+				"urdu" - Urdu alphabet
 =

 			The standard, language-specific alphabets are defined
 			in 3GPP TS23.038, Annex A.  By default, oFono uses
-- =

2.7.4


--===============5531298304427184677==--

