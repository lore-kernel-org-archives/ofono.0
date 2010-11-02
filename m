Content-Type: multipart/mixed; boundary="===============5098489225914115422=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: Check SIM pin status after changing pin.
Date: Tue, 02 Nov 2010 10:22:46 -0500
Message-ID: <4CD02CC6.30201@gmail.com>
In-Reply-To: <1288710522-10153-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5098489225914115422==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marit,

On 11/02/2010 10:08 AM, Marit Henriksen wrote:
> From: Marit Henriksen <marit.henriksen@stericsson.com>
> =

> When changing pin, it is possible to get in a state where the modem reque=
sts puk =

> (if incorrect pin is entered too many times). Need to check the SIM pin s=
tatus =

> to discover this.
> ---
>  src/sim.c |   15 ++++++++-------
>  1 files changed, 8 insertions(+), 7 deletions(-)
> =

> diff --git a/src/sim.c b/src/sim.c
> index 699ebe9..b2277c5 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -628,15 +628,16 @@ static DBusMessage *sim_unlock_pin(DBusConnection *=
conn, DBusMessage *msg,
>  static void sim_change_pin_cb(const struct ofono_error *error, void *dat=
a)
>  {
>  	struct ofono_sim *sim =3D data;
> +	DBusMessage *reply;
>  =

> -	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR) {
> -		__ofono_dbus_pending_reply(&sim->pending,
> -				__ofono_error_failed(sim->pending));
> -		return;
> -	}
> +	if (error->type !=3D OFONO_ERROR_TYPE_NO_ERROR)
> +		reply =3D __ofono_error_failed(sim->pending);
> +	else
> +		reply =3D dbus_message_new_method_return(sim->pending);
>  =

> -	__ofono_dbus_pending_reply(&sim->pending,
> -				dbus_message_new_method_return(sim->pending));
> +	__ofono_dbus_pending_reply(&sim->pending, reply);
> +
> +	sim_pin_check(sim);

I don't think that running sim_pin_check is such a good idea.  That
function initializes the sim interface when +CPIN returns READY.

You also need to tear down the modem state back to pre-sim if the modem
asks for a PUK after change pin fails.  That entails removing all
post_sim/post_online atoms and bring the modem back to the offline state ;)

>  }
>  =

>  static DBusMessage *sim_change_pin(DBusConnection *conn, DBusMessage *ms=
g,

Regards,
-Denis

--===============5098489225914115422==--

