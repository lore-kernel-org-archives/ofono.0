Content-Type: multipart/mixed; boundary="===============7552384385530150735=="
MIME-Version: 1.0
From: Bertrand Aygon <bertrand.aygon@intel.com>
Subject: [PATCH] zte: Use at_util's cpin polling implementation.
Date: Wed, 27 Jul 2011 18:26:33 +0200
Message-ID: <1311783993-23427-1-git-send-email-bertrand.aygon@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7552384385530150735==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

---
 plugins/zte.c |   25 +++++++++++++++++++++++--
 1 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/plugins/zte.c b/plugins/zte.c
index 4426b4c..610c164 100644
--- a/plugins/zte.c
+++ b/plugins/zte.c
@@ -52,6 +52,8 @@ static const char *none_prefix[] =3D { NULL };
 struct zte_data {
 	GAtChat *modem;
 	GAtChat *aux;
+	gboolean have_sim;
+	struct at_util_sim_state_query *sim_state_query;
 };
 =

 static int zte_probe(struct ofono_modem *modem)
@@ -120,6 +122,18 @@ static GAtChat *open_device(struct ofono_modem *modem,
 	return chat;
 }
 =

+static void sim_state_cb(gboolean present, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct zte_data *data =3D ofono_modem_get_data(modem);
+
+	at_util_sim_state_query_free(data->sim_state_query);
+	data->sim_state_query =3D NULL;
+
+	data->have_sim =3D present;
+	ofono_modem_set_powered(modem, TRUE);
+}
+
 static void cfun_enable(gboolean ok, GAtResult *result, gpointer user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -133,9 +147,16 @@ static void cfun_enable(gboolean ok, GAtResult *result=
, gpointer user_data)
 =

 		g_at_chat_unref(data->aux);
 		data->aux =3D NULL;
+
+		ofono_modem_set_powered(modem, FALSE);
+
+		return;
 	}
 =

-	ofono_modem_set_powered(modem, ok);
+	data->sim_state_query =3D at_util_sim_state_query_new(data->aux,
+								2, 20,
+								sim_state_cb,
+								modem);
 }
 =

 static int zte_enable(struct ofono_modem *modem)
@@ -239,7 +260,7 @@ static void zte_pre_sim(struct ofono_modem *modem)
 	sim =3D ofono_sim_create(modem, OFONO_VENDOR_QUALCOMM_MSM,
 						"atmodem", data->aux);
 =

-	if (sim)
+	if (data->have_sim && sim)
 		ofono_sim_inserted_notify(sim, TRUE);
 }
 =

-- =

1.7.4.1

---------------------------------------------------------------------
Intel Corporation SAS (French simplified joint stock company)
Registered headquarters: "Les Montalets"- 2, rue de Paris, =

92196 Meudon Cedex, France
Registration Number:  302 456 199 R.C.S. NANTERRE
Capital: 4,572,000 Euros

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

--===============7552384385530150735==--

