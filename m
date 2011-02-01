Content-Type: multipart/mixed; boundary="===============6224614627602307073=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 8/9] isimodem: use ofono_call initializer
Date: Tue, 01 Feb 2011 15:12:49 -0200
Message-ID: <1296580370-2823-8-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296580370-2823-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6224614627602307073==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/isimodem/voicecall.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/isimodem/voicecall.c b/drivers/isimodem/voicecall.c
index 6a1e582..12896f2 100644
--- a/drivers/isimodem/voicecall.c
+++ b/drivers/isimodem/voicecall.c
@@ -384,11 +384,11 @@ static int isi_call_status_to_clcc(const struct isi_c=
all *call)
 =

 static struct ofono_call isi_call_as_ofono_call(const struct isi_call *cal=
l)
 {
-	struct ofono_call ocall =3D {
-		call->id
-	};
+	struct ofono_call ocall;
 	struct ofono_phone_number *number =3D &ocall.phone_number;
 =

+	ofono_call_init(&ocall);
+	ocall.id =3D call->id;
 	ocall.type =3D 0;	/* Voice call */
 	ocall.direction =3D call->mode_info & CALL_MODE_ORIGINATOR;
 	ocall.status =3D isi_call_status_to_clcc(call);
-- =

1.7.4


--===============6224614627602307073==--

