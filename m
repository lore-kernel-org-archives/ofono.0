Content-Type: multipart/mixed; boundary="===============6497793250269511969=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [sim-ready-nofify-v4 PATCH 1/3] sim: add ofono_sim_ready_notify
Date: Thu, 03 Feb 2011 16:05:54 +0200
Message-ID: <AANLkTi=nRrMadOzNaj43_vu4GnuC6xyc17+QWFc1zHVi@mail.gmail.com>
In-Reply-To: <1294862783-1979-2-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6497793250269511969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

2011/1/12  <Pekka.Pessi@nokia.com>:
> @@ -1627,6 +1630,8 @@ static void sim_efphase_read_cb(int ok, int length,=
 int record,
>
> =C2=A0static void sim_initialize_after_pin(struct ofono_sim *sim)
> =C2=A0{
> + =C2=A0 =C2=A0 =C2=A0 sim->flags &=3D SIM_FLAG_WAIT_FOR_READY;
> +

You want to unset the flag here, no?

Otherwise this looks good to me.

Cheers,
Aki

--===============6497793250269511969==--

