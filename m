Content-Type: multipart/mixed; boundary="===============3930248006198287980=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCHv2 4/4] doc: Update service-api.txt
Date: Thu, 03 May 2012 15:20:03 +0200
Message-ID: <1336051203-15512-5-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1336051203-15512-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3930248006198287980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/service-api.txt |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/doc/service-api.txt b/doc/service-api.txt
index 46989f4..36e1161 100644
--- a/doc/service-api.txt
+++ b/doc/service-api.txt
@@ -24,11 +24,17 @@ Methods		array{object,dict} GetMessages()
 			that are part of a conversation between the service
 			entity and the number provided.

+			The number parameter contains digits to look for
+			(i.e.: n last digits of the phone number), only messages
+			with a recipient which ends with the given number will
+			be part of the GetConversation result.
+
 			The count parameter can either be 0 for unlimited
 			messages in the conversation or limit the conversation
 			to count last messages.

 			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.TransientFailure

 		object SendMessage(array{string} recipients, string smil,
 					array{string id, string content-type,
--
1.7.4.1


--===============3930248006198287980==--

