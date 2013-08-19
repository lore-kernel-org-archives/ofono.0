Content-Type: multipart/mixed; boundary="===============8934029286966660320=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/6] handsfree-audio: Add setting SCO air mode
Date: Mon, 19 Aug 2013 12:49:44 -0500
Message-ID: <52125AB8.4060506@gmail.com>
In-Reply-To: <1376619969-15080-3-git-send-email-vcgomes@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8934029286966660320==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 08/15/2013 09:26 PM, Vinicius Costa Gomes wrote:
> ---
>   src/handsfree-audio.c | 18 ++++++++++++++++++
>   1 file changed, 18 insertions(+)
>
> diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
> index 0bdeb99..0caa458 100644
> --- a/src/handsfree-audio.c
> +++ b/src/handsfree-audio.c
> @@ -68,6 +68,16 @@ static GSList *drivers =3D 0;
>   static ofono_bool_t has_wideband =3D FALSE;
>   static int defer_setup =3D 1;
>
> +static uint16_t codec2setting(uint8_t codec)
> +{
> +	switch (codec) {
> +		case HFP_CODEC_CVSD:
> +			return BT_VOICE_CVSD_16BIT;
> +		default:
> +			return BT_VOICE_TRANSPARENT;
> +	}
> +}
> +
>   static void send_new_connection(const char *card, int fd, uint8_t codec)
>   {
>   	DBusMessage *msg;
> @@ -107,6 +117,7 @@ static gboolean sco_accept(GIOChannel *io, GIOConditi=
on cond,
>   {
>   	struct ofono_handsfree_card *card;
>   	struct sockaddr_sco saddr;
> +	struct bt_voice voice;
>   	socklen_t alen;
>   	int sk, nsk;
>   	char local[18], remote[18];
> @@ -150,6 +161,13 @@ static gboolean sco_accept(GIOChannel *io, GIOCondit=
ion cond,
>   		return TRUE;
>   	}
>
> +	memset(&voice, 0, sizeof(voice));
> +	voice.setting =3D codec2setting(card->selected_codec);
> +
> +	if (setsockopt(nsk, SOL_BLUETOOTH, BT_VOICE, &voice, sizeof(voice)) < 0)
> +		ofono_error("Can't set voice settings: %s (%d)",
> +						strerror(errno), errno);
> +

So two things:
- If we do not support BT_VOICE socket option, then printing an error is =

not a good idea in the first place.
- If setting BT_VOICE fails and we indeed are trying to set wideband =

codec, then why are we still sending the (improperly configured) file =

descriptor to the agent?

>   	send_new_connection(card->path, nsk, card->selected_codec);
>   	close(nsk);
>
>

Regards,
-Denis

--===============8934029286966660320==--

