Content-Type: multipart/mixed; boundary="===============4918163178322596261=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] stk: Add busy error for the display text command
Date: Tue, 30 Nov 2010 06:25:13 -0600
Message-ID: <4CF4ED29.6010000@gmail.com>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D4018813547D902@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4918163178322596261==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

>> According to TS 102.223 on Screen Busy we also need to append a
>> "additional info" field in the Terminal Busy response with a 1-byte
>> value 01 ("screen is busy").
> =

> Yes you're right. I've seen this but after sending my patch.
> I've another patch in my pipe regarding this but in top of the current bu=
sy patch.
> I'm waiting the integration of the busy patch to submit it.

This is not how it works ;)  Please resubmit this patch with the code to
send 'Screen is Busy' additional info included.  You can even submit
your other pending patches in a series along with this one...

So e.g.

patch 1/n -> reworked add busy error...
patch 2/n -> pending patch 1,
etc

Regards,
-Denis

--===============4918163178322596261==--

