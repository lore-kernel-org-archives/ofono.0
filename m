Content-Type: multipart/mixed; boundary="===============6059735253300394025=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/3] atmodem: add a huawei hack to check attachment status
Date: Fri, 23 Apr 2010 10:50:33 -0500
Message-ID: <201004231050.34095.denkenz@gmail.com>
In-Reply-To: <87ljcerx6y.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6059735253300394025==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> Marcel Holtmann <marcel@holtmann.org> writes:
> > Hi Kalle,
> =

> Hi Marcel,
> =

> >> Huawei doesn't seem to send CGREG notifications (or I wasn't able to
> >> properly configure the modem to do it), so add an ugly to hack poll the
> >> state with CGATT.
> >
> > shouldn't be polling AT+CGREG? the better way to do this?
> =

> Most probably, I'll try with that command and test how it goes.
> =

> But is polling acceptable way to do this? And is there anything else I
> could do except poll? I'm open to all suggestions.
> =


These devices are sometimes quite weird, especially if they have multiple =

ports.  Sometimes unsolicited notifications are not sent to a particular po=
rt, =

and that port is for control only.  This could be the case here...

Regards,
-Denis

--===============6059735253300394025==--

