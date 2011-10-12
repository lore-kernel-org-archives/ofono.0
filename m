Content-Type: multipart/mixed; boundary="===============8282587249305810294=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 11/19] doc: Voice recognition function added in Handsfree
Date: Wed, 12 Oct 2011 14:35:32 +0200
Message-ID: <1318422940-14955-12-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1318422940-14955-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8282587249305810294==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/handsfree-api.txt |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/doc/handsfree-api.txt b/doc/handsfree-api.txt
index 023233c..9355946 100644
--- a/doc/handsfree-api.txt
+++ b/doc/handsfree-api.txt
@@ -41,3 +41,10 @@ Signals		PropertyChanged(string property, variant value)
 Properties	boolean InbandRinging [readonly]
 =

 			Boolean representing whether inband ringing is enabled.
+
+		boolean VoiceRecognition [readwrite]
+
+			Boolean representing whether voice recognition is
+			currently active in the AG. This property may be written
+			to activate or deactivate the function from the HF, or
+			the AG could autonomously initiate it.
-- =

1.7.6.4


--===============8282587249305810294==--

