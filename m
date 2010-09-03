Content-Type: multipart/mixed; boundary="===============5072275305851337480=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: [PATCH][RfC] doc: Play Tone command proposed d-bus API
Date: Thu, 02 Sep 2010 18:27:23 -0700
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC70296A41D@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <1283433597-26387-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5072275305851337480==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

As the client app anyways has to map to play the tone, its better to
pass is as tone numbers rather than a string so that it makes the
mapping straight forward.

BR,
Rajesh Kadhiravan Nagaiah
Senior Specialist, Elektrobit Inc.  =


-----Original Message-----
From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behalf
Of Andrzej Zaborowski
Sent: 02 September 2010 06:20
To: ofono(a)ofono.org
Subject: [PATCH][RfC] doc: Play Tone command proposed d-bus API

An open question is if it makes more sense to send the tone code as a
byte just as they come from UICC or as string names of the tones
("Ringing tone", "General beep"...).
---
 doc/stk-api.txt |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/doc/stk-api.txt b/doc/stk-api.txt index d0dd740..2e6ce92
100644
--- a/doc/stk-api.txt
+++ b/doc/stk-api.txt
@@ -200,6 +200,18 @@ Methods		byte RequestSelection(string
title, byte icon_id,
 =

 			Possible Errors:
[service].Error.SimToolkit.EndSession
 =

+		void PlayTone(byte tone, string text, byte icon_id)
+
+			Tells the agent to play an autio tone.  A
+			continuous or repeatable tone is played for the
+			duration of the method call (until it is
cancelled),
+			otherwise it is played once and the method
should
+			return.  The text parameter contains an optional
+			text to be displayed to the user.  Tone numbers
are
+			listed in TS 102.223 Section 8.16.
+
+			Possible Errors:
[service].Error.SimToolkit.EndSession
+
 		void Cancel()
 =

 			Asks the agent to cancel any ongoing operation
in
--
1.7.1.86.g0e460.dirty

_______________________________________________
ofono mailing list
ofono(a)ofono.org
http://lists.ofono.org/listinfo/ofono


----------------------------------------------------------------
Please note: This e-mail may contain confidential information
intended solely for the addressee. If you have received this
e-mail in error, please do not disclose it to anyone, notify
the sender promptly, and delete the message from your system.
Thank you.


--===============5072275305851337480==--

