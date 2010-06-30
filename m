Content-Type: multipart/mixed; boundary="===============2311978229321628415=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [PATCH] Voicecall gaps.
Date: Wed, 30 Jun 2010 16:01:01 +0300
Message-ID: <1277902861-6494-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2311978229321628415==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

Missing voicecall functionality pieces from tp-ring point-of-view.
---
 TODO |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/TODO b/TODO
index 470d4a6..e6ef20d 100644
--- a/TODO
+++ b/TODO
@@ -265,6 +265,33 @@ Supplementary Services
   Complexity: C8
 =

 =

+Voicecall
+=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+- Supplementary service notifications for remote party putting call on hold
+  or retrieving the call or joining call to a multiparty conference.
+
+  Priority: Medium
+  Complexity: C1
+  Owner: Pekka Pessi <pekka.pessi@nokia.com>
+
+- Dial strings. Include CLIR prefixes and 2nd stage dial strings in call h=
istory.
+
+  Priority: Medium
+  Complexity: C2
+
+- Start DTMF, Stop DTMF, feedback of sent DTMF tones.
+
+  Priority: Medium
+  Complexity: C2
+
+- Add atom for assisting in local supervisory tone generation when modem
+  does include tones in media streams.
+
+  Priority: Medium
+  Complexity: C2
+
+
 Miscellaneous
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =

-- =

1.7.0.4


--===============2311978229321628415==--

