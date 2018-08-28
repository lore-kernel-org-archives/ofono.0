Content-Type: multipart/mixed; boundary="===============4548634565219240148=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] fixing SMS notification parsing for some cinterion modem
Date: Tue, 28 Aug 2018 10:27:18 -0500
Message-ID: <ec2044ba-4f68-e57b-1a1f-9a3ce0860d46@gmail.com>
In-Reply-To: <20180828134109.28537-1-tournier.julien@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4548634565219240148==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

The commit header needs a bit of tweaking.  It should be prefixed by the =

driver name or core atom name.  E.g.

atmodem: Handle broken +CMT notifications of some cinterion modems

On 08/28/2018 08:41 AM, tournier.julien(a)gmail.com wrote:
> Hi Denis,
> =

> I've recently found a bug in the +CMT notification parsing on some cinter=
ion
> modems. Some of them (ALS3, PLS8, maybe others...) have a leading coma ri=
ght
> after "+CTM : ", before the PDU size, which makes the parser rejecting the
> message since the PDU size is not found.
> =

> Please find attached my proposed patch.
> =


Could you fix the patch Author information to be something that I could =

I apply?  E.g. in a format like the AUTHORS file in ofono.git.

> ---
>   drivers/atmodem/sms.c | 17 +++++++++++++++--
>   1 file changed, 15 insertions(+), 2 deletions(-)
> =

> diff --git a/drivers/atmodem/sms.c b/drivers/atmodem/sms.c
> index 68b89862..d650c0f6 100644
> --- a/drivers/atmodem/sms.c
> +++ b/drivers/atmodem/sms.c
> @@ -412,8 +412,21 @@ static void at_cmt_notify(GAtResult *result, gpointe=
r user_data)
>   =

>   	switch (data->vendor) {
>   	case OFONO_VENDOR_CINTERION:
> -		if (!g_at_result_iter_next_number(&iter, &tpdu_len))
> -			goto err;
> +		if (!g_at_result_iter_next_number(&iter, &tpdu_len)) {
> +			/*
> +			 * Can't get the PDU length, we need to skip
> +			 * the leading coma for some modems (ALS3,PLS8...).
> +			 */

You might want to put an illustrative example of a broken +CMT =

notification above.  Doesn't have to be an actual valid message, just =

something to showcase the broken syntax.

> +			DBG("Retrying to find the PDU length");
> +
> +			if (!g_at_result_iter_skip_next(&iter))
> +				goto err;
> +
> +			/* Next attempt at finding the PDU length. */
> +			if (!g_at_result_iter_next_number(&iter, &tpdu_len))
> +				goto err;
> +		}
> +
>   		break;
>   	default:
>   		if (!g_at_result_iter_skip_next(&iter))
> =


Otherwise this looks good to me.

Regards,
-Denis

--===============4548634565219240148==--

