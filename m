Content-Type: multipart/mixed; boundary="===============8040424846721082516=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: ConnectionContext creation for LTE PDN Connection.
Date: Tue, 30 Nov 2010 12:26:15 +0100
Message-ID: <AANLkTimqaKh56fb1AsKLt-LX7f7-4cWvfUtj2hNGNxXC@mail.gmail.com>
In-Reply-To: <1291045108.4795.29.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8040424846721082516==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

Marcel Holtmann wrote:
>> > Or should oFono automatically create a Connection Context?
>> >
>> > Furthermore, should oFono automatically proceed and
>> > set Active=3Dtrue, bind the connection to a network interface
>> > and set network interface in state UP,
>>
>> Definitely not. This would interfere with any other existing IP connecti=
on, say
>> WiFi.
>
> why would bringing an interface up interfere? We are doing this right
> now. Just the IP assignment is done by ConnMan, but the interface
> up/down status is controlled by oFono or even BlueZ in case of
> Bluetooth.

So does this imply that you think oFono should set Active=3Dtrue and
and bring up the interface as soon as the Initial PDN  is avilable?

What about the ConnectionContext, should oFono automatically create a
new one if needed?

Regards,
Sjur

--===============8040424846721082516==--

