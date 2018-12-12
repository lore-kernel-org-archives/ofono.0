Content-Type: multipart/mixed; boundary="===============4875315240648414573=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH] sim: Sim PIN1 cache upon modem reset/crash
Date: Wed, 12 Dec 2018 08:59:34 +0100
Message-ID: <CAKSBH7H78T8yGOu5w1cch-iSt7J7f6cy28FTFdzOzngMJ3Ldvw@mail.gmail.com>
In-Reply-To: <1544597376-27147-1-git-send-email-nandini.rebello@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4875315240648414573==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

No, absolutely not!
It is forbidden to do this by the 3GPP!

On Wed, Dec 12, 2018 at 7:46 AM Nandini Rebello
<nandini.rebello@intel.com> wrote:
>
> Adding SIM PIN caching feature to oFono. oFono now caches the SIM PIN1 ty=
pe
> against the ICCID throughout its lifetime in a link list and enters
> implicitly upon modem reset/crash.
>
> Handles cases of incorrect pin and sim pin changed externally.
>
> Adding to all modems by default.
> ---
>  src/sim.c | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 114 insertions(+)
>
> diff --git a/src/sim.c b/src/sim.c
> index 129ff5d..28d9a00 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -141,6 +141,11 @@ struct ofono_sim {
>         bool wait_initialized : 1;
>  };
>
> +struct cached_pin {
> +       char *id;
> +       char *pin;
> +};
> +
>  struct msisdn_set_request {
>         struct ofono_sim *sim;
>         int pending;
> @@ -176,6 +181,8 @@ static void sim_own_numbers_update(struct ofono_sim *=
sim);
>
>  static GSList *g_drivers =3D NULL;
>
> +static GSList *cached_pins =3D NULL;
> +
>  static const char *sim_passwd_name(enum ofono_sim_password_type type)
>  {
>         return passwd_name[type];
> @@ -473,6 +480,75 @@ done:
>         return reply;
>  }
>
> +static struct cached_pin *pin_cache_lookup(const char *iccid)
> +{
> +       struct cached_pin *c;
> +       GSList *l;
> +
> +       for (l =3D cached_pins; l; l =3D l->next) {
> +               c =3D l->data;
> +
> +               if (g_strcmp0(iccid, c->id) =3D=3D 0)
> +                       return c;
> +       }
> +
> +       return NULL;
> +}
> +
> +static gboolean pin_cache_update(const char *iccid, const char *pin)
> +{
> +       struct cached_pin *pin_cached =3D pin_cache_lookup(iccid);
> +       struct cached_pin *cpins;
> +
> +       if (pin_cached !=3D NULL) {
> +               g_free(pin_cached->pin);
> +               pin_cached->pin =3D g_strdup(pin);
> +               return TRUE;
> +       }
> +
> +       cpins =3D g_new0(struct cached_pin, 1);
> +
> +       if (cpins =3D=3D NULL)
> +               return FALSE;
> +
> +       cpins->id =3D g_strdup(iccid);
> +       cpins->pin =3D g_strdup(pin);
> +       cached_pins =3D g_slist_prepend(cached_pins, cpins);
> +
> +       return TRUE;
> +}
> +
> +static void pin_cache_remove(const char *iccid)
> +{
> +       struct cached_pin *pin_cached =3D pin_cache_lookup(iccid);
> +
> +       if (pin_cached =3D=3D NULL)
> +               return;
> +
> +       cached_pins =3D g_slist_remove(cached_pins, pin_cached);
> +}
> +
> +static void pin_cache_enter_cb(const struct ofono_error *error, void *da=
ta)
> +{
> +       struct ofono_sim *sim =3D data;
> +
> +       /* If PIN entry fails, then remove cached PIN*/
> +       if (sim->initialized || error->type !=3D OFONO_ERROR_TYPE_NO_ERRO=
R) {
> +               pin_cache_remove(sim->iccid);
> +               goto recheck;
> +       }
> +
> +       if (sim->pin_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN ||
> +                       sim->pin_type =3D=3D OFONO_SIM_PASSWORD_SIM_PUK) {
> +               sim->wait_initialized =3D true;
> +               DBG("Waiting for ofono_sim_initialized_notify");
> +               return;
> +       }
> +
> +recheck:
> +       __ofono_sim_recheck_pin(sim);
> +}
> +
>  static void sim_pin_retries_query_cb(const struct ofono_error *error,
>                                         int retries[OFONO_SIM_PASSWORD_IN=
VALID],
>                                         void *data)
> @@ -681,6 +757,13 @@ static void sim_locked_cb(struct ofono_sim *sim, gbo=
olean locked)
>                                                 OFONO_SIM_MANAGER_INTERFA=
CE,
>                                                 "LockedPins", DBUS_TYPE_S=
TRING,
>                                                 &locked_pins);
> +
> +       /*Cache pin only for SIM PIN type*/
> +       if (g_strcmp0(typestr, "pin") =3D=3D 0) {
> +               if (!pin_cache_update(sim->iccid, pin))
> +                       ofono_error("Failed to cache PIN.");
> +       }
> +
>         g_strfreev(locked_pins);
>
>         sim_pin_retries_check(sim);
> @@ -776,6 +859,14 @@ static DBusMessage *sim_unlock_pin(DBusConnection *c=
onn, DBusMessage *msg,
>  static void sim_change_pin_cb(const struct ofono_error *error, void *dat=
a)
>  {
>         struct ofono_sim *sim =3D data;
> +       const char *typestr;
> +       const char *old;
> +       const char *new;
> +
> +       dbus_message_get_args(sim->pending, NULL, DBUS_TYPE_STRING, &type=
str,
> +                                            DBUS_TYPE_STRING, &old,
> +                                            DBUS_TYPE_STRING, &new,
> +                                            DBUS_TYPE_INVALID);
>
>         if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
>                 __ofono_dbus_pending_reply(&sim->pending,
> @@ -786,6 +877,12 @@ static void sim_change_pin_cb(const struct ofono_err=
or *error, void *data)
>                 return;
>         }
>
> +       /*Cache pin only for SIM PIN type*/
> +       if (g_strcmp0(typestr, "pin") =3D=3D 0) {
> +               if (!pin_cache_update(sim->iccid, new))
> +                       ofono_error("Failed to cache PIN.");
> +       }
> +
>         __ofono_dbus_pending_reply(&sim->pending,
>                                 dbus_message_new_method_return(sim->pendi=
ng));
>
> @@ -837,8 +934,14 @@ static DBusMessage *sim_change_pin(DBusConnection *c=
onn, DBusMessage *msg,
>  static void sim_enter_pin_cb(const struct ofono_error *error, void *data)
>  {
>         struct ofono_sim *sim =3D data;
> +       const char *typestr;
> +       const char *pin;
>         DBusMessage *reply;
>
> +       dbus_message_get_args(sim->pending, NULL, DBUS_TYPE_STRING, &type=
str,
> +                                            DBUS_TYPE_STRING, &pin,
> +                                            DBUS_TYPE_INVALID);
> +
>         if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
>                 reply =3D __ofono_error_failed(sim->pending);
>         else
> @@ -850,6 +953,12 @@ static void sim_enter_pin_cb(const struct ofono_erro=
r *error, void *data)
>         if (sim->initialized || error->type !=3D OFONO_ERROR_TYPE_NO_ERRO=
R)
>                 goto recheck;
>
> +       /*Cache pin only for SIM PIN type*/
> +       if (g_strcmp0(typestr, "pin") =3D=3D 0) {
> +               if (!pin_cache_update(sim->iccid, pin))
> +                       ofono_error("Failed to cache PIN.");
> +       }
> +
>         if (sim->pin_type =3D=3D OFONO_SIM_PASSWORD_SIM_PIN ||
>                         sim->pin_type =3D=3D OFONO_SIM_PASSWORD_SIM_PUK) {
>                 sim->wait_initialized =3D true;
> @@ -3023,6 +3132,7 @@ static void sim_pin_query_cb(const struct ofono_err=
or *error,
>         struct ofono_sim *sim =3D data;
>         DBusConnection *conn =3D ofono_dbus_get_connection();
>         const char *path =3D __ofono_atom_get_path(sim->atom);
> +       struct cached_pin *cpins =3D pin_cache_lookup(sim->iccid);
>         const char *pin_name;
>         char **locked_pins;
>         gboolean lock_changed;
> @@ -3067,6 +3177,10 @@ static void sim_pin_query_cb(const struct ofono_er=
ror *error,
>                                                 &pin_name);
>         }
>
> +       if (g_strcmp0(pin_name, "pin") =3D=3D 0 && cpins !=3D NULL)
> +               sim->driver->send_passwd(sim, cpins->pin,
> +                                              pin_cache_enter_cb, sim);
> +
>         switch (pin_type) {
>         case OFONO_SIM_PASSWORD_NONE:
>         case OFONO_SIM_PASSWORD_SIM_PIN2:
> --
> 2.7.4
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

--===============4875315240648414573==--

