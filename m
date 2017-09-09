Content-Type: multipart/mixed; boundary="===============3154640993086373151=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] qmimodem: enable message waiting atom
Date: Sat, 09 Sep 2017 10:18:26 -0500
Message-ID: <82c346f5-ac9c-3260-fb42-b751e63ce8dd@gmail.com>
In-Reply-To: <20170909021949.1FCD060F2C@rivendell.scintill.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3154640993086373151==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Joey,

On 09/08/2017 08:26 PM, Joey Hewitt wrote:
> Conditional on one of UIM (SIM), DMS (legacy SIM), or WMS (SMS).
> ---
> =

> Tested on my Android phone. It correctly reported
> VoicemailMailboxNumber, and VoicemailWaiting property when a voicemail
> was sent. I got an error "Queuing a EF-MWI write to SIM failed", though
> -- I'm not sure if that's a bug somewhere in the stack, or if that's
> just how my SIM is.

Neither QMI SIM driver supports SIM writes (e.g. write_file_transparent, =

write_file_linear, write_file_cyclic).  Without those, the =

message-waiting atom is only half functional...

> =

>   plugins/gobi.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> =

> diff --git a/plugins/gobi.c b/plugins/gobi.c
> index a498599..0bc134f 100644
> --- a/plugins/gobi.c
> +++ b/plugins/gobi.c
> @@ -490,6 +490,7 @@ static void gobi_post_online(struct ofono_modem *mode=
m)
>   	struct gobi_data *data =3D ofono_modem_get_data(modem);
>   	struct ofono_gprs *gprs;
>   	struct ofono_gprs_context *gc;
> +	struct ofono_message_waiting *mw;

Variable declaration can be moved into the if statement.

>   =

>   	DBG("%p", modem);
>   =

> @@ -499,6 +500,12 @@ static void gobi_post_online(struct ofono_modem *mod=
em)
>   	if (data->features & GOBI_VOICE)
>   		ofono_ussd_create(modem, 0, "qmimodem", data->device);
>   =

> +	if (data->features & (GOBI_UIM | GOBI_DMS | GOBI_WMS)) {

And strictly speaking the check should be for
(data->features & (GOBI_UIM | GOBI_DMS)) && (data->features & GOBI_WMS))

However, since we got to post_sim/post_online somehow (e.g. presence of =

one of these services is implied), I'd just simply use

if (data->features & GOBI_WMS)

> +		mw =3D ofono_message_waiting_create(modem);
> +		if (mw)
> +			ofono_message_waiting_register(mw);
> +	}
> +

This should really go into post_sim

>   	if (data->features & GOBI_WDS) {
>   		gprs =3D ofono_gprs_create(modem, 0, "qmimodem", data->device);
>   		gc =3D ofono_gprs_context_create(modem, 0, "qmimodem",
> =


Regards,
-Denis

--===============3154640993086373151==--

