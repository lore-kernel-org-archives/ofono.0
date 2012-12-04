Content-Type: multipart/mixed; boundary="===============1449657766114171811=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/1] telit: stay 'online' until POST_SIM state reached
Date: Tue, 04 Dec 2012 17:47:38 +0100
Message-ID: <1354639658.1837.14.camel@aeonflux>
In-Reply-To: <1354636010-9624-1-git-send-email-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1449657766114171811==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

> In offline state where CFUN=3D4, the Telit HE910 also powers down the SIM
> card so AT commands that query the SIM will fail.  These failures result
> in ofono not getting to POST_SIM state where it will export the GPRS
> feature.
> =

> This patch changes the Telit driver so it will not go immediately
> to CFUN=3D4 after enable, but to wait for the post_sim state to be
> reached before doing so.  In addition, the HE910 might send QSS: 0
> unsolicited reports while in CFUN=3D4 state... this patch makes it so
> that these are ignored until the modem is onlined and the actual
> SIM state can be queried again.
> ---
> =

> This patch has been tested with a Telit HE910 and it works fine there.  It
> would be great if someone with other Telit modems could check if
> this works with those models or whether we need to wrap some of this with
> checks for model type, firmware version, etc...
> =

> Thanks,
> Jonas
> =

> =

>  plugins/telit.c |   64 +++++++++++++++++++++++++++++++++++++++++++++++++=
++----
>  1 file changed, 60 insertions(+), 4 deletions(-)
> =

> diff --git a/plugins/telit.c b/plugins/telit.c
> index fe2ccd6..a0f7deb 100644
> --- a/plugins/telit.c
> +++ b/plugins/telit.c
> @@ -62,6 +62,7 @@
>  =

>  static const char *none_prefix[] =3D { NULL };
>  static const char *rsen_prefix[]=3D { "#RSEN:", NULL };
> +static const char *qss_prefix[] =3D { "#QSS:", NULL };
>  =

>  struct telit_data {
>  	GAtChat *chat;		/* AT chat */
> @@ -219,7 +220,7 @@ static void switch_sim_state_status(struct ofono_mode=
m *modem, int status)
>  =

>  	switch (status) {
>  	case 0:	/* SIM not inserted */
> -		if (data->have_sim =3D=3D TRUE) {
> +		if (data->have_sim =3D=3D TRUE && ofono_modem_get_online(modem)) {
>  			ofono_sim_inserted_notify(data->sim, FALSE);
>  			data->have_sim =3D FALSE;
>  			data->sms_phonebook_added =3D FALSE;
> @@ -233,6 +234,14 @@ static void switch_sim_state_status(struct ofono_mod=
em *modem, int status)
>  		}
>  		break;
>  	case 3:	/* SIM inserted, SMS and phonebook ready */
> +		/* It's possible that we arrive at QSS=3D3 state without
> +		 * ever seeing QSS=3D2, so we need to make sure that we've
> +		 * also done the QSS=3D2 work, as well
> +		 */
> +		if (data->have_sim =3D=3D FALSE) {
> +			ofono_sim_inserted_notify(data->sim, TRUE);
> +			data->have_sim =3D TRUE;
> +		}
>  		if (data->sms_phonebook_added =3D=3D FALSE) {
>  			ofono_phonebook_create(modem, 0, "atmodem", data->chat);
>  			ofono_sms_create(modem, 0, "atmodem", data->chat);

I don't remember how this made it upstream. The SMS and Phonebook atom
drivers should have vendor quirks to not register until the SIM is fully
ready. We do that for IFX for Phonebook and I was going to add another
one for IFX and SMS handling. Telit should do the same.

I am surprised adding atoms outside of pre_sim, post_sim and post_online
works as it should. Since that clearly has never been fully tested. And
is not our recommended way of adding atoms.

Regards

Marcel



--===============1449657766114171811==--

