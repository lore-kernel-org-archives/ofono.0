Content-Type: multipart/mixed; boundary="===============4508953289243896947=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Reg. MMS Support in oFono
Date: Tue, 20 Jul 2010 00:16:17 -0700
Message-ID: <1279610177.4572.53.camel@localhost.localdomain>
In-Reply-To: <AANLkTimFG3k_KjmHIjME1z1Si32VMorrrA4crdnSskDn@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4508953289243896947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Satya,

> I have one doubt regarding MMS features. =

> =

> =

> In previous mail list ofono team mention that "MMS is not supported by
> oFono, these belong in a separate daemon". Related link is as follows
>  :  http://lists.ofono.org/pipermail/ofono/2010-June/002672.html
> =

> =

> I thought it is ConnMan.  =

> =

> =

> But in ConnMan mailing list it is saying that "oFono will export these
> via a Socks5 or HTTP proxy to the MMS application without having
> ConnMan involved". Related link is as
> follows : http://lists.connman.net/pipermail/connman/2010-June/001515.html
> =

> =

> May I know what is that daemon that supports MMS features (upload /
> download, MMS read receipt indication, Delivery report indication).

this is all true. The MMS application/daemon will talk over a Socks5
proxy to oFono to get access to the MMSC. And will use oFono's D-Bus
interface to get MMS push notifications.

For MMS support we are on purpose trying to avoid using ConnMan and will
handle all TCP connections that the MMS application/daemon needs via a
proxy. This is important to not interfere with the Internet connections.
In general the contexts for MMS are just for MMS only and so we handle
them internally in oFono.

I might look rather complicated and complex right now, but once the
basic pieces are getting merged into oFono, I hope this becomes a lot
clearer.

Regards

Marcel



--===============4508953289243896947==--

