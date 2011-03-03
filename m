Content-Type: multipart/mixed; boundary="===============8650046792880982094=="
MIME-Version: 1.0
From: Aki Niemi <aki@protocolpolice.com>
Subject: Re: [PATCH v2 11/18] isimodem: wgmodem2.5 support in USSD
Date: Thu, 03 Mar 2011 17:45:40 +0200
Message-ID: <AANLkTimEWhmCw-=ntVmi4RfODdZNZ2CzSH9P2XvdWTiV@mail.gmail.com>
In-Reply-To: <3c5684049496d2ce79407863042bee8dc2dcfe1e.1298460572.git.andreas.westin@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8650046792880982094==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

2011/2/23 Andreas Westin <andreas.westin@stericsson.com>:
> From: Jessica Nilsson <jessica.j.nilsson@stericsson.com>
>
> ---
> =C2=A0drivers/isimodem/ussd.c | =C2=A0 36 ++++++++++++++++++++++++++++++-=
-----
> =C2=A01 files changed, 30 insertions(+), 6 deletions(-)

Patch has been pushed, with some refactoring done afterwards. The N900
modem handles padding fine, so might as well use it always.

Cheers,
Aki

--===============8650046792880982094==--

