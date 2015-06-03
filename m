Content-Type: multipart/mixed; boundary="===============5500637881066818831=="
MIME-Version: 1.0
From: Kuba Pawlak <kubax.t.pawlak@intel.com>
Subject: [PATCH v2] Connecting a phone with mpty call does not trigger CLCC
 polling
Date: Wed, 03 Jun 2015 19:25:50 +0200
Message-ID: <1433352350-10595-1-git-send-email-kubax.t.pawlak@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5500637881066818831==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

If there is more then one active or held call, we are in mpty calls.
We won't get indicator update if any of them is released by CHLD=3D1x.
So we have to poll it.
---
 drivers/hfpmodem/voicecall.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/hfpmodem/voicecall.c b/drivers/hfpmodem/voicecall.c
index afeb35f..e3e6e0f 100644
--- a/drivers/hfpmodem/voicecall.c
+++ b/drivers/hfpmodem/voicecall.c
@@ -1134,6 +1134,10 @@ static void hfp_clcc_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 	struct ofono_voicecall *vc =3D user_data;
 	struct voicecall_data *vd =3D ofono_voicecall_get_data(vc);
 	unsigned int mpty_ids;
+	GSList *n;
+	struct ofono_call *nc;
+	unsigned int num_active =3D 0;
+	unsigned int num_held =3D 0;
 =

 	if (!ok)
 		return;
@@ -1142,6 +1146,22 @@ static void hfp_clcc_cb(gboolean ok, GAtResult *resu=
lt, gpointer user_data)
 =

 	g_slist_foreach(vd->calls, voicecall_notify, vc);
 	ofono_voicecall_mpty_hint(vc, mpty_ids);
+
+	n =3D vd->calls;
+
+	while (n) {
+		nc =3D n->data;
+
+		if (nc->status =3D=3D CALL_STATUS_ACTIVE)
+			num_active++;
+		else if (nc->status =3D=3D CALL_STATUS_HELD)
+			num_held++;
+
+		n =3D n->next;
+	}
+
+	if ((num_active > 1 || num_held > 1) && !vd->clcc_source)
+		vd->clcc_source =3D g_timeout_add(POLL_CLCC_INTERVAL, poll_clcc, vc);
 }
 =

 static void hfp_voicecall_initialized(gboolean ok, GAtResult *result,
-- =

1.7.11.7

Intel GmbH
Dornacher Strasse 1
85622 Feldkirchen/Muenchen, Deutschland
Sitz der Gesellschaft: Feldkirchen bei Muenchen
Geschaeftsfuehrer: Christian Lamprechter, Hannes Schwaderer, Douglas Lusk
Registergericht: Muenchen HRB 47456
Ust.-IdNr./VAT Registration No.: DE129385895
Citibank Frankfurt a.M. (BLZ 502 109 00) 600119052


--===============5500637881066818831==--

