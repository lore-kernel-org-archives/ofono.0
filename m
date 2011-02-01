Content-Type: multipart/mixed; boundary="===============7656942581839374747=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 5/9] hfpmodem: use ofono_call initializer
Date: Tue, 01 Feb 2011 15:12:46 -0200
Message-ID: <1296580370-2823-5-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296580370-2823-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7656942581839374747==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/hfpmodem/voicecall.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index b9bee62..a87ddbe 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -96,10 +96,12 @@ static struct ofono_call *create_call(struct ofono_voic=
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


--===============7656942581839374747==--

