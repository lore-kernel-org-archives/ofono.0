Content-Type: multipart/mixed; boundary="===============3976104992292954745=="
MIME-Version: 1.0
From: JH <jupiter.hce@gmail.com>
Subject: Re: 4G LTE connection stability with USB voltage requirement
Date: Tue, 28 Jan 2020 06:08:18 +1100
Message-ID: <CAA=hcWTzEPeyH1bzyC1jGZVoiE2hho8fW6E6NTnAviXmw27k=w@mail.gmail.com>
In-Reply-To: <20200127173034.hw6il2cnpvgl64py@beryllium.lan>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3976104992292954745==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

Thanks for your response.

On 1/28/20, Daniel Wagner <wagi@monom.org> wrote:
> Hi JH,
>
> On Mon, Jan 27, 2020 at 01:26:41PM +1100, JH wrote:
>> It seems to me there are subtle differences between connman / ofono
>> and OpenWrt netifd, could the connman / ofono require more rigid
>> stable USB voltage than OpenWrt netifd? Or could the OpenWrt netifd be
>> more superior than connman / ofono in terms of 4G LTE connections?
>>
>> Appreciate your insight comments and advice.
>
> What about measuring the power drawn by the device? And while at it
> also careful check the datasheets of the components if the tolerances
> of the hardware components are meet.

I did current measuring, running ConnMan and oFono, the power
consumption was about 150mA - 260mA, running OpenWrt netifd, the power
consumption was about 150mA - 200mA. I have to say, the result might
not be accurate (1) if I change the voltage slightly, the power
consumption would be different; (2) The maximum current consumption
changes from time to time; (3) The DC power has only one output and
one current meter, I cannot connect both devices running in parallel.
I'll find a DC power supply with two power output and 2 current /
voltage meters, and to buy another debug cable to connect both devices
in parallel.

> I cannot comment on netifd since I don't know anything about it. But
> it could be that ConnMan and oFono together do more CPU work hence the
> device drains more power. I can tell you from experience if the CPU
> doesn't get enough power you see really random crashes and weird
> behaviors. Check the reports on Raspberry Pi and power supplies.

Good to know that experience, it does help a lot.

Thank you Daniel,

Kind regards,

- jh
--===============3976104992292954745==--

