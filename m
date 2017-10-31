Content-Type: multipart/mixed; boundary="===============8552962981816238896=="
MIME-Version: 1.0
From: Philippe De Swert <philippe.deswert@nomovok.com>
Subject: [PATCH 8/8] doc: Document the new memory dialing method call
Date: Tue, 31 Oct 2017 10:39:39 +0200
Message-ID: <20171031083939.4393-9-philippe.deswert@nomovok.com>
In-Reply-To: <20171031083939.4393-1-philippe.deswert@nomovok.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8552962981816238896==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The new DialMemory method call needs to be documented so it is clear how
to use it.
---
 doc/voicecallmanager-api.txt | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
index 7aeb81f7..fabed619 100644
--- a/doc/voicecallmanager-api.txt
+++ b/doc/voicecallmanager-api.txt
@@ -59,6 +59,16 @@ Methods		dict GetProperties()
 					 [service].Error.NotImplemented
 					 [service].Error.Failed
 =

+		object DialMemory(string memory position, string hide_callerid)
+
+			Initiates a new outgoing call to the number in the given memory
+			position/favourite. For callerid see the Dial method.
+
+			Possible Errors: [service].Error.InProgress
+					 [service].Error.InvalidArguments
+					 [service].Error.InvalidFormat
+					 [service].Error.NotImplemented
+					 [service].Error.Failed
 		object DialLast()
 =

 			Initiates a new outgoing call to the last dialled number.
-- =

2.14.2


--===============8552962981816238896==--

