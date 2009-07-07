Content-Type: multipart/mixed; boundary="===============3451687863336646659=="
MIME-Version: 1.0
From: Andrzej Zaborowski <andrew.zaborowski@intel.com>
Subject: Re: [PATCH] Parse SIM alpha fields (EF-SPN) according to TS 11.11.
Date: Tue, 07 Jul 2009 15:04:27 +0200
Message-ID: <fb249edb0907070604n14e0c858u688e063184d17aba@mail.gmail.com>
In-Reply-To: <200907061942.39687.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3451687863336646659==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

2009/7/7 Denis Kenzior <denkenz@gmail.com>:
> Your patch was a 'bit' inefficient, generating way too many function call=
s.

True, but in my defense only in the paths we are unlikely to hit.

> I've pushed my own version called sim_string_to_utf8, which can be found =
in
> util.c.
>
> Please review it for any issues..

Looks correct to me, assuming there are no valid UCS2-BE characters
with 0xff in first byte because the length check only checks first
byte.  The 0x81, 0x82 cases now also accept UTF-16 characters that
aren't UCS-2 (with upper byte 0xd8...0xdf).

Regards

--===============3451687863336646659==--

