Content-Type: multipart/mixed; boundary="===============8278093835619026012=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Setting "RoamingAllowed" on by default; or storing persistently
Date: Tue, 23 Jul 2019 23:45:24 -0500
Message-ID: <906a7cf0-9ab5-7388-1e63-a20f31ac6ace@gmail.com>
In-Reply-To: <197f7ebf-af59-4256-6543-3e1793623bc7@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8278093835619026012==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tarmo,

>>> 2. if not, can I at least store RoamingAllowed persistently per SIM =

>>> card?
>>
>> This should already work...
> =

> Thank you for the quick reply. I'll begin by upgrading ofono to see if =

> the persistence starts to work for me.
> =


I would doubt it.  The code in question has been in there way before =

version 1.1.  Either your system is somehow strange (e.g. perhaps the fs =

is not writable) or we have a bug somewhere...

Regards,
-Denis

--===============8278093835619026012==--

