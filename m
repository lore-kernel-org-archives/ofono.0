Content-Type: multipart/mixed; boundary="===============6895305589809287264=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] qmimodem: support wake on SMS receive
Date: Wed, 24 Apr 2019 10:32:44 -0500
Message-ID: <0f5c5196-10a4-2a8a-69dd-e7848b0e6c03@gmail.com>
In-Reply-To: <234ec7e06d284810a11ffab4b6f7376c@garmin.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6895305589809287264==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Tom,

On 04/23/2019 07:42 AM, Nguyen, Tom wrote:
> Hi Denis,
> =

> Per question, "So doesn't this also cause us to bring the modem offline w=
hen we wake up from resume?"
> Yes, it does. While this modem is capable of waking the host CPU via GPIO=
 upon SMS reception, it doesn't have a handshake mechanism for the host to =
signal that it's ready to communicate with the modem, which would allow the=
 host to prevent the modem from sending the QMI indication too early. Frust=
ratingly, this handshake does exist if the modem is used with the AT interf=
ace. I tried to convince the vendor that the handshake should be applied to=
 the QMI interface too, but...

That sounds horrible.

> =

> Per comment, "So any state data must be allocated as part of the driver d=
ata."
> Thanks for the insight. Are you referring to "struct sms_data"?
> =


Yes, correct.  Anything that contains state must be allocated on the =

heap.  For oFono drivers this is typically the driver specific data =

structure setup in the .probe method.

> I've copied my other email, so hopefully my future responses won't break =
this chain.
> Also, thank you for helping with the IMEI patch.
> =


No worries.  Just FYI, when responding to the list, please refrain from =

top-posting.  The common open source mailing list etiquette is to =

respond in-line.

Regards,
-Denis

--===============6895305589809287264==--

