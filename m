Content-Type: multipart/mixed; boundary="===============7007640444638259200=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 15/19] doc: Handsfree exposes supported AG features
Date: Wed, 12 Oct 2011 14:35:36 +0200
Message-ID: <1318422940-14955-16-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1318422940-14955-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7007640444638259200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/handsfree-api.txt |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/doc/handsfree-api.txt b/doc/handsfree-api.txt
index 9355946..dafb0ed 100644
--- a/doc/handsfree-api.txt
+++ b/doc/handsfree-api.txt
@@ -38,7 +38,22 @@ Signals		PropertyChanged(string property, variant value)
 			Signal is emitted whenever a property has changed.
 			The new value is passed as the signal argument.
 =

-Properties	boolean InbandRinging [readonly]
+Properties	array{string} Features [readonly]
+
+			List of features supported by the AG. The currently
+			supported values are:
+				"3WayCalling"
+				"ECNR"
+				"VoiceRecognition"
+				"InbandRinging"
+				"AttachVoiceTag"
+				"RejectCall"
+				"EnhancedCallStatus"
+				"EnhancedCallControl"
+				"ExtendedResultCodes"
+				"CodecNegotiation"
+
+		boolean InbandRinging [readonly]
 =

 			Boolean representing whether inband ringing is enabled.
 =

-- =

1.7.6.4


--===============7007640444638259200==--

