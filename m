Content-Type: multipart/mixed; boundary="===============6190166985707847875=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: [PATCH] [RfC] stk-api: Proposed Set Up Call api.
Date: Tue, 17 Aug 2010 05:02:15 +0200
Message-ID: <1282014135-12297-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6190166985707847875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 doc/stk-api.txt |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/doc/stk-api.txt b/doc/stk-api.txt
index 2e863a9..b85c7db 100644
--- a/doc/stk-api.txt
+++ b/doc/stk-api.txt
@@ -55,6 +55,14 @@ Signals		PropertyChanged(string property, variant value)
 			Signal is emitted whenever a property has changed.
 			The new value is passed as the signal argument.
 =

+		CallSetUp(string message, byte icon_id, object call)
+
+			Informs about a new VoiceCall that is being set
+			up as a result of a UICC request and gives the
+			message associated with the call to be shown to
+			the user.  Hanging-up the call before it is
+			connected will terminate the current session.
+
 Properties	string IdleText
 =

 			Contains the text to be used when the home screen is
@@ -189,6 +197,13 @@ Methods		byte RequestSelection(string title, byte icon=
_id,
 =

 			Possible Errors: [service].Error.SimToolkit.GoBack
 =

+		boolean ConfirmCallSetup(string message, byte icon_id)
+
+			Asks the agent to request user to confirm an
+			outgoing call setup.
+
+			Possible Errors: [service].Error.SimToolkit.EndSession
+
 		void Cancel()
 =

 			Asks the agent to cancel any ongoing operation in
-- =

1.7.1.86.g0e460.dirty


--===============6190166985707847875==--

