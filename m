Content-Type: multipart/mixed; boundary="===============1689083521122425146=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv1 5/5] doc: Update service-api.txt
Date: Wed, 25 Apr 2012 11:01:53 +0200
Message-ID: <1335344513-2347-6-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1335344513-2347-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1689083521122425146==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/service-api.txt |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/doc/service-api.txt b/doc/service-api.txt
index 46989f4..99e80be 100644
--- a/doc/service-api.txt
+++ b/doc/service-api.txt
@@ -24,11 +24,18 @@ Methods		array{object,dict} GetMessages()
 			that are part of a conversation between the service
 			entity and the number provided.

+			The number parameter must only contains	significant digits
+			to look for (i.e.: n last digits of the phone number), only
+			messages with a recipient containing the given number will
+			be part of the GetConversation result.
+
 			The count parameter can either be 0 for unlimited
 			messages in the conversation or limit the conversation
 			to count last messages.

-			Possible Errors: [service].Error.InvalidArguments
+			Possible Errors:
+				[service].Error.InvalidArguments
+				[service].Error.TransientFailure

 		object SendMessage(array{string} recipients, string smil,
 					array{string id, string content-type,
--
1.7.4.1


--===============1689083521122425146==--

