Content-Type: multipart/mixed; boundary="===============5381333126532304581=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] TODO: long phone numbers
Date: Fri, 08 Oct 2010 13:02:30 +0300
Message-ID: <1286532150-27030-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5381333126532304581==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 TODO |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 5589bb1..a96c187 100644
--- a/TODO
+++ b/TODO
@@ -285,11 +285,18 @@ Voicecall
   Complexity: C1
   Owner: Pekka Pessi <pekka.pessi@nokia.com>
 =

+- Long phone numbers. According to 3GPP TS 24.008, the callee address
+  can be up to 80 digits long.
+
+  Priority: Medium
+  Complexity: C2
+
 - Dial strings. Include CLIR prefixes and 2nd stage dial strings in the
   DialString call property. Add dialstring accessor method to C API.
 =

   Priority: Medium
   Complexity: C4
+  Owner: Pekka Pessi <pekka.pessi@nokia.com>
 =

 - Provide feedback of sent DTMF tones. Emit SendingTones signal if modem c=
an
   provide approximate starting and stopping times for DTMF tones. Signal
-- =

1.7.0.4


--===============5381333126532304581==--

