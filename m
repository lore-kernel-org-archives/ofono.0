Content-Type: multipart/mixed; boundary="===============6260599546639774101=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] hfp_hf: Fix modifying hash table while iterating
Date: Wed, 18 Apr 2012 19:55:11 -0500
Message-ID: <4F8F626F.3060008@gmail.com>
In-Reply-To: <CANT-zCUrNSM4xRhwj_CiiCZeJoMV-vDkqKC4pj=Co6y3Q8AhWw@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6260599546639774101==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

>> The patch looks absolutely fine, however can you check whether removing
>> g_hashtable_remove from hfp_remove would do the trick as well?  We don't
>> seem to be doing this in the sap driver, and I no longer recall whether
>> this was done in hfp_hf to keep valgrind happy or is simply a mistake.
> =

> I was reluctant to make such a change because I wasn't entirely sure about
> which assumptions are made by the core about modem removals.
> =

> If we know that all calls to ofono_modem_remove() will be originated in
> hfp_hf.c, then your proposal would just work. I will send the correspondi=
ng
> patch soon.

The core does not call ofono_modem_remove on its own, this is triggered
by the plugins (e.g. udev, bluetooth).  So Under normal circumstances
all calls to ofono_modem_remove would be triggered by BlueZ reporting
something, e.g. adapter removed, device removed, etc.

The only time this might be a problem is during shutdown, hence my
comment about keeping valgrind happy.

Regards,
-Denis

--===============6260599546639774101==--

