Content-Type: multipart/mixed; boundary="===============9046172815068320240=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/3] mbm: fix initial polling for sim
Date: Thu, 19 Aug 2010 10:41:44 +0200
Message-ID: <1282207304.23399.162.camel@localhost.localdomain>
In-Reply-To: <1282207087-16257-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9046172815068320240==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> There seems to be no specific error codes returned when SIM is missing. P=
oll
> at least 5 times upon an error and give up after that.
> ---
>  plugins/mbm.c |    8 +++-----
>  1 files changed, 3 insertions(+), 5 deletions(-)
> =

> diff --git a/plugins/mbm.c b/plugins/mbm.c
> index 6f71553..bebf5aa 100644
> --- a/plugins/mbm.c
> +++ b/plugins/mbm.c
> @@ -108,10 +108,8 @@ static void simpin_check(gboolean ok, GAtResult *res=
ult, gpointer user_data)
>  =

>  	DBG("");
>  =

> -	/* Modem returns +CME ERROR: 10 if SIM is not ready. */
> -	if (!ok && result->final_or_pdu &&
> -			!strcmp(result->final_or_pdu, "+CME ERROR: 10") &&
> -			data->cpin_poll_count++ < 5) {
> +	/* Modem returns an error if SIM is not ready. */
> +	if (!ok && data->cpin_poll_count++ < 5) {
>  		data->cpin_poll_source =3D
>  			g_timeout_add_seconds(1, init_simpin_check, modem);

maybe the STE modem is a bit more specific here than the MBM one. Which
MBM modem did you test this with?

Regards

Marcel



--===============9046172815068320240==--

