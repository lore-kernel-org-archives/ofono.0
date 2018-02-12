Content-Type: multipart/mixed; boundary="===============0686400918932161530=="
MIME-Version: 1.0
From: philippedeswert@gmail.com
Subject: [PATCH 5/5] doc: Document the new DialMemory method of the
 voicecallmanager-api
Date: Mon, 12 Feb 2018 20:37:18 +0200
Message-ID: <20180212183718.17194-6-philippedeswert@gmail.com>
In-Reply-To: <20180212183718.17194-1-philippedeswert@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0686400918932161530==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Philippe De Swert <philippedeswert@gmail.com>

The new DialMemory method call needs to be documented so it is clear how
to use it.
---
 doc/voicecallmanager-api.txt | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
index 7aeb81f7..5c4ce11b 100644
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


--===============0686400918932161530==--

