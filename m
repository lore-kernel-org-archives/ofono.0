Content-Type: multipart/mixed; boundary="===============5976604080249472947=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: oFono chat
Date: Mon, 11 Jul 2016 11:29:10 -0500
Message-ID: <5783C956.4090806@gmail.com>
In-Reply-To: <57836E35.1090701@ilbers.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5976604080249472947==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 07/11/2016 05:00 AM, Alexander Smirnov wrote:
> Dear oFono community,
>
> I'm a little bit confused, but is there any way to send oFono custom AT
> commands?

The driver can send any AT commands it wishes.  If you want to send AT =

commands through D-Bus, then no, there's no such functionality =

available, nor is it desired.

>
> In my case, I have chip with integrated GPS module, so I want to have
> possibility to manage its settings in runtime according to some
> environment settings.

There are plenty of examples on how to enable a modem with a GPS.  See
drivers/telitmodem/location-reporting.c
drivers/mbmmodem/location-reporting.c
drivers/qmimodem/location-reporting.c

etc

>
> Reading oFono API documentation, I wondered, why there is no chat
> interface? Are there any restrictions?
>

Regards,
-Denis

--===============5976604080249472947==--

