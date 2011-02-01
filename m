Content-Type: multipart/mixed; boundary="===============0508241356802489879=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 9/9] stemodem: use ofono_call initializer
Date: Tue, 01 Feb 2011 15:12:50 -0200
Message-ID: <1296580370-2823-9-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296580370-2823-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0508241356802489879==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/stemodem/voicecall.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/stemodem/voicecall.c b/drivers/stemodem/voicecall.c
index 1c7c0bd..fa078a8 100644
--- a/drivers/stemodem/voicecall.c
+++ b/drivers/stemodem/voicecall.c
@@ -108,10 +108,12 @@ static struct ofono_call *create_call(struct ofono_vo=
icecall *vc, int type,
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
 	call->type =3D type;
 	call->direction =3D direction;
 	call->status =3D status;
-- =

1.7.4


--===============0508241356802489879==--

