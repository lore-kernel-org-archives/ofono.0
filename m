Content-Type: multipart/mixed; boundary="===============5523601760883442689=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH 1/2] Voicecall gaps.
Date: Tue, 06 Jul 2010 20:17:51 +0300
Message-ID: <1278436672-14019-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5523601760883442689==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Missing voicecall functionality pieces from tp-ring point-of-view.
---
 TODO |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 470d4a6..fc539a7 100644
--- a/TODO
+++ b/TODO
@@ -265,6 +265,33 @@ Supplementary Services
   Complexity: C8
 =

 =

+Voicecall
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Supplementary service notifications on remote party actions:
+  - call has been put on hold (+CSSU: 2)
+  - call has been retrieved (+CSSU: 3), and
+  - joining call to a multiparty conference (+CSSU: 4)
+
+  Priority: Medium
+  Complexity: C1
+  Owner: Pekka Pessi <pekka.pessi@nokia.com>
+
+- Dial strings. Include CLIR prefixes and 2nd stage dial strings in the
+  DialString call property. Add dialstring accessor method to C API.
+
+  Priority: Medium
+
+- Provide feedback of sent DTMF tones. Emit SendingTones signal if modem c=
an
+  provide approximate starting and stopping times for DTMF tones. Signal
+  argument contains a string of DTMF tones to be sent, or empty string when
+  all tones has been sent.
+
+  Priority: Medium
+  Complexity: C2
+  Owner: Pekka Pessi <pekka.pessi@nokia.com>
+
+
 Miscellaneous
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

1.7.0.4


--===============5523601760883442689==--

