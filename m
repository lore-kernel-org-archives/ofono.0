Content-Type: multipart/mixed; boundary="===============8448384605621243933=="
MIME-Version: 1.0
From: Frederic Danis <frederic.danis@linux.intel.com>
Subject: Re: [PATCH v0 13/15] handsfree-audio: Return InProgress on Connect
Date: Tue, 12 Mar 2013 16:26:54 +0100
Message-ID: <513F493E.9090104@linux.intel.com>
In-Reply-To: <1363092133-1092-14-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8448384605621243933==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Claudio,

On 12/03/2013 13:42, Claudio Takahasi wrote:
> This patch returns "Operation already in progress" if there is a
> pending Handsfree Audio Card "Connect" method call pending.
> ---
>   src/handsfree-audio.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
> index 8950347..805f3b6 100644
> --- a/src/handsfree-audio.c
> +++ b/src/handsfree-audio.c
> @@ -285,6 +285,9 @@ static DBusMessage *card_connect(DBusConnection *conn,
>   	if (agent =3D=3D NULL)
>   		return __ofono_error_not_available(msg);
>
> +	if (card->msg)
> +		return __ofono_error_busy(msg);
> +
>   	sk =3D driver->audio_connect(card->remote, card->local);
>   	if (sk < 0)
>   		return __ofono_error_failed(msg);
>

Shouldn't you also test if there is already a SCO connection (sco_watch) ?
I think that only one SCO link can be connected at a time for a =

Handsfree Audio Card.

Regards

Fred

-- =

Frederic Danis                            Open Source Technology Center
frederic.danis(a)intel.com                              Intel Corporation


--===============8448384605621243933==--

