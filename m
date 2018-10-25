Content-Type: multipart/mixed; boundary="===============7789488979832465489=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] gprs: detach from PS domain only if needed
Date: Wed, 24 Oct 2018 22:15:24 -0500
Message-ID: <63639d49-4fdf-d4b3-175b-f2aa3ea6d96d@gmail.com>
In-Reply-To: <CAKSBH7GmjA_x3vTeDEpEpz=RKC00NONG+eHa66BJn7RrGHML5A@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7789488979832465489==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 10/24/2018 09:58 PM, Giacinto Cifelli wrote:
> Hi Denis,
> =

>>
>> So the ideal situation would be to turn all this off for LTE based
>> dongles, have the ability to tell the modem not to auto-attach on 3G/2G,
>> and maybe even attach only controlling 3G/2G PS domain only, not LTE.
>>
> =

> this is not possible, and there are all the Hand-over scenarios, for
> example during a CSFB call, or loss of LTE coverage.

What exactly is impossible?  a CSFB call goes onto the CS domain, so =

there should be no problem going from LTE -> CS only, no?

> =

> It seems strange how LTE works because it is often overlooked that it
> is just the GPRS part of 2G/3G,
> with a small difference at the registration phase, which also performs
> the attach (hence it is called combined attach).

Yes, but roaming is also completely different with LTE and many of these =

weird historical billing quirks no longer apply.

> =

> Maybe it is really worth to start an ofono 2.x branch and remove this
> roaming control on the attach.

Perhaps, but I wouldn't mind attempting to work around this without =

major surgery.  If we can't, then we can't, but lets not give up yet.

> Or, more conservative, add another variable for how to control
> roaming: attach or context activation (that can be applied also to
> LTE).

That is along the lines of what I was thinking...

> And decide globall, in the plug-in for the modem, or
> subscription-based how to set this second variable (possibly all 3,
> with overrides).

Feel free to propose something

Regards,
-Denis

--===============7789488979832465489==--

