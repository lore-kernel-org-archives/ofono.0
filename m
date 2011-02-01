Content-Type: multipart/mixed; boundary="===============4938945178282560541=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 6/9] huaweimodem: use ofono_call initializer
Date: Tue, 01 Feb 2011 15:12:47 -0200
Message-ID: <1296580370-2823-6-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296580370-2823-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4938945178282560541==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/huaweimodem/voicecall.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/huaweimodem/voicecall.c b/drivers/huaweimodem/voicecal=
l.c
index a30513a..53377d9 100644
--- a/drivers/huaweimodem/voicecall.c
+++ b/drivers/huaweimodem/voicecall.c
@@ -56,10 +56,12 @@ static struct ofono_call *create_call(struct ofono_voic=
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
 	call->id =3D id;
 	call->type =3D type;
 	call->direction =3D direction;
-- =

1.7.4


--===============4938945178282560541==--

