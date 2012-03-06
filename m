Content-Type: multipart/mixed; boundary="===============1706731283687581136=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: [PATCH] voicecall: Don't set indicators during transitions
Date: Tue, 06 Mar 2012 09:26:59 -0600
Message-ID: <1331047619-8675-1-git-send-email-denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1706731283687581136==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index e224d3a..c128227 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -825,6 +825,19 @@ static void notify_emulator_call_status(struct ofono_v=
oicecall *vc)
 		}
 	}
 =

+	/*
+	 * Perform some basic sanity checks for transitionary states;
+	 * if a transitionary state is detected, then ignore it.  The call
+	 * indicators will be updated properly in the follow-on calls to
+	 * this function once the final state has been reached
+	 */
+
+	if (incoming && (held || call))
+		return;
+
+	if (waiting && (held =3D=3D FALSE && call =3D=3D FALSE))
+		return;
+
 	data.status =3D call || held ? OFONO_EMULATOR_CALL_ACTIVE :
 					OFONO_EMULATOR_CALL_INACTIVE;
 =

-- =

1.7.3.4


--===============1706731283687581136==--

