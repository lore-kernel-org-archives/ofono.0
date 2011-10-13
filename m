Content-Type: multipart/mixed; boundary="===============1254980060925844826=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: [PATCH] doc: Clarifications on voice call behavior
Date: Thu, 13 Oct 2011 10:42:33 -0700
Message-ID: <1318527753-18801-1-git-send-email-wagi@monom.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1254980060925844826==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Daniel Wagner <daniel.wagner@bmw-carit.de>

---
 doc/voicecall-api.txt        |    4 ++++
 doc/voicecallmanager-api.txt |    7 ++++++-
 2 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
index 7eb41aa..fb8f099 100644
--- a/doc/voicecall-api.txt
+++ b/doc/voicecall-api.txt
@@ -47,6 +47,10 @@ Methods		dict GetProperties()
 			of a held multiparty call might not be possible on some
 			implementations.
 =

+			NOTE: Releasing active calls does not produce
+			side-effects.  That is the state of held or waiting
+			calls is not affected.
+
 			Possible Errors: [service].Error.InProgress
 					 [service].Error.Failed
 					 [service].Error.NotImplemented
diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
index bd38229..56dba8b 100644
--- a/doc/voicecallmanager-api.txt
+++ b/doc/voicecallmanager-api.txt
@@ -35,6 +35,10 @@ Methods		dict GetProperties()
 =

 			This is usually implemented using the ATD AT command.
 =

+			NOTE: If an active call (single or multiparty) exists,
+			then it is automatically put on hold if the dial
+			procedure is successful.
+
 			Possible Errors: [service].Error.InProgress
 					 [service].Error.InvalidArguments
 					 [service].Error.InvalidFormat
@@ -102,7 +106,8 @@ Methods		dict GetProperties()
 =

 		void HangupAll()
 =

-			Releases all calls.
+			Releases all calls except waiting calls. This includes
+			multiparty calls.
 =

                         Possible Errors: [service].Error.InProgress
 					 [service].Error.NotImplemented
-- =

1.7.4.4


--===============1254980060925844826==--

