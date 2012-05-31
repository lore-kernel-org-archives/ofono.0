Content-Type: multipart/mixed; boundary="===============8006673218958313326=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH 3/3] doc: Add new D-Bus methods to service interface
Date: Thu, 31 May 2012 10:52:56 +0200
Message-ID: <1338454376-12806-4-git-send-email-ronald.tessier@linux.intel.com>
In-Reply-To: <1338454376-12806-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8006673218958313326==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/service-api.txt |   20 ++++++++++++++++++++
 1 files changed, 20 insertions(+), 0 deletions(-)

diff --git a/doc/service-api.txt b/doc/service-api.txt
index 36e1161..5c18cad 100644
--- a/doc/service-api.txt
+++ b/doc/service-api.txt
@@ -63,6 +63,26 @@ Methods		array{object,dict} GetMessages()
 				[service].Error.PermanentContentNotAccepted
 				[service].Error.PermanentLackOfPrepaid

+		[TODO] void DeleteMessages(array{object})
+
+			Delete an array of message objects that represents
+			the currently stored messages to delete.
+
+			Possible Errors: [service].Error.InvalidArguments
+
+		[TODO] void DeleteConversation(string number)
+
+			Delete the messages that belongs to the conversation
+			defined by the given number.
+
+			The number parameter contains digits to look for
+			(i.e.: n last digits of the phone number), only messages
+			with a recipient which ends with the given number will
+			be member of the conversation and thus will be deleted.
+
+			Possible Errors: [service].Error.InvalidArguments
+
+
 Signals		MessageAdded(object path, dict properties)

 			Signal that is sent when a new message is added. It
--
1.7.4.1


--===============8006673218958313326==--

