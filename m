Content-Type: multipart/mixed; boundary="===============8620181714127858678=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v2 1/7] doc: Add EchoCancelingNoiseReduction to Handsfree
Date: Tue, 23 Apr 2013 09:44:39 -0300
Message-ID: <1366721085-17837-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1366635523-8272-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8620181714127858678==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds echo canceling and noise reduction property to Handsfree
interface, allowing the handsfree unit to disable this feature in the
audio gateway. The HFP spec defines the procedure to turn off echo
canceling and noise reduction only. There are some modems that also
allow to turn on this feature from the HF unit, but it is not a
standard procedure.

According to Bluetooth HFP 1.6 spec: By default, if the AG supports its
own embedded echo canceling and/or noise reduction functions, it shall
have them activated until the AT+NREC command is received.
---
 doc/handsfree-api.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/handsfree-api.txt b/doc/handsfree-api.txt
index 0b5d421..527a865 100644
--- a/doc/handsfree-api.txt
+++ b/doc/handsfree-api.txt
@@ -56,6 +56,12 @@ Properties	array{string} Features [readonly]
 			to activate or deactivate the function from the HF, or
 			the AG could autonomously initiate it.
 =

+		boolean EchoCancelingNoiseReduction [readwrite]
+
+			Boolean representing whether echo canceling and noise
+			reduction is enabled in the AG. This property may be
+			written to deactivate this feature from the HF unit.
+
 		byte BatteryChargeLevel [readonly]
 =

 			The current charge level of the battery.  The value
-- =

1.7.11.7


--===============8620181714127858678==--

