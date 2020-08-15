Content-Type: multipart/mixed; boundary="===============7384736429714551766=="
MIME-Version: 1.0
From: Sergey Matyukevich <geomatsi@gmail.com>
Subject: [RFC PATCH 4/4] plugins: gemalto: fix incomplete at-chat shutdown
Date: Sun, 16 Aug 2020 00:43:58 +0300
Message-ID: <20200815214358.69100-5-geomatsi@gmail.com>
In-Reply-To: <20200815214358.69100-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7384736429714551766==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Function gemalto_modem_ready attempts to restart AT chat data->app
after  incomplete shutdown. As a result, new AT chat does not work
as expected loosing AT commands.

Signed-off-by: Sergey Matyukevich <geomatsi@gmail.com>
---
 plugins/gemalto.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/plugins/gemalto.c b/plugins/gemalto.c
index 238c7cc4..321c8c1b 100644
--- a/plugins/gemalto.c
+++ b/plugins/gemalto.c
@@ -222,6 +222,8 @@ static void sim_state_cb(gboolean present, gpointer use=
r_data)
 	struct ofono_modem *modem =3D user_data;
 	struct gemalto_data *data =3D ofono_modem_get_data(modem);
 =

+	DBG("");
+
 	at_util_sim_state_query_free(data->sim_state_query);
 	data->sim_state_query =3D NULL;
 =

@@ -241,6 +243,8 @@ static void cfun_enable(gboolean ok, GAtResult *result,=
 gpointer user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct gemalto_data *data =3D ofono_modem_get_data(modem);
 =

+	DBG("");
+
 	if (!ok) {
 		g_at_chat_unref(data->app);
 		data->app =3D NULL;
@@ -451,6 +455,8 @@ static void gemalto_modem_ready(GAtResult *result, gpoi=
nter user_data)
 	data->modem_ready_id =3D 0;
 	data->trial_cmd_id =3D 0;
 =

+	g_at_chat_cancel_all(data->app);
+	g_at_chat_unregister_all(data->app);
 	g_at_chat_unref(data->app);
 =

 	data->app =3D open_device(app);
@@ -466,6 +472,8 @@ static void gemalto_at_cb(gboolean ok, GAtResult *resul=
t, gpointer user_data)
 	struct ofono_modem *modem =3D user_data;
 	struct gemalto_data *data =3D ofono_modem_get_data(modem);
 =

+	DBG("");
+
 	g_at_chat_unregister(data->app, data->modem_ready_id);
 	data->modem_ready_id =3D 0;
 =

-- =

2.28.0

--===============7384736429714551766==--

