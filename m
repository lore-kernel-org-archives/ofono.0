Content-Type: multipart/mixed; boundary="===============7651039621963908555=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: How to tweak sim atom
Date: Wed, 11 Jan 2012 05:47:40 -0600
Message-ID: <4F0D76DC.3050605@gmail.com>
In-Reply-To: <4F0DA6F3.8070702@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7651039621963908555==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

> 4) Having 2 drivers can be a solution to make difference between CSIM
> and (U)SIM:
>         - "atmodem/sim.c" drivers
>         - "cdmamodem/sim.c" drivers
> There can be a lib simutil for PIN management and IMSI retrieval whose
> APIs would be called by "atmodem" and "cdmamodem" drivers to avoid
> duplicated code.
> =


Why don't you try adding a 'atmodem-noef' driver to
drivers/atmodem/sim.c and see how far you get?  You only need ~13 lines
of code and a register / unregister driver call.

Regards,
-Denis

--===============7651039621963908555==--

