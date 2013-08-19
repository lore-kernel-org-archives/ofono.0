Content-Type: multipart/mixed; boundary="===============3795349671215939375=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/6] handsfree-audio: Set the voice setting for outgoing
 connections
Date: Mon, 19 Aug 2013 12:56:23 -0500
Message-ID: <52125C47.2080400@gmail.com>
In-Reply-To: <1376619969-15080-5-git-send-email-vcgomes@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3795349671215939375==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 08/15/2013 09:26 PM, Vinicius Costa Gomes wrote:
> In the AG case, the voice setting needs to be set before we can
> use Transparent SCO mode, which is necessary for Wideband speech
> support.
> ---
>   src/handsfree-audio.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
> index c83086f..d550e6e 100644
> --- a/src/handsfree-audio.c
> +++ b/src/handsfree-audio.c
> @@ -442,6 +442,7 @@ int ofono_handsfree_card_connect_sco(struct ofono_han=
dsfree_card *card)
>   {
>   	GIOChannel *io;
>   	struct sockaddr_sco addr;
> +	struct bt_voice voice;
>   	int sk, ret;
>
>   	sk =3D socket(PF_BLUETOOTH, SOCK_SEQPACKET | O_NONBLOCK | SOCK_CLOEXEC,
> @@ -465,6 +466,13 @@ int ofono_handsfree_card_connect_sco(struct ofono_ha=
ndsfree_card *card)
>   	addr.sco_family =3D AF_BLUETOOTH;
>   	bt_str2ba(card->remote, &addr.sco_bdaddr);
>
> +	memset(&voice, 0, sizeof(voice));
> +	voice.setting =3D codec2setting(card->selected_codec);
> +
> +	if (setsockopt(sk, SOL_BLUETOOTH, BT_VOICE, &voice, sizeof(voice)) < 0)
> +		ofono_error("Can't set voice settings: %s (%d)",
> +						strerror(errno), errno);
> +

Same comment here as for patch 2.

- If we fail to set BT_VOICE and our kernel does not support it, then =

printing an error is superfluous.
- If we indeed try to set wideband codec and fail, then continuing with =

the connection is kinda bad.

>   	ret =3D connect(sk, (struct sockaddr *) &addr, sizeof(addr));
>   	if (ret < 0 && errno !=3D EINPROGRESS) {
>   		close(sk);
>

Regards,
-Denis

--===============3795349671215939375==--

