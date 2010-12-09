Content-Type: multipart/mixed; boundary="===============6263792482178847810=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH] TODO: Add task for NITZ name support in netreg
Date: Thu, 09 Dec 2010 08:52:15 +0200
Message-ID: <AANLkTimpfM88KdOg-kGL6ZTnGur7x6ULU5u0pgbSxYx2@mail.gmail.com>
In-Reply-To: <4CF93A65.3070804@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6263792482178847810==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

2010/12/3 Denis Kenzior <denkenz@gmail.com>:
> Out of curiosity, how do you plan to support this on AT modems? =C2=A0I h=
ave
> yet to see any AT modem report the NITZ network name via a proprietary
> command.

Are you sure? In my experience, the NITZ name may be received moments
after registration, so it would make sense to have an unsolicited
notification of it.

> Besides, all AT modems report the NITZ name via COPS. =C2=A0So in effect
> oFono already fulfills this task...

Well, not with ISI modems it doesn't. Also, if we move PLMN name
handling over to oFono, how can you determine if the name reported by
COPS is indeed the NITZ name and as such should take precedence over
the core's PLMN name?

Cheers,
Aki

--===============6263792482178847810==--

