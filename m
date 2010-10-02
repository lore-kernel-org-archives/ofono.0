Content-Type: multipart/mixed; boundary="===============4766492234846254033=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [RFC PATCH 3/4] modem: some debugs added for indicating modem
 state change
Date: Sat, 02 Oct 2010 08:09:58 +0200
Message-ID: <1285999798.4231.23.camel@aeonflux>
In-Reply-To: <1285949201-2994-4-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4766492234846254033==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

>  src/modem.c |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> =

> diff --git a/src/modem.c b/src/modem.c
> index f6ed1ab..e90f4dc 100644
> --- a/src/modem.c
> +++ b/src/modem.c
> @@ -380,20 +380,25 @@ static void modem_change_state(struct ofono_modem *=
modem,
>  =

>  	modem->modem_state =3D new_state;
>  =

> -	if (old_state > new_state)
> +	if (old_state > new_state) {
> +		DBG("flush atoms");
>  		flush_atoms(modem, new_state);
> +	}

just adding a DBG("") in flush_atoms() at the top would be a bit better
here.
 =

>  	switch (new_state) {
>  	case MODEM_STATE_POWER_OFF:
> +		DBG("MODEM_STATE_POWER_OFF");
>  		modem->call_ids =3D 0;
>  		break;
>  =

>  	case MODEM_STATE_PRE_SIM:
> +		DBG("MODEM_STATE_PRE_SIM");
>  		if (old_state < MODEM_STATE_PRE_SIM && driver->pre_sim)
>  			driver->pre_sim(modem);
>  		break;
>  =

>  	case MODEM_STATE_OFFLINE:
> +		DBG("MODEM_STATE_OFFLINE");
>  		if (old_state < MODEM_STATE_OFFLINE) {
>  			if (driver->post_sim)
>  				driver->post_sim(modem);
> @@ -403,6 +408,7 @@ static void modem_change_state(struct ofono_modem *mo=
dem,
>  		break;
>  =

>  	case MODEM_STATE_ONLINE:
> +		DBG("MODEM_STATE_ONLINE");
>  		if (driver->post_online)
>  			driver->post_online(modem);
>  		break;

I would prefer if we just add a DBG() at the top of modem_change_state
function that indicates the previous and the new state. And you can just
to start as integer value. No need for the string here. They are 4
states only anyway.

Regards

Marcel



--===============4766492234846254033==--

