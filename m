Content-Type: multipart/mixed; boundary="===============6911467915408716092=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] Telit HE910 general fixes for gprs, sms and voicecall
Date: Mon, 09 Mar 2015 20:59:35 -0500
Message-ID: <54FE5007.3070205@gmail.com>
In-Reply-To: <CAH4ZQwsN37v8_62vBf1vMNH3u+AdreTuONz38=_rC9ZREYTbew@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6911467915408716092==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Enrico,

On 03/06/2015 10:07 AM, Enrico Sau wrote:
> diff --git a/plugins/he910.c b/plugins/he910.c
> index 69362b8..304fd35 100644

Could you submit patches using git send-email?  Otherwise I can't apply =

them.

Lets go through the changes one by one:

> --- a/plugins/he910.c
> +++ b/plugins/he910.c
> @@ -59,6 +59,8 @@
>   #include <drivers/atmodem/atutil.h>
>   #include <drivers/atmodem/vendor.h>
>
> +#define TELIT_CFUN_DELAY 3*1000*1000 /* uS */
> +
>   static const char *none_prefix[] =3D { NULL };
>   static const char *qss_prefix[] =3D { "#QSS:", NULL };
>
> @@ -141,7 +143,7 @@ static void switch_sim_state_status(struct
> ofono_modem *modem, int status)
>          case 3: /* SIM inserted, SMS and phonebook ready */
>                  if (data->sms_phonebook_added =3D=3D FALSE) {
>                          ofono_phonebook_create(modem, 0, "atmodem",
> data->chat);
> -                       ofono_sms_create(modem, 0, "atmodem", data->chat);
> +                       ofono_sms_create(modem, OFONO_VENDOR_TELIT,
> "atmodem", data->chat);
>                          data->sms_phonebook_added =3D TRUE;
>                  }
>                  break;
> @@ -217,6 +219,8 @@ static void cfun_enable_cb(gboolean ok, GAtResult
> *result, gpointer user_data)
>           * When the DCD is disabled the modem does not hangup anymore
>           * after the data connection.
>           */
> +       g_at_chat_send(data->modem, "AT&C0", NULL, NULL, NULL, NULL);
> +
>          g_at_chat_send(data->chat, "AT&C0", NULL, NULL, NULL, NULL);
>
>          data->have_sim =3D FALSE;
> @@ -224,24 +228,40 @@ static void cfun_enable_cb(gboolean ok, GAtResult
> *result, gpointer user_data)
>          ofono_modem_set_powered(modem, TRUE);
>
> -       /*
> -        * Tell the modem not to automatically initiate auto-attach
> -        * proceedures on its own.
> -        */
> -       g_at_chat_send(data->chat, "AT#AUTOATT=3D0", none_prefix,
> -                               NULL, NULL, NULL);
> -

I really think this part is not necessary.  oFono expects autoattach to =

be disabled.

>          /* Follow sim state */
>          g_at_chat_register(data->chat, "#QSS:", he910_qss_notify,
>                                  FALSE, modem, NULL);
>
> -       /* Enable sim state notification */
> -       g_at_chat_send(data->chat, "AT#QSS=3D2", none_prefix, NULL, NULL,
> NULL);
> -
>          g_at_chat_send(data->chat, "AT#QSS?", qss_prefix,
>                          qss_query_cb, modem, NULL);
>   }
>
> +static void cfun_delay_cb(gboolean ok, GAtResult *result, gpointer
> user_data)
> +{
> +       struct ofono_modem *modem =3D user_data;
> +       struct he910_data *data =3D ofono_modem_get_data(modem);
> +
> +       DBG("%p", modem);
> +
> +       if (!ok) {
> +               g_at_chat_unref(data->chat);
> +               data->chat =3D NULL;
> +
> +               g_at_chat_unref(data->modem);
> +               data->modem =3D NULL;
> +
> +               ofono_modem_set_powered(modem, FALSE);
> +               return;
> +       }
> +
> +       DBG("Wait for AT+CFUN=3D4 command completion");
> +       usleep(TELIT_CFUN_DELAY);
> +
> +       /* Set phone functionality */
> +       g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
> +                               cfun_enable_cb, modem, NULL);
> +}
> +
>   static int he910_enable(struct ofono_modem *modem)
>   {
>          struct he910_data *data =3D ofono_modem_get_data(modem);
> @@ -268,9 +288,11 @@ static int he910_enable(struct ofono_modem *modem)
>          g_at_chat_send(data->chat, "ATE0 +CMEE=3D1", none_prefix,
>                                  NULL, NULL, NULL);
>
> -       /* Set phone functionality */
> -       g_at_chat_send(data->chat, "AT+CFUN=3D1", none_prefix,
> -                               cfun_enable_cb, modem, NULL);
> +       /* Set QSS notifications before restarting the SIM */
> +       g_at_chat_send(data->chat, "AT#QSS=3D2", none_prefix,     NULL,
> modem, NULL);
> +
> +       /* Power off module to get alla notifications on startup */
> +       g_at_chat_send(data->chat, "AT+CFUN=3D4", none_prefix,
> cfun_delay_cb, modem, NULL);
>

On older Telit firmware, CFUN=3D4 turns the SIM off.  If you have such =

firmware, I suggest upgrading it.  Otherwise the modem will not work as =

oFono expects it to.

This change should not be required with latest firmware.

>          return -EINPROGRESS;
>   }
> @@ -333,7 +355,7 @@ static void he910_post_online(struct ofono_modem *mod=
em)
>
>          ofono_voicecall_create(modem, 0, "atmodem", data->chat);
>          ofono_netreg_create(modem, OFONO_VENDOR_TELIT, "atmodem",
> data->chat);
> -       ofono_ussd_create(modem, 0, "atmodem", data->chat);
> +       ofono_ussd_create(modem, OFONO_VENDOR_TELIT, "atmodem", data->cha=
t);
>          ofono_call_forwarding_create(modem, 0, "atmodem", data->chat);
>          ofono_call_settings_create(modem, 0, "atmodem", data->chat);
>          ofono_call_meter_create(modem, 0, "atmodem", data->chat);
> @@ -349,6 +371,8 @@ static void he910_post_online(struct ofono_modem *mod=
em)
>
>          if (gprs && gc)
>                  ofono_gprs_add_context(gprs, gc);
> +       g_at_chat_send(data->chat, "AT#AUTOATT=3D1", none_prefix,
> +                               NULL, NULL, NULL);
>   }
>
>   static int he910_probe(struct ofono_modem *modem)
> diff --git a/src/sim.c b/src/sim.c
> index b5badf1..65e5c32 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -801,6 +801,29 @@ static DBusMessage *sim_change_pin(DBusConnection
> *conn, DBusMessage *msg,
>          return NULL;
>   }
>
> +static void sim_iccid_read_cb(int ok, int length, int record,
> +                               const unsigned char *data,
> +                               int record_length, void *userdata)
> +{
> +       struct ofono_sim *sim =3D userdata;
> +       const char *path =3D __ofono_atom_get_path(sim->atom);
> +       DBusConnection *conn =3D ofono_dbus_get_connection();
> +       char iccid[21]; /* ICCID max length is 20 + 1 for NULL */
> +
> +       if (!ok || length < 10)
> +               return;
> +
> +       extract_bcd_number(data, length, iccid);
> +       iccid[20] =3D '\0';
> +       sim->iccid =3D g_strdup(iccid);
> +
> +       ofono_dbus_signal_property_changed(conn, path,
> +                                               OFONO_SIM_MANAGER_INTERFA=
CE,
> +                                               "CardIdentifier",
> +                                               DBUS_TYPE_STRING,
> +                                               &sim->iccid);
> +}
> +
>   static void sim_enter_pin_cb(const struct ofono_error *error, void *dat=
a)
>   {
>          struct ofono_sim *sim =3D data;
> @@ -813,6 +836,11 @@ static void sim_enter_pin_cb(const struct
> ofono_error *error, void *data)
>
>          __ofono_dbus_pending_reply(&sim->pending, reply);
>
> +       if (!sim->iccid)
> +               ofono_sim_read(sim->early_context, SIM_EF_ICCID_FILEID,
> +
>   OFONO_SIM_FILE_STRUCTURE_TRANSPARENT,
> +                                          sim_iccid_read_cb, sim);
> +
>          __ofono_sim_recheck_pin(sim);
>   }
>
> @@ -2045,29 +2073,6 @@ skip_efpl:
>          sim->language_prefs_update =3D FALSE;
>   }
>
> -static void sim_iccid_read_cb(int ok, int length, int record,
> -                               const unsigned char *data,
> -                               int record_length, void *userdata)
> -{
> -       struct ofono_sim *sim =3D userdata;
> -       const char *path =3D __ofono_atom_get_path(sim->atom);
> -       DBusConnection *conn =3D ofono_dbus_get_connection();
> -       char iccid[21]; /* ICCID max length is 20 + 1 for NULL */
> -
> -       if (!ok || length < 10)
> -               return;
> -
> -       extract_bcd_number(data, length, iccid);
> -       iccid[20] =3D '\0';
> -       sim->iccid =3D g_strdup(iccid);
> -
> -       ofono_dbus_signal_property_changed(conn, path,
> -                                               OFONO_SIM_MANAGER_INTERFA=
CE,
> -                                               "CardIdentifier",
> -                                               DBUS_TYPE_STRING,
> -                                               &sim->iccid);
> -}
> -
>   static void sim_iccid_changed(int id, void *userdata)
>   {
>          struct ofono_sim *sim =3D userdata;
>
>

ICCid changes should be in a separate patch.  I'm not sure they are =

still required with new firmware.

Regards,
-Denis

--===============6911467915408716092==--

