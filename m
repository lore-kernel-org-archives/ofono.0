Content-Type: multipart/mixed; boundary="===============3039493017071904130=="
MIME-Version: 1.0
From: Daniel Wagner <wagi@monom.org>
Subject: Re: 4G LTE connection stability with USB voltage requirement
Date: Mon, 27 Jan 2020 18:30:34 +0100
Message-ID: <20200127173034.hw6il2cnpvgl64py@beryllium.lan>
In-Reply-To: <CAA=hcWTiqmULgD1JqEHUo4iXtrCt+zQAHmJL8=wPUNqPA57ENA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3039493017071904130==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi JH,

On Mon, Jan 27, 2020 at 01:26:41PM +1100, JH wrote:
> It seems to me there are subtle differences between connman / ofono
> and OpenWrt netifd, could the connman / ofono require more rigid
> stable USB voltage than OpenWrt netifd? Or could the OpenWrt netifd be
> more superior than connman / ofono in terms of 4G LTE connections?
> =

> Appreciate your insight comments and advice.

What about measuring the power drawn by the device? And while at it
also careful check the datasheets of the components if the tolerances
of the hardware components are meet.

I cannot comment on netifd since I don't know anything about it. But
it could be that ConnMan and oFono together do more CPU work hence the
device drains more power. I can tell you from experience if the CPU
doesn't get enough power you see really random crashes and weird
behaviors. Check the reports on Raspberry Pi and power supplies.

Thanks,
Daniel
--===============3039493017071904130==--

