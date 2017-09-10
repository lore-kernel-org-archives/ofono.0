Content-Type: multipart/mixed; boundary="===============8958296819143534972=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] gobi: enable message waiting atom
Date: Sun, 10 Sep 2017 12:59:25 -0500
Message-ID: <2dcbb720-fb26-d32d-f2c7-79c1a9dac91b@gmail.com>
In-Reply-To: <20170910063614.E819A642AA@rivendell.scintill.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8958296819143534972==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Joey,

> Now that I understand more that the legacy SIM will probably never be
> able to write SIM files, should the message waiting atom be
> "half-functional" if it's legacy, or not enabled at all?
> =


Does DMS provide support to twiddle the EFmwis/EFmwi/EFmbdn by some =

other means?  From what I remember it doesn't, but may be I'm not =

remembering correctly.

If not, then we shouldn't enable message-waiting in that case.

>   plugins/gobi.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> =

> diff --git a/plugins/gobi.c b/plugins/gobi.c
> index a498599..3205307 100644
> --- a/plugins/gobi.c
> +++ b/plugins/gobi.c
> @@ -481,8 +481,12 @@ static void gobi_post_sim(struct ofono_modem *modem)
>   	if (data->features & GOBI_NAS)
>   		ofono_radio_settings_create(modem, 0, "qmimodem", data->device);
>   =

> -	if (data->features & GOBI_WMS)
> +	if (data->features & GOBI_WMS) {

And maybe this needs a separate block based on the discussion above.  E.g.

if ((data->features & GOBI_WMS) && (data->features & GOBI_UIM))

>   		ofono_sms_create(modem, 0, "qmimodem", data->device);
> +		struct ofono_message_waiting *mw =3D ofono_message_waiting_create(mode=
m);

We use a strict set of flags, so this make gcc complain about mixed =

declarations and code.  So this should be

struct ofono_message_waiting *...

ofono_sms_create

if (mw)
	ofono_message_waiting_register(mw);

> +		if (mw)
> +			ofono_message_waiting_register(mw);
> +	}
>   }
>   =

>   static void gobi_post_online(struct ofono_modem *modem)
> =


Regards,
-Denis

--===============8958296819143534972==--

