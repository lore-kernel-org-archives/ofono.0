Content-Type: multipart/mixed; boundary="===============6808850764566307197=="
MIME-Version: 1.0
From: Ronald Tessier <ronald.tessier@linux.intel.com>
Subject: [PATCH] doc: Update service-api doc to match the code
Date: Wed, 09 May 2012 14:52:16 +0200
Message-ID: <1336567936-4624-1-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6808850764566307197==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

GetMessages method has no argument and the implementation does not
return any error.

---
 doc/service-api.txt |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/doc/service-api.txt b/doc/service-api.txt
index 46989f4..d87644b 100644
--- a/doc/service-api.txt
+++ b/doc/service-api.txt
@@ -16,8 +16,6 @@ Methods		array{object,dict} GetMessages()
 			and removal shall be monitored via MessageAdded and
 			MessageRemoved signals.

-			Possible Errors: [service].Error.InvalidArguments
-
 		array{object,dict} GetConversation(string number, uint32 count)

 			Get an array of message objects and properties
--
1.7.4.1


--===============6808850764566307197==--

