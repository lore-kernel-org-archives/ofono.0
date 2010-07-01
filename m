Content-Type: multipart/mixed; boundary="===============7350476321838566127=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: How about offering a raw way for SMS
Date: Thu, 01 Jul 2010 12:01:36 +0200
Message-ID: <1277978496.3052.18.camel@aeonflux.t-mobile.de>
In-Reply-To: <D87B22B1FE8C0F479CA9BEAD6C25AAE8051011ED@ism-mail03.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7350476321838566127==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Caiwen,

please don't piggy-back on other threads. For new questions/discussion,
please start a brand new thread.

> Ofono stack encodes SMS before send it.  User may need send some
> special SMS. Such as send a v-card via SMS. =

> =

> It need to add user data header to indicate it is a v-card. Ofono
> currently does not support this feature. How about =

> =

> offering an API for user to sending raw PDU directly?  such as:
> =

>          void SendRawMessage(string pdu)
> =

> So,  user can encode it by himself and send the PDU. It can also
> applied to sending message with validity period/status report =

> =

> requirement and so on.
> =

>  =

> =

> Similarly,  how about sending out the raw PDU
> when dispatch incoming message?  There are many kinds of
> =

> SMS, such as voice mail notification, MMS notification, push mail
> notification etc.  How about sending out the raw =

> =

> PDU to upper layer and depending on upper layer to decode and decide
> how to process it? =


this is exactly what we NOT wanna do. There will be one entity that does
PDU encoding and decoding and this will be oFono. The reason behind this
is that keeping copies of PDU encoder/decoder around in every single
application is pretty much a really bad idea. We want it in one central
place with a large set of unit tests and proper long term testing. This
helps improving quality and ensures security and stability.

Having upper layers dealing with raw PDU is a design mistake that has
been made in the past way too many times. And this stops with oFono now.

So if you wanna send vCards or something similar, then you need to
extend oFono with interfaces to send vCards. Same goes for receiving
functionality.

Regards

Marcel



--===============7350476321838566127==--

