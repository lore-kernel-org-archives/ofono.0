Content-Type: multipart/mixed; boundary="===============5764372563811602602=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Make SimManager property SubscriberNumbers writable.
Date: Fri, 07 Aug 2009 15:52:43 -0500
Message-ID: <200908071552.43740.denkenz@gmail.com>
In-Reply-To: <1249590572-18743-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5764372563811602602==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

> This implements writing SubscriberNumbers if the SIM allows this (optional
> to the SIM provider).  Because the property is an array of phone numbers,
> setting the property needs to write multiple records on the SIM so it's n=
ot
> atomic and potentially can fail partially.  In this case we have to report
> a write error to DBus client but at the same time file may be changed and
> we send a PropertyChanged.

I applied he patch but made some fixes.  Namely you can set the subscriber =

number array to any value with number of elements 0 .. # of records in =

EFmsisdn.

I also fixed sim_adn_parse/sim_adn_build functions to report the TON proper=
ly.

Can you do some more testing to make sure it is working as intended?

Regards,
-Denis

--===============5764372563811602602==--

