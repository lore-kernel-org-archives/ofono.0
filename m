Content-Type: multipart/mixed; boundary="===============0516431444149145944=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 2/2] drivers: use %m instead of strerror()
Date: Sat, 04 Dec 2010 08:23:05 +0200
Message-ID: <AANLkTimPnSFVWYdMM4BOBqnzaZZezpaC26BKM==MNMwu@mail.gmail.com>
In-Reply-To: <1291404948-13335-2-git-send-email-remi.denis-courmont@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0516431444149145944==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi R=C3=A9mi,

2010/12/3 R=C3=A9mi Denis-Courmont <remi.denis-courmont@nokia.com>:
> ---
> =C2=A0drivers/isimodem/sim.c | =C2=A0 =C2=A03 ++-
> =C2=A01 files changed, 2 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/isimodem/sim.c b/drivers/isimodem/sim.c
> index b79c52a..0b3d2ae 100644
> --- a/drivers/isimodem/sim.c
> +++ b/drivers/isimodem/sim.c
> @@ -428,7 +428,8 @@ static void sim_reachable_cb(GIsiClient *client, gboo=
lean alive,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ofono_sim *sim =3D opaque;
>
> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!alive) {
> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("SIM client: %s", =
strerror(-g_isi_client_error(client)));
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 errno =3D -g_isi_clien=
t_error(client);
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 DBG("SIM client: %m");

I'm not getting how this improves things, as opposed to obfuscating
the code. And in any case, in the refactored gisi API, we have a
g_isi_msg_strerror() for this.

Cheers,
Aki

--===============0516431444149145944==--

