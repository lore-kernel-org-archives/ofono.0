Content-Type: multipart/mixed; boundary="===============7711647379286438797=="
MIME-Version: 1.0
From: Vijay Nayani <vijay.nayani@elektrobit.com>
Subject: [RFC PATCH 20/20] modem: Add netreg watch for tech switch
Date: Mon, 11 Apr 2011 13:20:18 +0300
Message-ID: <1302517218-2147-21-git-send-email-vijay.nayani@elektrobit.com>
In-Reply-To: <1302517218-2147-1-git-send-email-vijay.nayani@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7711647379286438797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Placeholder for technology switch based on
registered technology and preferred ue mode also
added along with the netreg status watch.
---
 src/modem.c |   79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++
 1 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/src/modem.c b/src/modem.c
index aecb35a..65db45c 100644
--- a/src/modem.c
+++ b/src/modem.c
@@ -84,6 +84,9 @@ struct ofono_modem {
 	struct ofono_sim	*sim;
 	unsigned int		sim_watch;
 	unsigned int		sim_ready_watch;
+	struct ofono_netreg	*netreg;
+	unsigned int		netreg_watch;
+	unsigned int		netreg_status_watch;
 	const struct ofono_modem_driver *driver;
 	void			*driver_data;
 	char			*driver_type;
@@ -1846,6 +1849,75 @@ static void sim_watch(struct ofono_atom *atom,
 							modem, NULL);
 }
 =

+static void netreg_status_watch(int status, int lac, int ci, int tech,
+					const char *mcc, const char *mnc,
+					void *data)
+{
+	struct ofono_modem *modem =3D data;
+
+	if (status !=3D NETWORK_REGISTRATION_STATUS_REGISTERED &&
+			status !=3D NETWORK_REGISTRATION_STATUS_ROAMING)
+		return;
+
+	switch (tech) {
+	case ACCESS_TECHNOLOGY_EUTRAN:
+		switch(modem->pref_mode) {
+		case PREFERRED_UE_MODE_PS_VOICE_CENTRIC:
+		case PREFERRED_UE_MODE_PS_DATA_CENTRIC:
+			/* No need to do any switching */
+			break;
+		case PREFERRED_UE_MODE_CS_PS_VOICE_CENTRIC:
+		case PREFERRED_UE_MODE_CS_PS_DATA_CENTRIC:
+			/*
+			 * All atoms needs to be created which is
+			 * already done
+			 */
+			break;
+		}
+		break;
+	case ACCESS_TECHNOLOGY_GSM:
+	case ACCESS_TECHNOLOGY_GSM_COMPACT:
+	case ACCESS_TECHNOLOGY_UTRAN:
+	case ACCESS_TECHNOLOGY_GSM_EGPRS:
+	case ACCESS_TECHNOLOGY_UTRAN_HSDPA:
+	case ACCESS_TECHNOLOGY_UTRAN_HSUPA:
+	case ACCESS_TECHNOLOGY_UTRAN_HSDPA_HSUPA:
+		switch(modem->pref_mode) {
+		case PREFERRED_UE_MODE_PS_VOICE_CENTRIC:
+			/* Switch to 3G */
+			break;
+		case PREFERRED_UE_MODE_CS_PS_VOICE_CENTRIC:
+		case PREFERRED_UE_MODE_CS_PS_DATA_CENTRIC:
+			/*
+			 * All atoms needs to be created which is already
+			 * done.
+			 */
+			break;
+		default:
+			break;
+		}
+		break;
+	}
+}
+
+static void netreg_watch(struct ofono_atom *atom,
+			enum ofono_atom_watch_condition cond, void *data)
+{
+	struct ofono_modem *modem =3D data;
+
+	if (cond =3D=3D OFONO_ATOM_WATCH_CONDITION_UNREGISTERED) {
+		modem->netreg_status_watch =3D 0;
+		modem->netreg =3D NULL;
+		return;
+	}
+
+	modem->netreg =3D __ofono_atom_get_data(atom);
+	modem->netreg_status_watch =3D __ofono_netreg_add_status_watch(
+							modem->netreg,
+							netreg_status_watch,
+							modem, NULL);
+}
+
 void __ofono_modemwatch_init(void)
 {
 	g_modemwatches =3D __ofono_watchlist_new(g_free);
@@ -1988,6 +2060,10 @@ int ofono_modem_register(struct ofono_modem *modem)
 					OFONO_ATOM_TYPE_SIM,
 					sim_watch, modem, NULL);
 =

+	modem->netreg_watch =3D __ofono_modem_add_atom_watch(modem,
+					OFONO_ATOM_TYPE_NETREG,
+					netreg_watch, modem, NULL);
+
 	return 0;
 }
 =

@@ -2020,6 +2096,9 @@ static void modem_unregister(struct ofono_modem *mode=
m)
 	modem->sim_watch =3D 0;
 	modem->sim_ready_watch =3D 0;
 =

+	modem->netreg_watch =3D 0;
+	modem->netreg_status_watch =3D 0;
+
 	g_slist_foreach(modem->interface_list, (GFunc) g_free, NULL);
 	g_slist_free(modem->interface_list);
 	modem->interface_list =3D NULL;
-- =

1.7.0.4


--===============7711647379286438797==--

