Content-Type: multipart/mixed; boundary="===============7792357411713186321=="
MIME-Version: 1.0
From: Philippe De Swert <philippe.deswert@nomovok.com>
Subject: [PATCH 4/4] doc: Document the new DialLast voicecallmanager API
 addition
Date: Wed, 18 Oct 2017 17:04:27 +0300
Message-ID: <20171018140427.16143-5-philippe.deswert@nomovok.com>
In-Reply-To: <20171018140427.16143-1-philippe.deswert@nomovok.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7792357411713186321==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The new DialLast method to call the last dialled number for HFP needs
to be added to the documentation.
---
 doc/voicecallmanager-api.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
index 34a9b25c..7aeb81f7 100644
--- a/doc/voicecallmanager-api.txt
+++ b/doc/voicecallmanager-api.txt
@@ -59,6 +59,16 @@ Methods		dict GetProperties()
 					 [service].Error.NotImplemented
 					 [service].Error.Failed
 =

+		object DialLast()
+
+			Initiates a new outgoing call to the last dialled number.
+
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.NotImplemented
+					 [service].Error.Failed
+
 		void Transfer()
 =

 			Joins the currently Active (or Outgoing, depending
-- =

2.11.0


--===============7792357411713186321==--

