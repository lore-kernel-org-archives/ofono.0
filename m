Content-Type: multipart/mixed; boundary="===============4626663024738193664=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 7/9] ifxmodem: use ofono_call initializer
Date: Tue, 01 Feb 2011 15:12:48 -0200
Message-ID: <1296580370-2823-7-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296580370-2823-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4626663024738193664==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/ifxmodem/voicecall.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/ifxmodem/voicecall.c b/drivers/ifxmodem/voicecall.c
index 716652c..e7f72fc 100644
--- a/drivers/ifxmodem/voicecall.c
+++ b/drivers/ifxmodem/voicecall.c
@@ -87,10 +87,12 @@ static struct ofono_call *create_call(struct ofono_voic=
ecall *vc, int type,
 	struct ofono_call *call;
 =

 	/* Generate a call structure for the waiting call */
-	call =3D g_try_new0(struct ofono_call, 1);
+	call =3D g_try_new(struct ofono_call, 1);
 	if (call =3D=3D NULL)
 		return NULL;
 =

+	ofono_call_init(call);
+
 	call->id =3D ofono_voicecall_get_next_callid(vc);
 	call->type =3D type;
 	call->direction =3D direction;
-- =

1.7.4


--===============4626663024738193664==--

