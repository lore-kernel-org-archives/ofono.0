Content-Type: multipart/mixed; boundary="===============1057909313841237980=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Problems of CF setting and GSM string
Date: Tue, 14 Jul 2009 10:21:31 -0500
Message-ID: <200907141021.32117.denkenz@gmail.com>
In-Reply-To: <B94C62E7C2870743865418621F040C130203F12ABF@pdsmsx502.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1057909313841237980==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhigang,

> HI,
> Test against the 0.1 version,
> Tow problem were detected,
>
> 1, only set CF no reply timer can't successful, and I have to set no reply
> number or disable it first. Cf.setproperties("VoiceNoReply",dbusInt16(30))

This is on purpose, oFono won't let you set the NoReplyTimeout if no NoRepl=
y =

condition is set.

>
> 2, *SC***SIC# don't support in GSM string
>    *61***30#
> Are they known issue? or anything I did wrong

It is supported, but in the case of call forwarding, you must provide a SIA =

(phone number) otherwise oFono treats this as an invalid call forwarding =

request.  What you're trying to do is register call forwarding no reply =

condition with no number, but a 30 second timeout.  It makes no sense.

>
> Also only CF need update DATA,FAX,SMS in the future, right?

Once oFono has meaningful support for these call types, then in some form, =

yes.  But until then, there's no sense in exposing these features.

Regards,
-Denis

--===============1057909313841237980==--

