Content-Type: multipart/mixed; boundary="===============4037120947401873797=="
MIME-Version: 1.0
From: Zhang, Zhenhua <zhenhua.zhang@intel.com>
Subject: RE: About Connection between PPP and linux Sockets
Date: Fri, 20 Aug 2010 08:51:14 +0800
Message-ID: <33AB447FBD802F4E932063B962385B352A353FAC@shsmsx501.ccr.corp.intel.com>
In-Reply-To: <1282215259.23399.171.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4037120947401873797==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Marcel Holtmann wrote:
> Hi Steven,
> =

>> I have a little question just as the title said?
>> In Ofono how to connect PPP to Linux socket, when we receive packet
>> from network, how the packet go through the kernel to application=EF=BC=
=9F
>> =

>> modem -->PPP-->? --> linux kernel(network part)--> socket -->
>> application? =

> =

> it is more like this:
> =

> modem -> TTY -> PPP -> TUN/TAP -> Kernel Net-Stack -> socket ->
> application. =

> =

> With the TTY being in kernel, the PPP being in userspace, and TUN/TAP
> etc. begin in the kernel again.
> =

> A future enhancement is to use the kernel PPP layer, but we haven't
> gotten there yet.

I am interested to know how could we use kernel PPP layer instead of gatppp=
. Shall we add this item into our TODO?
 =

> Regards
> =

> Marcel
> =

> =

> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono

Regards,
Zhenhua

--===============4037120947401873797==--

