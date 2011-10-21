Content-Type: multipart/mixed; boundary="===============8338479065581422429=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v4 04/12] doc: Handsfree exposes supported AG features
Date: Fri, 21 Oct 2011 18:51:29 +0200
Message-ID: <1319215897-6310-5-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1319215897-6310-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8338479065581422429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/handsfree-api.txt |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/doc/handsfree-api.txt b/doc/handsfree-api.txt
index 9355946..7f9deec 100644
--- a/doc/handsfree-api.txt
+++ b/doc/handsfree-api.txt
@@ -38,7 +38,14 @@ Signals		PropertyChanged(string property, variant value)
 			Signal is emitted whenever a property has changed.
 			The new value is passed as the signal argument.
 =

-Properties	boolean InbandRinging [readonly]
+Properties	array{string} Features [readonly]
+
+			List of features supported by the AG. The currently
+			supported values are:
+				"voice-recognition"
+				"attach-voice-tag"
+
+		boolean InbandRinging [readonly]
 =

 			Boolean representing whether inband ringing is enabled.
 =

-- =

1.7.6.4


--===============8338479065581422429==--

