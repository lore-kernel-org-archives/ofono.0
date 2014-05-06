Content-Type: multipart/mixed; boundary="===============6102919694929366104=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] sim: Handle multiple invocations of sim_imsi_obtained
Date: Tue, 06 May 2014 08:38:50 -0500
Message-ID: <5368E5EA.8070409@gmail.com>
In-Reply-To: <1399377281-3896-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6102919694929366104==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 05/06/2014 06:54 AM, Slava Monich wrote:
> To avoid leaking memory and issuing unnecessary D-Bus signals
> ---
>  src/sim.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> =

> diff --git a/src/sim.c b/src/sim.c
> index edae5eb..1b0cb80 100644
> --- a/src/sim.c
> +++ b/src/sim.c
> @@ -1425,11 +1425,18 @@ static void sim_set_ready(struct ofono_sim *sim)
>  =

>  static void sim_imsi_obtained(struct ofono_sim *sim, const char *imsi)
>  {
> -	DBusConnection *conn =3D ofono_dbus_get_connection();
> -	const char *path =3D __ofono_atom_get_path(sim->atom);
> +	DBusConnection *conn;
> +	const char *path;
> +
> +	if (sim->imsi && !strcmp(sim->imsi, imsi))
> +		return;

Calling this function a second time is an error.  So this condition
looks highly suspect.  What issue are you trying to address?

>  =

> +	DBG("%s", imsi);
> +	g_free(sim->imsi);
>  	sim->imsi =3D g_strdup(imsi);
>  =

> +	conn =3D ofono_dbus_get_connection();
> +	path =3D __ofono_atom_get_path(sim->atom);
>  	ofono_dbus_signal_property_changed(conn, path,
>  						OFONO_SIM_MANAGER_INTERFACE,
>  						"SubscriberIdentity",
> =


Regards,
-Denis

--===============6102919694929366104==--

