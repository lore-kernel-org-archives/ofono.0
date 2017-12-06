Content-Type: multipart/mixed; boundary="===============4740872810562041274=="
MIME-Version: 1.0
From: Philippe De Swert <philippedeswert@gmail.com>
Subject: [PATCH 7/7] doc: Document the new DialMemory method of the
 voicecallmanager-api
Date: Wed, 06 Dec 2017 17:36:04 +0200
Message-ID: <20171206153604.15080-8-philippedeswert@gmail.com>
In-Reply-To: <20171206153604.15080-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4740872810562041274==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The new DialMemory method call needs to be documented so it is clear how
to use it.

---
 doc/voicecallmanager-api.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
index f82a0a10..c132eb6c 100644
--- a/doc/voicecallmanager-api.txt
+++ b/doc/voicecallmanager-api.txt
@@ -69,6 +69,17 @@ Methods		dict GetProperties()
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
+
 		void Transfer()
 =

 			Joins the currently Active (or Outgoing, depending
-- =

2.11.0


--===============4740872810562041274==--

