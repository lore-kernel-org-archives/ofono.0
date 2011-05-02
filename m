Content-Type: multipart/mixed; boundary="===============8490730399661188931=="
MIME-Version: 1.0
From: =?unknown-8bit?q?Fr=C3=A9d=C3=A9ric?= Dalleau <frederic.dalleau@linux.intel.com>
Subject: [PATCH 1/7] voicecall: Fix variable initialization
Date: Mon, 02 May 2011 17:48:02 +0200
Message-ID: <1304351288-3894-2-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1304351288-3894-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8490730399661188931==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 src/voicecall.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/src/voicecall.c b/src/voicecall.c
index 3e66004..4564a65 100644
--- a/src/voicecall.c
+++ b/src/voicecall.c
@@ -2600,6 +2600,7 @@ static void emulator_generic_cb(const struct ofono_er=
ror *error, void *data)
 	struct ofono_emulator *em =3D data;
 	struct ofono_error result;
 =

+	result.error =3D error->error;
 	result.type =3D error->type;
 =

 	ofono_emulator_send_final(em, &result);
-- =

1.7.1


--===============8490730399661188931==--

