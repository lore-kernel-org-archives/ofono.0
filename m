Content-Type: multipart/mixed; boundary="===============4672592858268790960=="
MIME-Version: 1.0
From: Steven <liu-dj@neusoft.com>
Subject: Re: About Connection between PPP and linux Sockets
Date: Fri, 20 Aug 2010 09:24:16 +0800
Message-ID: <4C6DD940.2060407@neusoft.com>
In-Reply-To: <33AB447FBD802F4E932063B962385B352A353FAC@shsmsx501.ccr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4672592858268790960==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Zhang
Zhang, Zhenhua wrote:
> Hi Marcel,
> =

> Marcel Holtmann wrote:
>> Hi Steven,
>>
>>> I have a little question just as the title said?
>>> In Ofono how to connect PPP to Linux socket, when we receive packet
>>> from network, how the packet go through the kernel to application=EF=BC=
=9F
>>>
>>> modem -->PPP-->? --> linux kernel(network part)--> socket -->
>>> application? =

>> it is more like this:
>>
>> modem -> TTY -> PPP -> TUN/TAP -> Kernel Net-Stack -> socket ->
>> application. =

>>
>> With the TTY being in kernel, the PPP being in userspace, and TUN/TAP
>> etc. begin in the kernel again.
>>
>> A future enhancement is to use the kernel PPP layer, but we haven't
>> gotten there yet.
> =

> I am interested to know how could we use kernel PPP layer instead of gatp=
pp. Shall we add this item into our TODO?
>  =


Maybe you can reference to RILD in Android, it used kernel PPP.

B.R

Steven

---------------------------------------------------------------------------=
------------------------
Confidentiality Notice: The information contained in this e-mail and any ac=
companying attachment(s) =

is intended only for the use of the intended recipient and may be confident=
ial and/or privileged of =

Neusoft Corporation, its subsidiaries and/or its affiliates. If any reader =
of this communication is =

not the intended recipient, unauthorized use, forwarding, printing,  storin=
g, disclosure or copying =

is strictly prohibited, and may be unlawful.If you have received this commu=
nication in error,please =

immediately notify the sender by return e-mail, and delete the original mes=
sage and all copies from =

your system. Thank you. =

---------------------------------------------------------------------------=
------------------------

--===============4672592858268790960==--

