Content-Type: multipart/mixed; boundary="===============0394638649038600025=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH][RfC] doc: Play Tone command proposed d-bus API
Date: Thu, 02 Sep 2010 15:19:57 +0200
Message-ID: <1283433597-26387-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0394638649038600025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

An open question is if it makes more sense to send the tone code as a
byte just as they come from UICC or as string names of the tones
("Ringing tone", "General beep"...).
---
 doc/stk-api.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/doc/stk-api.txt b/doc/stk-api.txt
index d0dd740..2e6ce92 100644
--- a/doc/stk-api.txt
+++ b/doc/stk-api.txt
@@ -200,6 +200,18 @@ Methods		byte RequestSelection(string title, byte icon=
_id,
 =

 			Possible Errors: [service].Error.SimToolkit.EndSession
 =

+		void PlayTone(byte tone, string text, byte icon_id)
+
+			Tells the agent to play an autio tone.  A
+			continuous or repeatable tone is played for the
+			duration of the method call (until it is cancelled),
+			otherwise it is played once and the method should
+			return.  The text parameter contains an optional
+			text to be displayed to the user.  Tone numbers are
+			listed in TS 102.223 Section 8.16.
+
+			Possible Errors: [service].Error.SimToolkit.EndSession
+
 		void Cancel()
 =

 			Asks the agent to cancel any ongoing operation in
-- =

1.7.1.86.g0e460.dirty


--===============0394638649038600025==--

