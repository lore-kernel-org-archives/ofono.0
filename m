Content-Type: multipart/mixed; boundary="===============4815586089036163675=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH 3/9] atmodem: use ofono_call initializer
Date: Tue, 01 Feb 2011 15:12:44 -0200
Message-ID: <1296580370-2823-3-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1296580370-2823-1-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4815586089036163675==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 drivers/atmodem/atutil.c    |    4 +++-
 drivers/atmodem/voicecall.c |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/atmodem/atutil.c b/drivers/atmodem/atutil.c
index a55b3f5..01f5460 100644
--- a/drivers/atmodem/atutil.c
+++ b/drivers/atmodem/atutil.c
@@ -132,10 +132,12 @@ GSList *at_util_parse_clcc(GAtResult *result)
 		if (g_at_result_iter_next_string(&iter, &str))
 			g_at_result_iter_next_number(&iter, &number_type);
 =

-		call =3D g_try_new0(struct ofono_call, 1);
+		call =3D g_try_new(struct ofono_call, 1);
 		if (call =3D=3D NULL)
 			break;
 =

+		ofono_call_init(call);
+
 		call->id =3D id;
 		call->direction =3D dir;
 		call->status =3D status;
diff --git a/drivers/atmodem/voicecall.c b/drivers/atmodem/voicecall.c
index a64269d..583e037 100644
--- a/drivers/atmodem/voicecall.c
+++ b/drivers/atmodem/voicecall.c
@@ -112,10 +112,12 @@ static struct ofono_call *create_call(struct ofono_vo=
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
 	call->id =3D ofono_voicecall_get_next_callid(vc);
 	call->type =3D type;
 	call->direction =3D direction;
-- =

1.7.4


--===============4815586089036163675==--

