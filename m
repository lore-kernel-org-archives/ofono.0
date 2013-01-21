Content-Type: multipart/mixed; boundary="===============5700187513964874218=="
MIME-Version: 1.0
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH v0 1/3] hfpmodem: Refactor voicecall notify with foreach
Date: Mon, 21 Jan 2013 11:10:26 +0100
Message-ID: <1358763028-20412-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1358763028-20412-1-git-send-email-mikel.astiz.oss@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5700187513964874218==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Define a helper function in order to use foreach statements when
ofono_voicecall_notify() needs to be called.
---
 drivers/hfpmodem/voicecall.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index 505601c..9770059 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -91,6 +91,14 @@ static GSList *find_dialing(GSList *calls)
 	return c;
 }
 =

+static void voicecall_notify(gpointer value, gpointer user)
+{
+	struct ofono_call *call =3D value;
+	struct ofono_voicecall *vc =3D user;
+
+	ofono_voicecall_notify(vc, call);
+}
+
 static struct ofono_call *create_call(struct ofono_voicecall *vc, int type,
 					int direction, int status,
 					const char *num, int num_type, int clip)
@@ -1029,15 +1037,13 @@ static void hfp_clcc_cb(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 {
 	struct ofono_voicecall *vc =3D user_data;
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
-	GSList *l;
 =

 	if (!ok)
 		return;
 =

 	vd->calls =3D at_util_parse_clcc(result);
 =

-	for (l =3D vd->calls; l; l =3D l->next)
-		ofono_voicecall_notify(vc, l->data);
+	g_slist_foreach(vd->calls, voicecall_notify, vc);
 }
 =

 static void hfp_voicecall_initialized(gboolean ok, GAtResult *result,
-- =

1.7.11.7


--===============5700187513964874218==--

