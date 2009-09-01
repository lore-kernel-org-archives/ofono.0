Content-Type: multipart/mixed; boundary="===============5953660618541865004=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/3] G1: Add G1-specific SMS support
Date: Tue, 01 Sep 2009 12:16:56 -0500
Message-ID: <200909011216.56476.denkenz@gmail.com>
In-Reply-To: <20090830040718.GA28091@mycelium.queued.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5953660618541865004==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andres,

> This is based on the atmodem SMS code, with lots of stuff dropped.
>
> The G1's modem advertises support for CNMI mode 2, but attempting to
> set that actually fails.  Instead, we _need_ to use mode 1.  Along
> those lines, CNMA doesn't appear to work properly, so we disable it
> and use CMTI rather than CMT for PDUs.  CDS notifications (for status
> notifications) are disabled completely.

So as we discussed on IRC, this one should really be rolled up into the =

generic_at sms driver, since the only change of substance is the cnmi mode =

selection specific to the g1.  We need a driver quirk system to be figured =
out =

first though.

Regards,
-Denis

--===============5953660618541865004==--

