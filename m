Content-Type: multipart/mixed; boundary="===============9210195709175347734=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH 1/2] isimodem/sim: added PIN and SIM state handling
Date: Thu, 24 Mar 2011 15:36:38 +0200
Message-ID: <AANLkTikHvRhQQAV95ad8dcVOQQoiOoYT26n1CXG3VU4e@mail.gmail.com>
In-Reply-To: <1300967115-24054-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9210195709175347734==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

2011/3/24  <Pekka.Pessi@nokia.com>:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
>
> Using PN_SECURITY resource to obtain PIN statuses.
>
> Using ofono_sim_ready_notify() aka __ofono_sim_recheck_pin() to report
> the ready state.
> ---
> =C2=A0drivers/isimodem/debug.c | =C2=A0 59 +++++
> =C2=A0drivers/isimodem/debug.h | =C2=A0 =C2=A06 +
> =C2=A0drivers/isimodem/sim.c =C2=A0 | =C2=A0584 +++++++++++++++++++++++++=
++++++++++++++++-----
> =C2=A0drivers/isimodem/sim.h =C2=A0 | =C2=A0 50 ++++-
> =C2=A04 files changed, 634 insertions(+), 65 deletions(-)

Patch has been pushed. Thanks.

Cheers,
Aki

--===============9210195709175347734==--

