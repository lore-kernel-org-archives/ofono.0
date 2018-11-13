Content-Type: multipart/mixed; boundary="===============7129607913993586669=="
MIME-Version: 1.0
From: Clement Viel <vielclement@gmail.com>
Subject: Re: [PATCH 1/3] sim800: add sim800 support.
Date: Tue, 13 Nov 2018 16:00:09 +0100
Message-ID: <20181113150009.GA4434@turing>
In-Reply-To: <CAKSBH7HUTd+dhX2CeCHR8Wqjpam78uVv6y_7SXfSiLYsm-QPeQ@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7129607913993586669==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 13, 2018 at 12:59:47PM +0100, Giacinto Cifelli wrote:
> Hi Clement,
> =

> On Tue, Nov 13, 2018 at 10:29 AM Clement Viel <vielclement@gmail.com> w=
rote:
> >
> > ---
> >  plugins/sim900.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++++=
++------
> >  1 file changed, 82 insertions(+), 9 deletions(-)
> >
> > diff --git a/plugins/sim900.c b/plugins/sim900.c
> > index a7728cd..bf7b9ec 100644
> > --- a/plugins/sim900.c
> > +++ b/plugins/sim900.c
> > @@ -24,6 +24,7 @@
> >  #endif
> >
> >  #include <errno.h>
> > +#include <string.h>
> >  #include <stdlib.h>
> >  #include <glib.h>
> >  #include <gatchat.h>
> > @@ -60,13 +61,77 @@ static char *dlc_prefixes[NUM_DLC] =3D { "Voice: ",=
 "Net: ", "SMS: ",
> >
> >  static const char *none_prefix[] =3D { NULL };
> >
> > +typedef enum type {
> > +       SIM800,
> > +       SIM900,
> > +       SIM_UNKNOWN,
> =

> maybe SIMCOM_UNKNOWN ?

Yes, I do agree, updating patchset.

> =

> > +} type_t;
> > +
> >  struct sim900_data {
> >         GIOChannel *device;
> >         GAtMux *mux;
> >         GAtChat * dlcs[NUM_DLC];
> >         guint frame_size;
> > +       type_t modem_type;
> >  };
> >
> > +static void set_modem_type (const char *type, struct ofono_modem *mode=
m)
> > +{
> > +       struct sim900_data *data =3D ofono_modem_get_data(modem);
> > +
> > +       if (strcmp(type, "sim800") =3D=3D 0)
> > +               data->modem_type =3D SIM800;
> > +       else if (strcmp(type, "sim900") =3D=3D 0)
> > +               data->modem_type =3D SIM900;
> > +       else
> > +               data->modem_type =3D SIM_UNKNOWN;
> > +       DBG("modem type is %d",data->modem_type);
> > +}
> > +
> > +static void mux_ready_notify(GAtResult *result, gpointer user_data)
> > +{
> > +       struct ofono_modem *modem =3D user_data;
> > +       struct sim900_data *data =3D ofono_modem_get_data(modem);
> > +       struct ofono_gprs *gprs =3D NULL;
> > +       struct ofono_gprs_context *gc;
> > +
> > +       ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
> > +                                       data->dlcs[SMS_DLC]);
> > +
> > +       gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->dlcs[GPRS=
_DLC]);
> > +       if (gprs =3D=3D NULL)
> > +               return;
> > +
> > +       gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM,
> > +                                                                      =
 "atmodem", data->dlcs[GPRS_DLC]);
> > +       if (gc)
> > +               ofono_gprs_add_context(gprs, gc);
> > +
> > +
> > +}
> > +
> > +static void check_model(gboolean ok, GAtResult *result, gpointer user_=
data)
> > +{
> > +       struct ofono_modem *modem =3D user_data;
> > +       GAtResultIter iter;
> > +       char const *model;
> > +
> > +       DBG("");
> > +
> > +       g_at_result_iter_init(&iter, result);
> > +
> > +       while (g_at_result_iter_next(&iter, NULL)) {
> > +               if (!g_at_result_iter_next_unquoted_string(&iter, &mode=
l))
> > +                       continue;
> > +
> > +               DBG("setting type %s", model);
> > +               if (strstr(model, "SIM800"))
> > +                       set_modem_type("sim800", modem);
> > +               else if (strstr(model, "SIM900"))
> > +                       set_modem_type("sim900", modem);
> > +       }
> > +}
> > +
> >  static int sim900_probe(struct ofono_modem *modem)
> >  {
> >         struct sim900_data *data;
> > @@ -78,7 +143,6 @@ static int sim900_probe(struct ofono_modem *modem)
> >                 return -ENOMEM;
> >
> >         ofono_modem_set_data(modem, data);
> > -
> >         return 0;
> >  }
> >
> > @@ -111,6 +175,7 @@ static GAtChat *open_device(struct ofono_modem *mod=
em,
> >         GHashTable *options;
> >
> >         device =3D ofono_modem_get_string(modem, key);
> > +
> >         if (device =3D=3D NULL)
> >                 return NULL;
> >
> > @@ -232,6 +297,11 @@ static void setup_internal_mux(struct ofono_modem =
*modem)
> >                         goto error;
> >                 }
> >         }
> > +       if (data->modem_type =3D=3D SIM800) {
> > +               for (i =3D 0; i<NUM_DLC; i++) {
> > +                       g_at_chat_register(data->dlcs[i], "SMS Ready", =
mux_ready_notify, FALSE, modem, NULL);
> > +               }
> > +       }
> >
> >         ofono_modem_set_powered(modem, TRUE);
> >
> > @@ -294,6 +364,7 @@ static int sim900_enable(struct ofono_modem *modem)
> >                 return -EINVAL;
> >
> >         g_at_chat_send(data->dlcs[SETUP_DLC], "ATE0", NULL, NULL, NULL,=
 NULL);
> > +       g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CGMM", NULL,check_mod=
el, modem, NULL);
> >
> >         /* For obtain correct sms service number */
> >         g_at_chat_send(data->dlcs[SETUP_DLC], "AT+CSCS=3D\"GSM\"", NULL,
> > @@ -353,18 +424,20 @@ static void sim900_post_sim(struct ofono_modem *m=
odem)
> >
> >         DBG("%p", modem);
> >
> > -       ofono_phonebook_create(modem, 0, "atmodem", data->dlcs[VOICE_DL=
C]);
> > -       ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
> > +       if (data->modem_type !=3D SIM800) {
> > +               ofono_phonebook_create(modem, 0, "atmodem", data->dlcs[=
VOICE_DLC]);
> > +               ofono_sms_create(modem, OFONO_VENDOR_SIMCOM, "atmodem",
> >                                                 data->dlcs[SMS_DLC]);
> >
> > -       gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->dlcs[GPRS=
_DLC]);
> > -       if (gprs =3D=3D NULL)
> > -               return;
> > +               gprs =3D ofono_gprs_create(modem, 0, "atmodem", data->d=
lcs[GPRS_DLC]);
> > +               if (gprs =3D=3D NULL)
> > +                       return;
> >
> > -       gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SIMCOM_SIM=
900,
> > +               gc =3D ofono_gprs_context_create(modem, OFONO_VENDOR_SI=
MCOM_SIM900,
> >                                         "atmodem", data->dlcs[GPRS_DLC]=
);
> > -       if (gc)
> > -               ofono_gprs_add_context(gprs, gc);
> > +               if (gc)
> > +                       ofono_gprs_add_context(gprs, gc);
> > +       }
> >  }
> >
> >  static void sim900_post_online(struct ofono_modem *modem)
> > --
> =

> Regards,
> Giacinto

Regards
Clement

--===============7129607913993586669==--

