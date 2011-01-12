Content-Type: multipart/mixed; boundary="===============3789144125907406848=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: check if lock is locked after code changing attempt
Date: Tue, 11 Jan 2011 23:07:46 -0600
Message-ID: <4D2D3722.6030803@gmail.com>
In-Reply-To: <20A4FB08D632914F9C09B9F05CBDF258192D753024@EXMB02.eu.tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3789144125907406848==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jussi,

On 01/11/2011 06:17 AM, Jussi.Kangas(a)tieto.com wrote:
> Hi,
> =

> This is fix to Marit Henriksen's TODO item "Check SIM pin status if sim_c=
hange_pin fails". I've discussed with Marit and it's ok for her if I fix th=
e issue. Problem here is that issue could perhaps also be fixed with retry =
counter solution introduced by Lucas De Marchi couple of tasks ago. That wo=
uld seem however require some extra implementation in ste modem ( at least =
I was not able get the ofono show correct values without extra modification=
s ) and I think that isimodems don't have that sort of retry counter at all=
. Because of that and since I had this solution already implemented I propo=
se it to be added as well. =

> =

> Br,
> -Jussi
> =

> ---
>  src/sim.c |   54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 54 insertions(+), 0 deletions(-)
> =


First, please fix your authorship information.  See the AUTHORS file to
see what we expect.  Also, please make sure that you're using tabs for
indentation and following the relevant coding style.  See the Submitting
Patches section in the HACKING document in oFono git as well as
doc/coding-style.txt.

> diff --git a/src/sim.c b/src/sim.c
> index d627647..789ddde 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -712,8 +712,60 @@ static DBusMessage *sim_unlock_pin(DBusConnection *c=
onn, DBusMessage *msg,
>  static void sim_change_pin_cb(const struct ofono_error *error, void *dat=
a)
>  {

So my first concern is that whatever you do here also has to work for
LockPin and UnlockPin.

>      struct ofono_sim *sim =3D data;
> +    DBusConnection *conn =3D ofono_dbus_get_connection();
> +    const char *path =3D __ofono_atom_get_path(sim->atom);
> +    struct ofono_modem *modem =3D __ofono_atom_get_modem(sim->atom);
> +    const char *pin_name;
>  =

>      if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> +        if (error->error =3D=3D 12) {
> +            sim->locked_pins[sim->pin_type] =3D TRUE;
> +            switch (sim->pin_type) {
> +            case OFONO_SIM_PASSWORD_SIM_PIN:
> +                sim->pin_type =3D OFONO_SIM_PASSWORD_SIM_PUK;
> +                pin_name =3D sim_passwd_name(
> +                    OFONO_SIM_PASSWORD_SIM_PUK);
> +                break;
> +            case OFONO_SIM_PASSWORD_PHFSIM_PIN:
> +                sim->pin_type =3D OFONO_SIM_PASSWORD_PHFSIM_PUK;
> +                pin_name =3D sim_passwd_name(
> +                    OFONO_SIM_PASSWORD_PHFSIM_PUK);
> +                break;
> +            case OFONO_SIM_PASSWORD_PHCORP_PIN:
> +                sim->pin_type =3D OFONO_SIM_PASSWORD_PHCORP_PUK;
> +                pin_name =3D sim_passwd_name(
> +                    OFONO_SIM_PASSWORD_PHCORP_PUK);
> +                break;
> +            case OFONO_SIM_PASSWORD_PHNET_PIN:
> +                sim->pin_type =3D OFONO_SIM_PASSWORD_PHNET_PUK;
> +                pin_name =3D sim_passwd_name(
> +                        OFONO_SIM_PASSWORD_PHNET_PUK);
> +            case OFONO_SIM_PASSWORD_PHNETSUB_PIN:
> +                sim->pin_type =3D OFONO_SIM_PASSWORD_PHNETSUB_PUK;
> +                pin_name =3D sim_passwd_name(
> +                    OFONO_SIM_PASSWORD_PHNETSUB_PUK);
> +                break;
> +            case OFONO_SIM_PASSWORD_PHSP_PIN:
> +                sim->pin_type =3D OFONO_SIM_PASSWORD_PHSP_PUK;
> +                pin_name =3D sim_passwd_name(
> +                    OFONO_SIM_PASSWORD_PHSP_PUK);
> +                break;
> +            case OFONO_SIM_PASSWORD_SIM_PIN2:
> +                sim->pin_type =3D OFONO_SIM_PASSWORD_SIM_PUK2;
> +                pin_name =3D sim_passwd_name(
> +                    OFONO_SIM_PASSWORD_SIM_PUK2);
> +                break;
> +            default:
> +                break;
> +            }
> +            ofono_dbus_signal_property_changed(conn, path,
> +                OFONO_SIM_MANAGER_INTERFACE,
> +                "PinRequired", DBUS_TYPE_STRING,
> +                &pin_name);

Have you considered querying the PIN state on a failure instead?  If the
lock/unlock/change pin operation fails, then re-query the current PIN.
If the CPIN is no longer returning READY and we're in a state
OFONO_SIM_STATE_READY, then tear us back down to an earlier state.

> +
> +            if (sim->pin_type !=3D OFONO_SIM_PASSWORD_SIM_PUK2)

What is the reason for excepting PUK2 here?  Should we be also
proceeding to the SIM_READY state on SIM initialization if PUK2 is
required as well?

> +                ofono_modem_reset(modem);
> +        }

This seems a bit drastic, but fair enough...

>          __ofono_dbus_pending_reply(&sim->pending,
>                  __ofono_error_failed(sim->pending));
>  =

> @@ -722,6 +774,7 @@ static void sim_change_pin_cb(const struct ofono_erro=
r *error, void *data)
>          return;
>      }
>  =

> +    sim->pin_type =3D OFONO_SIM_PASSWORD_NONE;
>      __ofono_dbus_pending_reply(&sim->pending,
>                  dbus_message_new_method_return(sim->pending));
>  =

> @@ -764,6 +817,7 @@ static DBusMessage *sim_change_pin(DBusConnection *co=
nn, DBusMessage *msg,
>          return dbus_message_new_method_return(msg);
>  =

>      sim->pending =3D dbus_message_ref(msg);
> +    sim->pin_type =3D type;
>      sim->driver->change_passwd(sim, type, old, new,
>                      sim_change_pin_cb, sim);
>  =


Regards,
-Denis

--===============3789144125907406848==--

