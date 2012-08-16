Content-Type: multipart/mixed; boundary="===============1290018109456682542=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] telit: disable auto attach procedures with AUTOATT
Date: Thu, 16 Aug 2012 01:26:42 -0500
Message-ID: <502C92A2.3010506@gmail.com>
In-Reply-To: <1345110510-1536-1-git-send-email-christopher.vogl@hale.at>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1290018109456682542==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Christopher,

On 08/16/2012 04:48 AM, Christopher Vogl wrote:
> ---
>   plugins/telit.c |    6 ++++++
>   1 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/plugins/telit.c b/plugins/telit.c
> index 6ae7249..feedd18 100644
> --- a/plugins/telit.c
> +++ b/plugins/telit.c
> @@ -307,6 +307,12 @@ static void cfun_enable_cb(gboolean ok, GAtResult *r=
esult, gpointer user_data)
>
>   	ofono_modem_set_powered(m, TRUE);
>
> +	/*
> +	 * Tell the modem not to automatically initiate auto-attach
> +	 * proceedures on its own.
> +	 */
> +	g_at_chat_send(data->chat, "AT#AUTOATT=3D0", none_prefix, NULL, NULL, N=
ULL);

This line is over 80 character limit.

Also, are you sure this can be sent even if the PIN is locked?

> +
>   	/* Enable sim state notification */
>   	g_at_chat_send(data->chat, "AT#QSS=3D1", none_prefix, NULL, NULL, NULL=
);
>

Regards,
-Denis

--===============1290018109456682542==--

