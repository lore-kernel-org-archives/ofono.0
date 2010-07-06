Content-Type: multipart/mixed; boundary="===============2466654475357918268=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH 2/2] Clarified VoiceCallManager.SendTones documentation.
Date: Tue, 06 Jul 2010 20:17:52 +0300
Message-ID: <1278436672-14019-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1278436672-14019-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2466654475357918268==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 doc/voicecallmanager-api.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/voicecallmanager-api.txt b/doc/voicecallmanager-api.txt
index 7877ac5..bc79fc3 100644
--- a/doc/voicecallmanager-api.txt
+++ b/doc/voicecallmanager-api.txt
@@ -108,10 +108,10 @@ Methods		dict GetProperties()
 =

 		void SendTones(string tones)
 =

-			Sends the DTMF tones to the network.  Under GSM the
-			tones have a fixed duration.  Tones can be one of:
-			'0' - '9', '*', '#', 'A', 'B', 'C', 'D'. The last four
-			are typically not used in normal circumstances.
+			Sends the DTMF tones to the network.  The tones have
+			a fixed duration.  Tones can be one of: '0' - '9',
+			'*', '#', 'A', 'B', 'C', 'D'.  The last four are
+			typically not used in normal circumstances.
 =

 Signals		PropertyChanged(string property, variant value)
 =

-- =

1.7.0.4


--===============2466654475357918268==--

