Content-Type: multipart/mixed; boundary="===============3746588061992638171=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: commit d37c22be20c83cf370638a9bad243bc5219c5509
Date: Sun, 23 Sep 2018 12:37:29 +0200
Message-ID: <987C8A00-3F3E-4937-B680-ACBD257FFCDD@holtmann.org>
In-Reply-To: <CAKSBH7EX2KRX0ATKGT6BjnPfcxdj+gqw_WuqY_jtvuc60-TRmg@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3746588061992638171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

> was it necessary to remove entirely the NEED_THREADS flag?
> =

> I was going to use it in the Gemalto driver, to speed up the device recog=
nition, because for some modules it is hit and miss.
> But only as an optional feature, because in some systems it might be miss=
ing.
> =

> Also, for some high-speed modems which take long to boot, there is a pote=
ntial critical race in the recognition that the use threads can solve easil=
y. The alternative is to increase the internal timers a lot.
> =

> I likely need to add a new flag for it.

using threads is not the solution. This can be all done properly with singl=
e thread event loop driven methods.

Regards

Marcel


--===============3746588061992638171==--

