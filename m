Content-Type: multipart/mixed; boundary="===============2280610964750861984=="
MIME-Version: 1.0
From: Gu, Yang <yang.gu@intel.com>
Subject: RE: [PATCH] sim: Ensure to call sim_pin_check
Date: Wed, 25 Aug 2010 23:22:59 +0800
Message-ID: <CE761E84DADF2947A4AF22FB8D97A4732A516664@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <4C75318D.4070906@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2280610964750861984==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,


>-----Original Message-----
>From: Denis Kenzior [mailto:denkenz(a)gmail.com]
>Sent: Wednesday, August 25, 2010 11:07 PM
>To: ofono(a)ofono.org
>Cc: Gu, Yang
>Subject: Re: [PATCH] sim: Ensure to call sim_pin_check
>
>Hi Yang,
>
>> Your solution is better than mine, and might be Denis' intention of modi=
fication.
>Honestly, I ever thought about the change like your proposal (Actually it =
was the same
>as ppessi's patch), but I had a concern on current code. Now we read EFli =
and EFpl in
>parallel. Is it guaranteed the callback of EFli will be called before the =
callback of EFpl?
>IMO, it can't always guarantee this. If I'm correct, your solution is just=
 half way to the
>final target. Maybe we need to work out a better one:)
>
>Please note that the ofono_sim_read functions do not work in parallel.
>All file operations are added to a queue and executed sequentially.
>Hence we can rely on a certain order here.

I see. So Jeevaka and Ppessi's patch is definitely better than mine.


Regards,
-Yang

--===============2280610964750861984==--

