Content-Type: multipart/mixed; boundary="===============4897748347680831195=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v3 02/15] doc: Voice recognition function added in Handsfree
Date: Thu, 20 Oct 2011 18:38:07 +0200
Message-ID: <1319128700-15841-3-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1319128700-15841-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4897748347680831195==
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


--===============4897748347680831195==--

