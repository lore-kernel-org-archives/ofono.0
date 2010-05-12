Content-Type: multipart/mixed; boundary="===============0920947160549745510=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 09/19] stkutil: Add poll interval proactive command parser
Date: Wed, 12 May 2010 09:21:36 -0500
Message-ID: <201005120921.37137.denkenz@gmail.com>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A4731DE14AF5@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0920947160549745510==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> I agree with you to wrap duratioin in a struct. Personally, I'd also like
>  to wrap all the fields of command details in stk_command into a struct,
>  and fields of device identities into another struct. This will make
>  stk_command_new_from_pdu() and unit tests more consistent and symmetric.
> =


I'm actually fine with that.  Try seeing how it looks like.  If you think i=
t =

looks better send a patch for review.

Regards,
-Denis

--===============0920947160549745510==--

