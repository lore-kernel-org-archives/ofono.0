Content-Type: multipart/mixed; boundary="===============5778417062170945826=="
MIME-Version: 1.0
From: Philippe De Swert <philippe.deswert@nomovok.com>
Subject: [PATCH V2 4/8] doc: Document the new DialLast voicecallmanager API
 addition
Date: Tue, 31 Oct 2017 10:39:35 +0200
Message-ID: <20171031083939.4393-5-philippe.deswert@nomovok.com>
In-Reply-To: <20171031083939.4393-1-philippe.deswert@nomovok.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5778417062170945826==
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

2.14.2


--===============5778417062170945826==--

