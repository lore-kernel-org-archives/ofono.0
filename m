Content-Type: multipart/mixed; boundary="===============6372962797377141959=="
MIME-Version: 1.0
From: Eric BOUXIROT <eric.bouxirot@azimut-monitoring.com>
Subject: Re: problem sim status
Date: Thu, 27 Mar 2014 23:14:33 +0100
Message-ID: <lh27sl$bdg$1@ger.gmane.org>
In-Reply-To: <lh25hi$f72$1@ger.gmane.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6372962797377141959==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> for thoses interested, i will send my patch in next minutes. (let me make=
 it =

> clean)

this make an SL8083 Sierra modem to work with ofono. i mean that do not =

change anything for others modems.

diff -uprN a/drivers/atmodem/sim.c b/drivers/atmodem/sim.c
--- a/drivers/atmodem/sim.c	2013-11-08 08:37:52.000000000 +0100
+++ b/drivers/atmodem/sim.c	2014-03-27 22:28:58.000000000 +0100
@@ -1254,6 +1254,7 @@ static void at_pin_send_cb(gboolean ok,
 	case OFONO_VENDOR_ALCATEL:
 	case OFONO_VENDOR_HUAWEI:
 	case OFONO_VENDOR_SIMCOM:
+	case OFONO_VENDOR_SIERRA:
 		/*
 		 * On ZTE modems, after pin is entered, SIM state is checked
 		 * by polling CPIN as their modem doesn't provide unsolicited
diff -uprN a/plugins/sierra.c b/plugins/sierra.c
--- a/plugins/sierra.c	2013-11-08 08:37:52.000000000 +0100
+++ b/plugins/sierra.c	2014-03-27 23:00:59.872241558 +0100
@@ -48,6 +48,7 @@ static const char *none_prefix[] =3D { NUL

 struct sierra_data {
 	GAtChat *modem;
+	struct at_util_sim_state_query *sim_state_query;
 };

 static void sierra_debug(const char *str, void *user_data)
@@ -119,6 +120,17 @@ static GAtChat *open_device(struct ofono
 	return chat;
 }

+static void sim_state_cb(gboolean present, gpointer user_data)
+{
+	struct ofono_modem *modem =3D user_data;
+	struct sierra_data *data =3D ofono_modem_get_data(modem);
+
+	at_util_sim_state_query_free(data->sim_state_query);
+	data->sim_state_query =3D NULL;
+
+	ofono_modem_set_powered(modem, TRUE);
+}
+
 static void cfun_enable(gboolean ok, GAtResult *result, gpointer =

user_data)
 {
 	struct ofono_modem *modem =3D user_data;
@@ -129,9 +141,13 @@ static void cfun_enable(gboolean ok, GAt
 	if (!ok) {
 		g_at_chat_unref(data->modem);
 		data->modem =3D NULL;
+
+		ofono_modem_set_powered(modem, FALSE);
 	}

-	ofono_modem_set_powered(modem, ok);
+	data->sim_state_query =3D at_util_sim_state_query_new(data->modem,
+						2, 20, sim_state_cb, modem,
+						NULL);
 }

 static int sierra_enable(struct ofono_modem *modem)


--===============6372962797377141959==--

