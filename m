Content-Type: multipart/mixed; boundary="===============5307446858161692513=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v1 1/7] doc: Add EchoCancelingNoiseReduction to Handsfree
Date: Mon, 22 Apr 2013 09:58:37 -0300
Message-ID: <1366635523-8272-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1366392884-7116-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5307446858161692513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

This patch adds echo canceling and noise reduction property to Handsfree
interface, allowing the handsfree unit to enable or disable this feature
in the audio gateway.

According to Bluetooth HFP 1.6 spec: By default, if the AG supports its
own embedded echo canceling and/or noise reduction functions, it shall
have them activated until the AT+NREC command is received.
---
 doc/handsfree-api.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/doc/handsfree-api.txt b/doc/handsfree-api.txt
index 0b5d421..6855d93 100644
--- a/doc/handsfree-api.txt
+++ b/doc/handsfree-api.txt
@@ -56,6 +56,13 @@ Properties	array{string} Features [readonly]
 			to activate or deactivate the function from the HF, or
 			the AG could autonomously initiate it.
 =

+		boolean EchoCancelingNoiseReduction [readwrite]
+
+			Boolean representing whether echo canceling and noise
+			reduction is enabled in the AG. This property may be
+			written to activate or deactivate this feature from
+			the HF unit.
+
 		byte BatteryChargeLevel [readonly]
 =

 			The current charge level of the battery.  The value
-- =

1.7.11.7


--===============5307446858161692513==--

