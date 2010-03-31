Content-Type: multipart/mixed; boundary="===============4426594075589347468=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: doc: Explain VoicemailMessageCount value zero.
Date: Wed, 31 Mar 2010 06:57:21 +0200
Message-ID: <1270011441-6773-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4426594075589347468==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/message-waiting-api.txt |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/doc/message-waiting-api.txt b/doc/message-waiting-api.txt
index 77ec27a..6c4b354 100644
--- a/doc/message-waiting-api.txt
+++ b/doc/message-waiting-api.txt
@@ -35,7 +35,10 @@ Properties	boolean VoicemailWaiting [readonly]
 		byte VoicemailMessageCount [readonly]
 =

 			The total number of voicemail messages waiting.
-			Values of 255 indicate 255 messages or more.
+			Values of 255 indicate 255 messages or more.  Value
+			0 when VoicemailWaiting is true indicates that the
+			mailbox is not empty and the message count is not
+			known.
 =

 		string VoicemailMailboxNumber [readwrite]
 =

-- =

1.6.1


--===============4426594075589347468==--

