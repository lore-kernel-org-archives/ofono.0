Content-Type: multipart/mixed; boundary="===============0875905260271763399=="
MIME-Version: 1.0
From: Alexander Kanavin <alex.kanavin@gmail.com>
Subject: [PATCH] doc: fix Forwarded signal name in VoiceCallManager
Date: Fri, 05 Aug 2011 14:53:58 +0300
Message-ID: <1312545238-13546-1-git-send-email-alex.kanavin@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0875905260271763399==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/voicecallmanager-api.txt |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
index 73205f0..bd38229 100644
--- a/doc/voicecallmanager-api.txt
+++ b/doc/voicecallmanager-api.txt
@@ -202,7 +202,7 @@ Signals		CallAdded(object path, dict properties)
 			settings for outgoing calls. In this case the type
 			parameter in the signal is set to "local".
 =

-		CallForwarded(string type) [experimental]
+		Forwarded(string type) [experimental]
 =

 			Signal emitted when an outgoing voice call is made and
 			the call has been redirected to another number due to
-- =

1.7.4.1


--===============0875905260271763399==--

