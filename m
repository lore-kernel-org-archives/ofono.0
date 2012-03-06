Content-Type: multipart/mixed; boundary="===============6956009126853795039=="
MIME-Version: 1.0
From: Neil Jerram <neil@ossau.homelinux.net>
Subject: Re: Polling CLCC error handling on Option modem (GTA04)
Date: Tue, 06 Mar 2012 22:37:03 +0000
Message-ID: <877gyx1hm8.fsf@neil-laptop.ossau.uklinux.net>
In-Reply-To: <4F551365.9000200@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6956009126853795039==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz@gmail.com> writes:

> You will never be able to
> hit any sort of power consumption targets with CLCC polling anyway.

I think we do still have another possible line of investigation here.
Neil Brown reported that the modem does generate NO CARRIER on one of
its serial ports - just not the one that is expected.  So perhaps that
can be understood and used, and then the CLCC polling could be switched
off.

Denis, I looked at the oFono code to try to see where CLCC polling is
enabled for an active call, and in fact I couldn't see (in
plugins/atmodem/voicecall.c, which I think is the relevant code) what
could cause oFono _not_ to do CLCC polling.  It looks unconditional
there - is that right?

Regards,
    Neil

--===============6956009126853795039==--

