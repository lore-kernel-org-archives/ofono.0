Content-Type: multipart/mixed; boundary="===============2452668563345084388=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH] TODO: Add task for NITZ name support in netreg
Date: Fri, 10 Dec 2010 07:50:36 +0200
Message-ID: <AANLkTim6NdTkaHuidF-1Ub-ieBjPyck8JhmUS6+GNpYx@mail.gmail.com>
In-Reply-To: <4D0089AD.2010409@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2452668563345084388==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2010/12/9 Denis Kenzior <denkenz@gmail.com>:
> The NITZ notification does indeed arrive unsolicited. =C2=A0However, no AT
> modem that I know of reports the received NITZ name. =C2=A0This is only
> reported via COPS. =C2=A0The best you can do is call COPS again after the
> driver reports ofono_netreg_time_notify.

Then that could work, but this probably needs some prototyping. We
have a test network that actually implements NITZ names, so I can give
it a try.

> Hence the reason for my pointed questions. =C2=A0I'm a big proponent of
> moving the PLMN database to the core, however this needs to work for
> both ISI and AT modems.

Right, so you agree to this TODO item?

Cheers,
Aki

--===============2452668563345084388==--

