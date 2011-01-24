Content-Type: multipart/mixed; boundary="===============4843095136711661491=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 1/6] gprs-provision: add driver API header
Date: Mon, 24 Jan 2011 12:38:14 +0200
Message-ID: <AANLkTinvcCf5qTReNBa=7Zo+fuzgFNsh8UjzERPb84k4@mail.gmail.com>
In-Reply-To: <4D39C5F8.4040004@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4843095136711661491==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2011/1/21 Denis Kenzior <denkenz@gmail.com>:
> How exactly are you guaranteeing that 'nothing bad should happen'?
> There is no cancellation mechanism that I see. =C2=A0Not to mention that =
the
> current ofono_sim_read API is not even safe either. =C2=A0For exactly the
> same reasons.

This is a problem with all users of ofono_sim_read() at the moment. I
suppose if the atoms get removed at different times, it may happen
that after the gprs atom is gone, the SIM atom is still calling its
read callback.

Seems like we need some sort of cancellation API to ofono_sim_read(),
or use Jukka's approach of a request object, perhaps with a
GDestroyNotify parameter, or simply change the way atoms are created
and removed so that this could be handled inside the SIM atom.

Cheers,
Aki

--===============4843095136711661491==--

