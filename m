Content-Type: multipart/mixed; boundary="===============6502567798978907796=="
MIME-Version: 1.0
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: Re: [PATCH] handsfree-audio: Fix not emitting CardRemoved
Date: Tue, 26 Feb 2013 19:06:05 -0300
Message-ID: <CAKT1EBdh3UOoW8WxKm+br7jkq0xNr3s1kTcynmBH9nTxXWeJ9w@mail.gmail.com>
In-Reply-To: <1361912683-18938-1-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6502567798978907796==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi:

On Tue, Feb 26, 2013 at 6:04 PM, Claudio Takahasi
<claudio.takahasi@openbossa.org> wrote:
> ---
>  src/handsfree-audio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/handsfree-audio.c b/src/handsfree-audio.c
> index db65971..c99d65b 100644
> --- a/src/handsfree-audio.c
> +++ b/src/handsfree-audio.c
> @@ -194,10 +194,10 @@ static void card_unregister(struct ofono_handsfree_=
card *card)
>  {
>         DBusConnection *conn =3D ofono_dbus_get_connection();
>
> -       g_dbus_unregister_interface(conn, card->path, HFP_AUDIO_CARD_INTE=
RFACE);
> -
>         emit_card_removed(card);
>
> +       g_dbus_unregister_interface(conn, card->path, HFP_AUDIO_CARD_INTE=
RFACE);
> +
>         g_free(card->path);
>         card->path =3D NULL;
>  }
> --
> 1.7.11.7

Ignore this patch.

I messed up the object path name and interface.

Claudio.

--===============6502567798978907796==--

