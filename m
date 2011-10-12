Content-Type: multipart/mixed; boundary="===============0249346418731636663=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v2 07/19] doc: Handsfree API support for +BINP=1
Date: Wed, 12 Oct 2011 14:35:28 +0200
Message-ID: <1318422940-14955-8-git-send-email-mikel.astiz@bmw-carit.de>
In-Reply-To: <1318422940-14955-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0249346418731636663==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/handsfree-api.txt |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/doc/handsfree-api.txt b/doc/handsfree-api.txt
index 4b2b156..023233c 100644
--- a/doc/handsfree-api.txt
+++ b/doc/handsfree-api.txt
@@ -20,6 +20,19 @@ Methods		dict GetProperties()
 			Possible Errors: [service].Error.InProgress
 					 [service].Error.InvalidArguments
 =

+		string RequestPhoneNumber()
+
+			Request a phone number from the AG, corresponding to the
+			last voice tag recorded in the HF. The AG may accept or
+			reject this request depending on its internal state.
+
+			This functionality is generally implemented by using
+			the +BINP=3D1 AT command.
+
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.Failed
+
 Signals		PropertyChanged(string property, variant value)
 =

 			Signal is emitted whenever a property has changed.
-- =

1.7.6.4


--===============0249346418731636663==--

