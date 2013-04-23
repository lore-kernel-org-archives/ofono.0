Content-Type: multipart/mixed; boundary="===============4642763296751955848=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v3 1/7] doc: Add EchoCancelingNoiseReduction to Handsfree
Date: Tue, 23 Apr 2013 14:21:37 -0300
Message-ID: <1366737703-26883-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1366721085-17837-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4642763296751955848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds echo canceling and noise reduction property to Handsfree
interface, allowing the handsfree unit to disable this feature in the
audio gateway. The HFP spec defines the procedure to turn off echo
canceling and noise reduction only, it is not allowed to enable this
feature from the HF unit.

According to Bluetooth HFP 1.6 spec: By default, if the AG supports its
own embedded echo canceling and/or noise reduction functions, it shall
have them activated until the AT+NREC command is received from the HF
unit. From then on, and until the current Service Level Connection is
dropped for any reason, the AG shall disable these functions every time
an Audio Connection is established.
---
 doc/handsfree-api.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/handsfree-api.txt b/doc/handsfree-api.txt
index 0b5d421..66c93e5 100644
--- a/doc/handsfree-api.txt
+++ b/doc/handsfree-api.txt
@@ -44,6 +44,7 @@ Properties	array{string} Features [readonly]
 			supported values are:
 				"voice-recognition"
 				"attach-voice-tag"
+				"echo-canceling-and-noise-reduction"
 =

 		boolean InbandRinging [readonly]
 =

@@ -56,6 +57,13 @@ Properties	array{string} Features [readonly]
 			to activate or deactivate the function from the HF, or
 			the AG could autonomously initiate it.
 =

+		boolean EchoCancelingNoiseReduction [readwrite]
+
+			Non-persistent Boolean property representing whether
+			echo canceling and noise reduction is enabled in the
+			AG. This feature can only be disabled once from the
+			HF unit, and it is not allowed to activate it.
+
 		byte BatteryChargeLevel [readonly]
 =

 			The current charge level of the battery.  The value
-- =

1.7.11.7


--===============4642763296751955848==--

