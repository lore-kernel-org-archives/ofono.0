Content-Type: multipart/mixed; boundary="===============5895406398499732200=="
MIME-Version: 1.0
From: Pekka Pessi <ppessi@gmail.com>
Subject: Re: [PATCH] Check if ussd is busy when doing ss
Date: Tue, 14 Sep 2010 15:46:09 +0300
Message-ID: <AANLkTik7NvJZZ6RL9KZ_mnhyBTkS8krP3btoTtvc2w+Q@mail.gmail.com>
In-Reply-To: <CE761E84DADF2947A4AF22FB8D97A4732A79D376@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5895406398499732200==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

2010/9/14 Gu, Yang <yang.gu@intel.com>:
>>> It's still not clear how ss and ussd interfere with each other. Current
>>> decision is each ss (call-barring, call-forwarding, etc.) has
>>> interference with ussd, but there is no interference within these ss.
>>> That is, call-barring has interference with ussd, but call-barring has
>>> no interference with call-forwarding.
>>
>>There is only one signaling channel for the supplementary services.
>>Only one supplementary service operation can be active at a time. (Or
>>two, network can initiate ussd notify or request while
>>mobile-originated ussd is pending.)
>
> Thank you for the info. When you say only one MO ss operation can be acti=
ve at a time, do you mean modem will serialize them or oFono needs always t=
o take care, or it's hardware specific?

It is up to the firmware can do what ever it thinks is sensible.  I
don't think it will make any sense to serialize them, but then, you
will never know.

-- =

Pekka.Pessi mail at nokia.com

--===============5895406398499732200==--

