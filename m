Content-Type: multipart/mixed; boundary="===============3513657343238418444=="
MIME-Version: 1.0
From: Dragos Tatulea <dragos@endocode.com>
Subject: [PATCH] lte: add support for provisioning
Date: Wed, 16 Nov 2016 16:53:20 +0100
Message-ID: <1479311600-12701-1-git-send-email-dragos@endocode.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3513657343238418444==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Provision if there's no DefaultAPN key in the settings file.
---
 src/lte.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/src/lte.c b/src/lte.c
index 99a61fc..82da868 100644
--- a/src/lte.c
+++ b/src/lte.c
@@ -54,6 +54,30 @@ struct ofono_lte {
 =

 static GSList *g_drivers =3D NULL;
 =

+static void lte_try_provision(struct ofono_lte *lte)
+{
+	struct ofono_modem *modem =3D __ofono_atom_get_modem(lte->atom);
+	struct ofono_sim *sim =3D __ofono_atom_find(OFONO_ATOM_TYPE_SIM, modem);
+	ofono_bool_t ret;
+	struct ofono_gprs_provision_data *pd =3D NULL;
+	int count =3D 0;
+
+	ret =3D __ofono_gprs_provision_get_settings(
+		ofono_sim_get_mcc(sim), ofono_sim_get_mnc(sim),
+		ofono_sim_get_spn(sim), &pd, &count
+	);
+
+	if (ret =3D=3D FALSE) {
+		ofono_warn(DEFAULT_APN_KEY " provisioning failed.");
+		return;
+	}
+
+	if (is_valid_apn(pd[0].apn))
+		strcpy(lte->info.apn, pd[0].apn);
+
+	__ofono_gprs_provision_free_settings(pd, count);
+}
+
 static void lte_load_settings(struct ofono_lte *lte)
 {
 	char *apn;
@@ -74,6 +98,9 @@ static void lte_load_settings(struct ofono_lte *lte)
 	if (apn) {
 		strcpy(lte->info.apn, apn);
 		g_free(apn);
+	} else {
+		DBG(DEFAULT_APN_KEY " doesn't exist, try provisioning.");
+		lte_try_provision(lte);
 	}
 }
 =

-- =

2.7.4


--===============3513657343238418444==--

