Content-Type: multipart/mixed; boundary="===============4120944414805051715=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Parse SIM alpha fields (EF-SPN) according to TS 11.11.
Date: Tue, 07 Jul 2009 14:37:01 -0500
Message-ID: <200907071437.02179.denkenz@gmail.com>
In-Reply-To: <fb249edb0907070604n14e0c858u688e063184d17aba@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4120944414805051715==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> 2009/7/7 Denis Kenzior <denkenz@gmail.com>:
> > Your patch was a 'bit' inefficient, generating way too many function
> > calls.
>
> True, but in my defense only in the paths we are unlikely to hit.

Well we don't really know that, so lets keep the code efficient whenever =

possible ;)

>
> > I've pushed my own version called sim_string_to_utf8, which can be found
> > in util.c.
> >
> > Please review it for any issues..
>
> Looks correct to me, assuming there are no valid UCS2-BE characters
> with 0xff in first byte because the length check only checks first
> byte.  The 0x81, 0x82 cases now also accept UTF-16 characters that
> aren't UCS-2 (with upper byte 0xd8...0xdf).

Both valid points, I've pushed fixes to both.

Regards,
-Denis

--===============4120944414805051715==--

