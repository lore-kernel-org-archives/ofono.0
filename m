Content-Type: multipart/mixed; boundary="===============1084035188961844605=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: About Connection between PPP and linux Sockets
Date: Fri, 20 Aug 2010 15:48:32 +0200
Message-ID: <1282312112.23399.215.camel@localhost.localdomain>
In-Reply-To: <6d4cb3c3e5039f1b09ef29d548ef1530@chewa.net>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1084035188961844605==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Remi,

> > for a mobile telephony stack, pppd is wrong. Once you understand how 3G
> > missuses PPP for IP and PDP context setup, you see what I mean ;)
> =

> For mobile telephony, PPP as a _protocol_ is wrong - sure. That being
> stated, I don't see how pppd as a _software_ is better or worse than any
> other PPP implementation.
> =

> Considering the high bandwidth involved in high HSPA categories, and soon
> LTE networks, going through user space seems like a bad idea. That's why
> Phonet GPRS has its own kernel network device driver, even though Phonet
> can also interact with a TUN device. As such, the PPP-only modems are
> hopeless. Then why bother rewriting a custom PPP implementation that will
> be suboptimal in any case?
> =

> oFono PPP is just as non-performant as pppd in case the user-space AT MUX
> is used. And it seems worse in case the kernel AT MUX or a raw TTY is used
> (pppd has kernel path then).

this is not about performance. It is about actually being able to
control the PPP link from oFono (or any other telephony stack for that
matter). With pppd you have no control points. It either works or you
are in deep sh*t.

Regards

Marcel



--===============1084035188961844605==--

