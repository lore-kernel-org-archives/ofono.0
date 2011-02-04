Content-Type: multipart/mixed; boundary="===============1815001555098138325=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH v2 6/8] doc: add CancelMessage to MessageManager
Date: Fri, 04 Feb 2011 17:40:36 -0200
Message-ID: <1296848438-5584-7-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296848438-5584-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1815001555098138325==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/messagemanager-api.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/doc/messagemanager-api.txt b/doc/messagemanager-api.txt
index 0723e9c..29453c3 100644
--- a/doc/messagemanager-api.txt
+++ b/doc/messagemanager-api.txt
@@ -32,6 +32,18 @@ Methods		dict GetProperties()
 			Possible Errors: [service].Error.InvalidArguments
 					 [service].Error.DoesNotExist
 =

+		void CancelMessage(object path)
+
+			Cancel a message that was previously sent. Only
+			messages that are waiting on queue can be cancelled and
+			it's not possible to cancel messages that already had
+			some parts delivered.
+
+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.InProgress
+					 [service].Error.NotFound
+					 [service].Error.Failed
+
 		object SendMessage(string to, string text)
 =

 			Send the message in text to the number in to.  If the
-- =

1.7.4


--===============1815001555098138325==--

