Content-Type: multipart/mixed; boundary="===============2755272517814934081=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [gisi-notify-fix PATCH 2/4] gisi: simplify handling of pending
Date: Tue, 18 Jan 2011 22:31:12 +0200
Message-ID: <AANLkTim9SW4=yLM3v_hzo9oMLZ1Yh6fvFq6b9-u7r4xq@mail.gmail.com>
In-Reply-To: <1294860252-29570-3-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2755272517814934081==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

2011/1/12  <Pekka.Pessi@nokia.com>:
> diff --git a/gisi/modem.h b/gisi/modem.h
> index fff1338..91fe3d0 100644
> --- a/gisi/modem.h
> +++ b/gisi/modem.h
> @@ -109,7 +109,9 @@ int g_isi_response_vsend(GIsiModem *modem, const GIsi=
Message *req,
>
> =C2=A0GIsiPending *g_isi_pending_from_msg(const GIsiMessage *msg);
>
> -void g_isi_pending_remove(GIsiPending *operation);
> +void g_isi_pending_own(GIsiPending *op, gpointer owner);
> +void g_isi_remove_all_my_pending(GIsiModem *modem, uint8_t resource,
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gpointer own=
er);

Overall, I like the idea.

But how about naming these a bit better? Something like
g_isi_pending_set_owner() and g_isi_pending_remove_by_owner()?

Cheers,
Aki

--===============2755272517814934081==--

