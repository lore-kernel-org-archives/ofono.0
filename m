Content-Type: multipart/mixed; boundary="===============5833561748276534433=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v3 2/7] plugins/ste: SIM - STE registers as MBM to utilize
 mbm quirks.
Date: Mon, 16 Aug 2010 22:45:43 +0200
Message-ID: <1281991543.23399.43.camel@localhost.localdomain>
In-Reply-To: <1281990950-21705-2-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5833561748276534433==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> >do we really wanna create another vendor quirk here. If both modems
> >behave identical then just pass OFONO_VENDOR_MBM in the SIM atom
> >registration and be done with it.
> =

> Re-use the MBM quirk rather than adding STE quirks in atmodem/sim.c
> =

> ---
>  plugins/ste.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> =

> diff --git a/plugins/ste.c b/plugins/ste.c
> index 9cb49d3..9d9afd6 100644
> --- a/plugins/ste.c
> +++ b/plugins/ste.c
> @@ -214,7 +214,7 @@ static void ste_pre_sim(struct ofono_modem *modem)
>  =

>  	ofono_devinfo_create(modem, 0, "atmodem", data->chat);
>  	sim =3D ofono_sim_create(modem, 0, "atmodem", data->chat);
> -	ofono_voicecall_create(modem, 0, "stemodem", data->chat);
> +	ofono_voicecall_create(modem, OFONO_VENDOR_MBM, "stemodem", data->chat);

this looks wrong. You are using a STE specific modem driver already. Why
do you need to pass a quirk here as well.

Did I confuse you with one of my other replies or did I confuse myself
here in the review?

Regards

Marcel



--===============5833561748276534433==--

