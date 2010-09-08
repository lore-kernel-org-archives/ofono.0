Content-Type: multipart/mixed; boundary="===============5945270393361889458=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] doc: Play Tone command proposed d-bus API.
Date: Wed, 08 Sep 2010 19:59:53 +0200
Message-ID: <1283968796-5308-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5945270393361889458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This is a version with the tone identified by a string based on irc
discussion, I leave the decision to you about which version to use.
---
 doc/stk-api.txt |   32 ++++++++++++++++++++++++++++++++
 1 files changed, 32 insertions(+), 0 deletions(-)

diff --git a/doc/stk-api.txt b/doc/stk-api.txt
index d0dd740..14819a7 100644
--- a/doc/stk-api.txt
+++ b/doc/stk-api.txt
@@ -200,6 +200,38 @@ Methods		byte RequestSelection(string title, byte icon=
_id,
 =

 			Possible Errors: [service].Error.SimToolkit.EndSession
 =

+		void PlayTone(string tone, boolean loop,
+				string text, byte icon_id)
+
+			Tells the agent to play an audio tone.  A repeatable
+			tone is played for the duration of the method call
+			(until it is cancelled), otherwise it is played once
+			and the method should return.  The text parameter
+			contains an optional text to be displayed to the
+			user.  The following tones are defined:
+				"dial tone"
+				"busy"
+				"congestion"
+				"radio path acknowledge"
+				"radio path not available"
+				"error"
+				"call waiting"
+				"ringing tone"
+				"general beep"
+				"positive acknowledgement"
+				"negative acknowledgement"
+				"user ringing tone"
+				"user sms alert"
+				"critical" (high priority)
+				"vibrate"
+				"happy"
+				"sad"
+				"urgent action"
+				"question"
+				"message received"
+
+			Possible Errors: [service].Error.SimToolkit.EndSession
+
 		void Cancel()
 =

 			Asks the agent to cancel any ongoing operation in
-- =

1.7.1.86.g0e460.dirty


--===============5945270393361889458==--

