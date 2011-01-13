Content-Type: multipart/mixed; boundary="===============8395344664502667652=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 1/5 v3] nettime: Header file for nettime plugins
Date: Thu, 13 Jan 2011 14:58:45 +0200
Message-ID: <AANLkTiniPX-g-f1R99d0S8yVbvmv_+CqvVDW9PL3oufS@mail.gmail.com>
In-Reply-To: <1294912175-12026-2-git-send-email-antti.paila@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8395344664502667652==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antti,

2011/1/13 Antti Paila <antti.paila@nokia.com>:
> ---
> =C2=A0include/nettime.h | =C2=A0 =C2=A04 ++++
> =C2=A01 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/include/nettime.h b/include/nettime.h
> index 0f23cc7..2f73e1a 100644
> --- a/include/nettime.h
> +++ b/include/nettime.h
> @@ -31,6 +31,10 @@ struct ofono_network_time;
> =C2=A0struct ofono_nettime_context {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ofono_nettime_driver *driver;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ofono_modem *modem;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int timed_watch;
> + =C2=A0 =C2=A0 =C2=A0 gboolean timed_present;
> + =C2=A0 =C2=A0 =C2=A0 struct ofono_netreg *netreg;
> + =C2=A0 =C2=A0 =C2=A0 unsigned int netreg_st_watch;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0void *data;

Why are these added to the context as opposed to the plugin's user data?

Cheers,
Aki

--===============8395344664502667652==--

