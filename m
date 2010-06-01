Content-Type: multipart/mixed; boundary="===============3759767735245733651=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/1] Huawei E176: Mark primary and secondary device at
 ofono.rules TODO: Fix sim_add detection, add E1552 idProduct to ofono.rules
Date: Tue, 01 Jun 2010 14:09:10 -0500
Message-ID: <201006011409.11869.denkenz@gmail.com>
In-Reply-To: <87d3wc2etx.fsf@potku.valot.fi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3759767735245733651==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kalle,

> Marcel Holtmann <marcel@holtmann.org> writes:
> > Hi Kalle,
> =

> Hallo Marcel,
> =

> >> I personally would prefer a solution which would dynamically probe the
> >> ports and choose them based on results. I believe modemmanager does
> >> something like this, but I haven't looked in detail.
> >
> > we should do something like auto-detect at some point, but there are
> > limits in it.
> =

> So what's the best option to go forward?
> =

> And related to this, can we rely on the port numbering order provided by
> udev? For example, on my Huawei E1552 port 0 is the main chat port and
> port 2 is the "event" port. Is it certain that port numbering will be
> the same across all distributions and kernels?
> =


I'm not the kernel expert, but the answer is probably 'no'.  However, doing =

any sort of port auto-detection inside plugins/udev.c is a bit nasty.  Best=
 we =

can do is set all of the 2/3/4 ttys and let the plugin probe them.  I =

certainly have doubts we can do this reliably.  If we can't, then we should =

consider Florian's approach as a backup.

Regards,
-Denis

--===============3759767735245733651==--

