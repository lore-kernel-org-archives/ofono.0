Content-Type: multipart/mixed; boundary="===============1581149611718591515=="
MIME-Version: 1.0
From: Kalle Valo <kalle.valo@canonical.com>
Subject: Re: [PATCH 0/3] Attach GPRS on demand
Date: Thu, 09 Dec 2010 14:40:40 +0200
Message-ID: <878vzz3yrb.fsf@potku.valot.fi>
In-Reply-To: <CB0EE8641411214CBAFF8AEBB26ABCEC03025C@008-AM1MPN1-007.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1581149611718591515==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

<Mika.Liljeberg@nokia.com> writes:

>> Besides, ConnMan doesn't really work this way. Maybe in the future
>> with the session API it would be able to, but not at the moment. I'll
>> let Marcel explain this more if he wants too..
>
> Admittedly, I haven't really looked at ConnMan. My assumption, though,
> is that a PDP context is not activated by default when ConnMan starts
> up. I.e., someone has to request the internet connectivity. Is that
> correct?

Connman services have autoconnect property which control if the
connection is automatically created or not.

> Activating a context by default would be very bad for power
> consumption and standby times, unless both the handset and the network
> support CPC. =


If I plugin a usb modem on my laptop, I really want to connect it
automatically.

> The decision should be up to the user.

And with the autoconnect property the user can control this.

-- =

Kalle Valo

--===============1581149611718591515==--

