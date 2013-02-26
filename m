Content-Type: multipart/mixed; boundary="===============8618978643079636429=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH] doc: Add possible handsfree-audio API errors
Date: Tue, 26 Feb 2013 12:59:03 -0300
Message-ID: <1361894343-11452-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8618978643079636429==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds possible errors that can be returned by Register and
Unregister methods of the Manager interface.
---
 doc/handsfree-audio-api.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/handsfree-audio-api.txt b/doc/handsfree-audio-api.txt
index 78ba9e1..6c3c8b5 100644
--- a/doc/handsfree-audio-api.txt
+++ b/doc/handsfree-audio-api.txt
@@ -25,11 +25,18 @@ Methods		array{object,dict} GetCards()
 				1	CVSD
 				2	mSBC
 =

+			Possible Errors: [service].Error.InvalidArguments
+					 [service].Error.InUse
+
 		void Unregister(object path)
 =

 			Unregisters a Handsfree Audio agent registered
 			through the Register method.
 =

+			Possible Errors: [service].Error.NotFound
+					 [service].Error.InvalidArguments
+					 [service].Error.NotAllowed
+
 Signals		CardAdded(object path, dict properties)
 =

 			Signal that is sent when a new card is added.  It
-- =

1.7.11.7


--===============8618978643079636429==--

