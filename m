Content-Type: multipart/mixed; boundary="===============5425270164353075841=="
MIME-Version: 1.0
From: Pekka.Pessi@nokia.com
Subject: [sim-ready-notify RFC 2/2] ifx: sim driver follows +XSIM
Date: Tue, 15 Feb 2011 18:59:37 +0200
Message-ID: <1297789177-16459-2-git-send-email-Pekka.Pessi@nokia.com>
In-Reply-To: <1297789177-16459-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5425270164353075841==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

From: Pekka Pessi <Pekka.Pessi@nokia.com>

---
 plugins/ifx.c |   61 +----------------------------------------------------=
----
 1 files changed, 1 insertions(+), 60 deletions(-)

diff --git a/plugins/ifx.c b/plugins/ifx.c
index 527a8c4..ddfb4af 100644
--- a/plugins/ifx.c
+++ b/plugins/ifx.c
@@ -98,8 +98,6 @@ struct ifx_data {
 	int audio_context;
 	const char *audio_setting;
 	int audio_loopback;
-	struct ofono_sim *sim;
-	gboolean have_sim;
 };
 =

 static void ifx_debug(const char *str, void *user_data)
@@ -138,54 +136,6 @@ static void ifx_remove(struct ofono_modem *modem)
 	g_free(data);
 }
 =

-static void xsim_notify(GAtResult *result, gpointer user_data)
-{
-	struct ofono_modem *modem =3D user_data;
-	struct ifx_data *data =3D ofono_modem_get_data(modem);
-
-	GAtResultIter iter;
-	int state;
-
-	if (data->sim =3D=3D NULL)
-		return;
-
-	g_at_result_iter_init(&iter, result);
-
-	if (!g_at_result_iter_next(&iter, "+XSIM:"))
-		return;
-
-	if (!g_at_result_iter_next_number(&iter, &state))
-		return;
-
-	DBG("state %d", state);
-
-	switch (state) {
-	case 0:	/* SIM not present */
-	case 9:	/* SIM Removed */
-		if (data->have_sim =3D=3D TRUE) {
-			ofono_sim_inserted_notify(data->sim, FALSE);
-			data->have_sim =3D FALSE;
-		}
-		break;
-	case 1:	/* PIN verification needed */
-	case 2:	/* PIN verification not needed =EF=BF=BD=EF=BF=BD=EF=BF=BD Ready =
*/
-	case 3:	/* PIN verified =EF=BF=BD=EF=BF=BD=EF=BF=BD Ready */
-	case 4:	/* PUK verification needed */
-	case 5:	/* SIM permanently blocked */
-	case 6:	/* SIM Error */
-	case 7:	/* ready for attach (+COPS) */
-	case 8:	/* SIM Technical Problem */
-		if (data->have_sim =3D=3D FALSE) {
-			ofono_sim_inserted_notify(data->sim, TRUE);
-			data->have_sim =3D TRUE;
-		}
-		break;
-	default:
-		ofono_warn("Unknown SIM state %d received", state);
-		break;
-	}
-}
-
 static void shutdown_device(struct ifx_data *data)
 {
 	int i, fd;
@@ -326,18 +276,9 @@ static void xgendata_query(gboolean ok, GAtResult *res=
ult, gpointer user_data)
 		}
 	}
 =

-	data->have_sim =3D FALSE;
-
 	/* notify that the modem is ready so that pre_sim gets called */
 	ofono_modem_set_powered(modem, TRUE);
 =

-	g_at_chat_register(data->dlcs[AUX_DLC], "+XSIM:", xsim_notify,
-						FALSE, modem, NULL);
-
-	/* enable XSIM and XLOCK notifications */
-	g_at_chat_send(data->dlcs[AUX_DLC], "AT+XSIMSTATE=3D1", none_prefix,
-						NULL, NULL, NULL);
-
 	return;
 =

 error:
@@ -678,7 +619,7 @@ static void ifx_pre_sim(struct ofono_modem *modem)
 	DBG("%p", modem);
 =

 	ofono_devinfo_create(modem, 0, "atmodem", data->dlcs[AUX_DLC]);
-	data->sim =3D ofono_sim_create(modem, OFONO_VENDOR_IFX,
+	ofono_sim_create(modem, OFONO_VENDOR_IFX,
 					"atmodem", data->dlcs[AUX_DLC]);
 	ofono_voicecall_create(modem, 0, "ifxmodem", data->dlcs[VOICE_DLC]);
 	ofono_audio_settings_create(modem, 0,
-- =

1.7.1


--===============5425270164353075841==--

