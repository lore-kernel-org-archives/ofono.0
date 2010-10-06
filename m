Content-Type: multipart/mixed; boundary="===============8170338127249887708=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] doc: Play Tone command proposed d-bus API.
Date: Wed, 06 Oct 2010 12:35:00 +0200
Message-ID: <1286361303-8712-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8170338127249887708==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/stk-api.txt |   40 ++++++++++++++++++++++++++++++++++++++++
 1 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/doc/stk-api.txt b/doc/stk-api.txt
index 3b47819..f5b9ebc 100644
--- a/doc/stk-api.txt
+++ b/doc/stk-api.txt
@@ -203,6 +203,46 @@ Methods		byte RequestSelection(string title, byte icon=
_id,
 =

 			Possible Errors: [service].Error.SimToolkit.EndSession
 =

+		void PlayTone(string tone, string text, byte icon_id)
+
+			Tells the agent to play an audio tone once.  The
+			method should return once the tone is finished
+			playing.  The text parameter contains an optional
+			text to be displayed to the user.  The following
+			tones are defined:
+				"dial-tone"
+				"busy"
+				"congestion"
+				"radio-path-acknowledge"
+				"radio-path-not-available"
+				"error"
+				"call-waiting"
+				"ringing-tone"
+				"general-beep"
+				"positive-acknowledgement"
+				"negative-acknowledgement"
+				"user-ringing-tone"
+				"user-sms-alert"
+				"critical" (high priority)
+				"vibrate"
+				"happy"
+				"sad"
+				"urgent-action"
+				"question"
+				"message-received"
+
+			Possible Errors: [service].Error.SimToolkit.EndSession
+
+		void LoopTone(string tone, string text, byte icon_id)
+
+			Tells the agent to reproduce an audio tone in a
+			loop until the method call is cancelled.  See
+			PlayTone() above for the list of possible tone names.
+			The text parameter contains an optional text to
+			be displayed to the user.
+
+			Possible Errors: [service].Error.SimToolkit.EndSession
+
 		void Cancel()
 =

 			Asks the agent to cancel any ongoing operation in
-- =

1.7.1.86.g0e460.dirty


--===============8170338127249887708==--

