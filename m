Content-Type: multipart/mixed; boundary="===============3021447676196654592=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] [RfC] doc: Proposed Set Up Call api.
Date: Wed, 18 Aug 2010 05:01:07 +0200
Message-ID: <1282100467-890-1-git-send-email-andrew.zaborowski@intel.com>
In-Reply-To: <4C6B705B.1070400@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3021447676196654592==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The normal sequence for call setup is:

* Modem asks user for confirmation using icon1 / alphaId1.
* User confirms
* Modem starts dialling, screen displays icon2 / alphaId2,
* Call is connected, modem replies to the proactive command, screen
  keeps displaying icon2 / alphaId2 until the phone call is over.
---
 doc/stk-api.txt       |   11 +++++++++++
 doc/voicecall-api.txt |   11 +++++++++++
 2 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/doc/stk-api.txt b/doc/stk-api.txt
index 2e863a9..dcb8e2b 100644
--- a/doc/stk-api.txt
+++ b/doc/stk-api.txt
@@ -189,6 +189,17 @@ Methods		byte RequestSelection(string title, byte icon=
_id,
 =

 			Possible Errors: [service].Error.SimToolkit.GoBack
 =

+		boolean ConfirmCallSetup(string information, byte icon_id)
+
+			Asks the agent to request user to confirm an
+			outgoing call setup.  If confirmed, the next new
+			outgoing call reported by VoiceCallManager will
+			have the Information and Icon properties set to
+			inform the user.  Hanging up before the call is
+			connected will cause EndSession reply to be sent.
+
+			Possible Errors: [service].Error.SimToolkit.EndSession
+
 		void Cancel()
 =

 			Asks the agent to cancel any ongoing operation in
diff --git a/doc/voicecall-api.txt b/doc/voicecall-api.txt
index 59e3568..f0ba316 100644
--- a/doc/voicecall-api.txt
+++ b/doc/voicecall-api.txt
@@ -114,3 +114,14 @@ Properties	string LineIdentification [readonly]
 			stamped when the call enters the "active" state.
 			Client applications can use this to infer somewhat
 			reliable call duration information.
+
+		string Information [readonly, optional]
+
+			Contains information related to the call for the
+			user.  Currently this property is set for calls
+			initiated by SIM Toolkit applications.
+
+		byte Icon [readonly, optional]
+
+			Icon identifier to be used instead of or together
+			with the text information.
-- =

1.7.1.86.g0e460.dirty


--===============3021447676196654592==--

