Content-Type: multipart/mixed; boundary="===============4986343416824555095=="
MIME-Version: 1.0
From: Steven <liu-dj@neusoft.com>
Subject: Re: About Connection between PPP and linux Sockets
Date: Fri, 20 Aug 2010 16:53:35 +0800
Message-ID: <4C6E428F.8040507@neusoft.com>
In-Reply-To: <1282292982.23399.195.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4986343416824555095==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel=EF=BC=8C

Marcel Holtmann wrote:
> Hi Zhenhua,
> =

>>>>>>>> I have a little question just as the title said?
>>>>>>>> In Ofono how to connect PPP to Linux socket, when we receive
>>>>>>>> packet from network, how the packet go through the kernel to
>>>>>>>> application=EF=BC=9F =

>>>>>>>>
>>>>>>>> modem -->PPP-->? --> linux kernel(network part)--> socket -->
>>>>>>>> application?
>>>>>>> it is more like this:
>>>>>>>
>>>>>>> modem -> TTY -> PPP -> TUN/TAP -> Kernel Net-Stack -> socket ->
>>>>>>> application. =

>>>>>>>
>>>>>>> With the TTY being in kernel, the PPP being in userspace, and
>>>>>>> TUN/TAP etc. begin in the kernel again.
>>>>>>>
>>>>>>> A future enhancement is to use the kernel PPP layer, but we
>>>>>>> haven't gotten there yet.
>>>>>> I am interested to know how could we use kernel PPP layer instead
>>>>>> of gatppp. Shall we add this item into our TODO?
>>>>>>
>>>>> Maybe you can reference to RILD in Android, it used kernel PPP.
>>>> Thanks. Will take a look then.
>>> This information is a good start point.
>>> http://www.devdiv.net/viewthread-26543
>>>
>>> But only for Chinese people:(
>> Thanks. I have read this before. ;-). The original article is from maxle=
ng's blog:
>>
>> http://blog.csdn.net/maxleng/archive/2010/05/10/5576509.aspx
>>
>> However, it's just a big picture about phone stack in Android. It said n=
othing about how Android works with kernel PPP layer.
> =

> could be that Andoid uses the kernel PPP and also uses pppd for it. We
> are not using pppd on purpose since it is the wrong piece for an
> embedded phone solution. We are not using the kernel PPP part, because
> we haven't gotten around that yet. It also only works when having real
> TTY devices.
I don't think using pppd is a wrong piece for embedded phone, if we =

using pppd, we can ease the ppp part of ofono and also support full ppp =

functionalities, such as auth method(plain text, pap, chap, eap and so on)

  If your multiplexer runs in userspace then you also have
> the problem that you don't have a real TTY. And using a PTS, then you
> can just run PPP also in userspace.

A little question, if we runs multiplexer in kernel space, can we using =

kernel ppp part?

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

--===============4986343416824555095==--

