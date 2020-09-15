Content-Type: multipart/mixed; boundary="===============7904663017108156666=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] droid 4: special handling for SMSes
Date: Tue, 15 Sep 2020 10:24:26 -0500
Message-ID: <5f2e0d67-a262-e886-6c8a-8336e68fd29c@gmail.com>
In-Reply-To: <20200915132313.GA13286@duo.ucw.cz>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7904663017108156666==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

On 9/15/20 8:23 AM, Pavel Machek wrote:
> Droid 4	 modem is "special" (aka broken) so and getting incoming SMSes
> to work is quite tricky. This should get it right.
> ---
>   drivers/atmodem/sms.c | 15 ++++++++++++---
>   1 file changed, 12 insertions(+), 3 deletions(-)
> =

> diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
> index d502da72..f08f2fb1 100644
> --- a/drivers/atmodem/sms.c
> +++ b/drivers/atmodem/sms.c
> @@ -463,7 +463,8 @@ static void at_cmt_notify(GAtResult *result, gpointer=
 user_data)
>   	decode_hex_own_buf(hexpdu, -1, &pdu_len, 0, pdu);
>   	ofono_sms_deliver_notify(sms, pdu, pdu_len, tpdu_len);
>   =

> -	if (data->vendor !=3D OFONO_VENDOR_SIMCOM)
> +	if ((data->vendor !=3D OFONO_VENDOR_SIMCOM) &&
> +	    (data->vendor !=3D OFONO_VENDOR_DROID))

Fixed up style here per item M4

>   		at_ack_delivery(sms);
>   	return;
>   =


<snip>

> @@ -858,9 +860,14 @@ static gboolean build_cnmi_string(char *buf, int *cn=
mi_opts,
>   	if (!append_cnmi_element(buf, &len, cnmi_opts[0], mode, FALSE))
>   		return FALSE;
>   =

> +	mode =3D "21";
> +	if (!data->cnma_enabled)
> +		mode =3D "1";
> +	if (data->vendor =3D=3D OFONO_VENDOR_DROID)
> +		mode =3D "2";
> +

And here per item M1.

Also, I had to resolve a minor conflict manually.  Please rebase against gi=
t =

HEAD when sending out patches.

Applied, thanks.

Regards,
-Denis
--===============7904663017108156666==--

