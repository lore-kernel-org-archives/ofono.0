Content-Type: multipart/mixed; boundary="===============0539715583575161964=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 1/1] gprs: detach from PS domain only if needed
Date: Thu, 25 Oct 2018 04:58:23 +0200
Message-ID: <CAKSBH7GmjA_x3vTeDEpEpz=RKC00NONG+eHa66BJn7RrGHML5A@mail.gmail.com>
In-Reply-To: <ed8840bd-fe83-e148-f46b-1ac33c574ab8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0539715583575161964==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

>
> So the ideal situation would be to turn all this off for LTE based
> dongles, have the ability to tell the modem not to auto-attach on 3G/2G,
> and maybe even attach only controlling 3G/2G PS domain only, not LTE.
>

this is not possible, and there are all the Hand-over scenarios, for
example during a CSFB call, or loss of LTE coverage.

It seems strange how LTE works because it is often overlooked that it
is just the GPRS part of 2G/3G,
with a small difference at the registration phase, which also performs
the attach (hence it is called combined attach).

Maybe it is really worth to start an ofono 2.x branch and remove this
roaming control on the attach.
Or, more conservative, add another variable for how to control
roaming: attach or context activation (that can be applied also to
LTE).
And decide globall, in the plug-in for the modem, or
subscription-based how to set this second variable (possibly all 3,
with overrides).


>
> Regards,
> -Denis

Regards,
Giacinto

--===============0539715583575161964==--

