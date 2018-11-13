Content-Type: multipart/mixed; boundary="===============0555468865906826490=="
MIME-Version: 1.0
From: Clement Viel <vielclement@gmail.com>
Subject: Re: [PATCH 1/3] sim800: add sim800 support.
Date: Tue, 13 Nov 2018 18:11:22 +0100
Message-ID: <20181113171122.GA5403@turing>
In-Reply-To: <b43cbce4-36b6-ecf0-0647-27efe2496c2c@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0555468865906826490==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 05:53:56PM +0100, Jonas Bonn wrote:
> Hi,
> =

> On 13/11/2018 16:33, Clement Viel wrote:
> >---
> >  plugins/sim900.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++=
++------
> >  1 file changed, 82 insertions(+), 9 deletions(-)
> >
> >diff --git a/plugins/sim900.c b/plugins/sim900.c
> >index a7728cd..f280e5e 100644
> >--- a/plugins/sim900.c
> >+++ b/plugins/sim900.c
> >@@ -24,6 +24,7 @@
> >  #endif
> >  #include <errno.h>
> >+#include <string.h>
> >  #include <stdlib.h>
> >  #include <glib.h>
> >  #include <gatchat.h>
> >@@ -60,13 +61,77 @@ static char *dlc_prefixes[NUM_DLC] =3D { "Voice: ", =
"Net: ", "SMS: ",
> >  static const char *none_prefix[] =3D { NULL };
> >+enum type {
> >+	SIM800,
> >+	SIM900,
> >+	SIMCOM_UNKNOWN,
> >+};
> >+
> =

> Makes more sense to have UNKNOWN be the first entry in the enumeration.

You're right !
> =

> >  struct sim900_data {
> >  	GIOChannel *device;
> >  	GAtMux *mux;
> >  	GAtChat * dlcs[NUM_DLC];
> >  	guint frame_size;
> >+	enum type modem_type;
> >  };
> >+static void set_modem_type (const char *type, struct ofono_modem *modem)
> >+{
> >+	struct sim900_data *data =3D ofono_modem_get_data(modem);
> >+
> >+	if (strcmp(type, "sim800") =3D=3D 0)
> >+		data->modem_type =3D SIM800;
> >+	else if (strcmp(type, "sim900") =3D=3D 0)
> >+		data->modem_type =3D SIM900;
> >+	else
> >+		data->modem_type =3D SIMCOM_UNKNOWN;
> >+	DBG("modem type is %d",data->modem_type);
> >+}
> >+
> >+static void mux_ready_notify(GAtResult *result, gpointer user_data)
> >+{
> >+	struct ofono_modem *modem =3D user_data;
> >+	struct sim900_data *data =3D ofono_modem_get_data(modem);
> >+	struct ofono_gprs *gprs =3D NULL;
> >+	struct ofono_gprs_context *gc;
> >+
> >+	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
> >+					data->dlcs[SMS_DLC]);
> >+
> >+	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->dlcs[GPRS_DLC]);
> >+	if (gprs =3D=3D NULL)
> >+		return;
> >+
> >+	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM,
> >+									"atmodem", data->dlcs[GPRS_DLC]);
> >+	if (gc)
> >+		ofono_gprs_add_context(gprs, gc);
> >+	=

> >+
> >+}
> >+
> >+static void check_model(gboolean ok, GAtResult *result, gpointer user_d=
ata)
> >+{
> >+	struct ofono_modem *modem =3D user_data;
> >+	GAtResultIter iter;
> >+	char const *model;
> >+
> >+	DBG("");
> >+
> >+	g_at_result_iter_init(&iter, result);
> >+
> >+	while (g_at_result_iter_next(&iter, NULL)) {
> >+		if (!g_at_result_iter_next_unquoted_string(&iter, &model))
> >+			continue;
> =

> The documentation doesn't indicate that the model type is given as an
> arbitrary string at a random location in the response.  It's pretty speci=
fic
> about the SIM800/SIM900 token appearing as the first element of the
> response.  Is the documentation not correct on this point?
> =

> >+
> >+		DBG("setting type %s", model);
> >+		if (strstr(model, "SIM800"))
> >+			set_modem_type("sim800", modem);
> =

> Instead of doing this dance with strings, just directly set the type:
> =

> data->modem_type =3D SIM800;
> =

> =


Right again.

> >+		else if (strstr(model, "SIM900"))
> >+			set_modem_type("sim900", modem);
> >+	}
> >+}
> >+
> >  static int sim900_probe(struct ofono_modem *modem)
> >  {
> >  	struct sim900_data *data;
> >@@ -78,7 +143,6 @@ static int sim900_probe(struct ofono_modem *modem)
> >  		return -ENOMEM;
> >  	ofono_modem_set_data(modem, data);
> >-
> =

> Whitespace.
> =

> >  	return 0;
> >  }
> >@@ -111,6 +175,7 @@ static GAtChat *open_device(struct ofono_modem *mode=
m,
> >  	GHashTable *options;
> >  	device =3D ofono_modem_get_string(modem, key);
> >+
> =

> Ditto.
> =

> >  	if (device =3D=3D NULL)
> >  		return NULL;
> >@@ -232,6 +297,11 @@ static void setup_internal_mux(struct ofono_modem *=
modem)
> >  			goto error;
> >  		}
> >  	}
> >+	if (data->modem_type =3D=3D SIM800) {
> >+		for (i =3D 0; i<NUM_DLC; i++) {
> >+			g_at_chat_register(data->dlcs[i], "SMS Ready", mux_ready_notify, FAL=
SE, modem, NULL);
> >+		}
> >+	}
> >  	ofono_modem_set_powered(modem, TRUE);
> >@@ -294,6 +364,7 @@ static int sim900_enable(struct ofono_modem *modem)
> >  		return -EINVAL;
> >  	g_at_chat_send(data->dlcs[SETUP_DLC], "ATE0", NULL, NULL, NULL, NULL);
> >+	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CGMM", NULL,check_model, mod=
em, NULL);
> >  	/* For obtain correct sms service number */
> >  	g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CSCS=3D\"GSM\"", NULL,
> >@@ -353,18 +424,20 @@ static void sim900_post_sim(struct ofono_modem *mo=
dem)
> >  	DBG("%p", modem);
> >-	ofono_phonebook_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
> >-	ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
> >+	if (data->modem_type !=3D SIM800) {
> >+		ofono_phonebook_create(modem, 0, "atmodem", data->dlcs[VOICE_DLC]);
> >+		ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
> >  						data->dlcs[SMS_DLC]);
> >-	gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->dlcs[GPRS_DLC]);
> >-	if (gprs =3D=3D NULL)
> >-		return;
> >+		gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->dlcs[GPRS_DLC]);
> >+		if (gprs =3D=3D NULL)
> >+			return;
> >-	gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM_SIM900,
> >+		gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM_SIM900,
> >  					"atmodem", data->dlcs[GPRS_DLC]);
> >-	if (gc)
> >-		ofono_gprs_add_context(gprs, gc);
> >+		if (gc)
> >+			ofono_gprs_add_context(gprs, gc);
> >+	}
> =

> All this is duplicated in mux_ready_notify... maybe move it a function of
> its own...?

this is duplicated because the ofono atoms cannot be created at the same po=
int for the two modems :
for sim800, we must wait for an URC stating that channels have been created=
 whereas sim900 is much straightforward.
That's why i've splitted : one in post_sim (sim900) another in mux_ready_no=
tify (sim800).

> =

> >  }
> >  static void sim900_post_online(struct ofono_modem *modem)
> >

--===============0555468865906826490==--

