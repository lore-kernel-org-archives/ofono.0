Content-Type: multipart/mixed; boundary="===============7287350389361672636=="
MIME-Version: 1.0
From: Steven <liu-dj@neusoft.com>
Subject: Re: About ppp_receive()
Date: Wed, 25 Aug 2010 12:22:41 +0800
Message-ID: <4C749A91.5050203@neusoft.com>
In-Reply-To: <1282709918.6841.43.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7287350389361672636==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann wrote:
> Hi Steven,
> =

>>>> NO, just as the above have said ,we only negotiate two options, it's ok
>>>> for our PPP stack and it runs correctly.
>>> Then I'm confused.  What is your concern here? :)
>> currently, we worked on a Qualcomm CDMA chip, and it worked on a Relay =

>> mode, just relay the air PPP packet to host, and in Ofono we should =

>> support PFC to satisfy the spec (Sprint Spec.), But Ofono does not =

>> support PFC, so comes this question.
>>
>>  From my personal point, Ofono should support PFC.
> =

> as you might have clearly figured from Denis and my responses, our PPP
> code was designed to talk to a modem, not a network.
> =

> We don't want to implement a full blown PPP stack with all nasty
> features. If this is needed for CDMA, because they push the PPP frames
> over the air, then actually getting the kernel PPP frame processing
> hooked up to our LCP and IPIP userspace code is the right thing to do
> here.
> =

> At the moment we are not really putting additional energy into PPP since
> it is a dying protocol in the GSM world. The networks never required it

I got it.

> and the modem hardware/firmware moves over to highspeed direct IP
> interfaces.

I like to know this tech, is there any spec on this topic?

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


--===============7287350389361672636==--

