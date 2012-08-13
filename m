Content-Type: multipart/mixed; boundary="===============7915871881976306545=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH] doc: Trivial whitespace fixes
Date: Mon, 13 Aug 2012 10:06:26 +0200
Message-ID: <1344845186-16355-1-git-send-email-mikel.astiz.oss@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7915871881976306545==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Always use tabs instead of spaces for indentation in documentation
files.
---
 doc/location-reporting-api.txt |    2 +-
 doc/voicecallmanager-api.txt   |   12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/doc/location-reporting-api.txt b/doc/location-reporting-api.txt
index e6e5d54..21e346d 100644
--- a/doc/location-reporting-api.txt
+++ b/doc/location-reporting-api.txt
@@ -31,7 +31,7 @@ Methods		dict GetProperties()
 =

 Properties	boolean Enabled [readonly]
 =

-                        Boolean representing the state of the NMEA stream.
+			Boolean representing the state of the NMEA stream.
 =

 		string Type [readonly]
 =

diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
index 6af7d33..34a9b25 100644
--- a/doc/voicecallmanager-api.txt
+++ b/doc/voicecallmanager-api.txt
@@ -125,7 +125,7 @@ Methods		dict GetProperties()
 			Held calls is invalid, since in GSM a user can have
 			only a single Held call at a time.
 =

-                        Possible Errors: [service].Error.InProgress
+			Possible Errors: [service].Error.InProgress
 					 [service].Error.NotImplemented
 					 [service].Error.Failed
 =

@@ -134,7 +134,7 @@ Methods		dict GetProperties()
 			Releases all calls except waiting calls. This includes
 			multiparty calls.
 =

-                        Possible Errors: [service].Error.InProgress
+			Possible Errors: [service].Error.InProgress
 					 [service].Error.NotImplemented
 					 [service].Error.Failed
 =

@@ -151,7 +151,7 @@ Methods		dict GetProperties()
 =

 			This is usually implemented using the +CHLD=3D2X command.
 =

-                        Possible Errors: [service].Error.InProgress
+			Possible Errors: [service].Error.InProgress
 					 [service].Error.InvalidArguments
 					 [service].Error.InvalidFormat
 					 [service].Error.NotFound
@@ -172,7 +172,7 @@ Methods		dict GetProperties()
 			This is usually implemented using the +CHLD=3D3 AT
 			command.
 =

-                        Possible Errors: [service].Error.InProgress
+			Possible Errors: [service].Error.InProgress
 					 [service].Error.NotImplemented
 					 [service].Error.Failed
 =

@@ -181,7 +181,7 @@ Methods		dict GetProperties()
 			Hangs up the multi-party call.  All participating
 			calls are released.
 =

-                        Possible Errors: [service].Error.InProgress
+			Possible Errors: [service].Error.InProgress
 					 [service].Error.NotImplemented
 					 [service].Error.Failed
 =

@@ -192,7 +192,7 @@ Methods		dict GetProperties()
 			'*', '#', 'A', 'B', 'C', 'D'.  The last four are
 			typically not used in normal circumstances.
 =

-                        Possible Errors: [service].Error.InProgress
+			Possible Errors: [service].Error.InProgress
 					 [service].Error.NotImplemented
 					 [service].Error.InvalidArguments
 					 [service].Error.InvalidFormat
-- =

1.7.7.6


--===============7915871881976306545==--

