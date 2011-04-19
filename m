Content-Type: multipart/mixed; boundary="===============2770162550604120450=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v3 3/6] emulator: add +CLIP support for HFP AG
Date: Tue, 19 Apr 2011 14:00:52 -0500
Message-ID: <4DADDBE4.6070001@gmail.com>
In-Reply-To: <1302710734-6103-4-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2770162550604120450==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 04/13/2011 11:05 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> ---
>  src/emulator.c |   82 ++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 files changed, 81 insertions(+), 1 deletions(-)
> =


Patch has been applied, thanks.  One more comment:

> +static void notify_ring(struct ofono_emulator *em)
> +{
> +	struct ofono_call *c;
> +	const char *phone;
> +	/*
> +	 * '+CLIP: "+",' + phone number + phone type on 3 digits max
> +	 * + terminating null
> +	 */
> +	char str[OFONO_MAX_PHONE_NUMBER_LENGTH + 14 + 1];
> +
> +	g_at_server_send_unsolicited(em->server, "RING");
> +
> +	if (!em->clip)
> +		return;
> +
> +	c =3D find_call_with_status(em, CALL_STATUS_INCOMING);
> +
> +	if (c && c->clip_validity =3D=3D CLIP_VALIDITY_VALID) {

The spec really doesn't cover this, but you might want to send the CLIP
even in withheld cases.  Or is there a reason why you did it this way?

> +		phone =3D phone_number_to_string(&c->phone_number);
> +		sprintf(str, "+CLIP: \"%s\",%d", phone, c->phone_number.type);
> +
> +		g_at_server_send_unsolicited(em->server, str);
> +	}
> +}
> +

Regards,
-Denis

--===============2770162550604120450==--

