Content-Type: multipart/mixed; boundary="===============5046982326293499181=="
MIME-Version: 1.0
From: JH <jupiter.hce@gmail.com>
Subject: Re: Unsalble cellular connection
Date: Wed, 14 Aug 2019 21:11:59 +1000
Message-ID: <CAA=hcWTH2Ayb=OtWim7h_AX+0haoq_GZ5ZYGHbOLkCMq+zr6=A@mail.gmail.com>
In-Reply-To: <e698981e-c1c9-d782-7af1-ea1af4d89dfc@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5046982326293499181==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 8/14/19, Jonas Bonn <jonas@norrbonn.se> wrote:
> So you have no traffic over the LTE link?  How do you know that it goes
> down after 1-2 hours... maybe it went down after 5 minutes?

I logged link status every 10 minutes.

> Cloud messages are as good as a ping... a packet's a packet.
> The link is configured by connman, not ofono.  ofono just publishes the
> address details so that connman can set it up.

So, it is back to connman?

>>> No Address?  No Interface?  Running ofono with debug output will
>>> probably shed some light on what's going on here.
>>
>> I think that could be because I only ran it once, if I ran
>> list-contexts 4 times consecutively, every time it displayed different
>> results included address and interface, is it the normal behaviour of
>> list-contexts?
>
> Sounds broken...???

Which one is broken, ofono or connman or something else? There is not
much configurations for both ofono and connman,

Can the defect hardware particularly the system power supply caused
the link down? I have only one test device, I cannot prove it. The
SATA chip has a pin for power up, During the boot, a command to set
the power up before ofono is running. When the link is down, either I
restart the ofonod or I called the command to turn the power up again,
both can bring the link back. I cannot image the chip could lose
power, but if the system power supply is not stable in some stage too
low to support the SARA chip, will it trig the power down? I talked to
the hardware engineer who rejected that it did not make sense because
WiFi was running fine, he is pointing the figure to the modem manager
and connection manager.

Thank you.

Kind regards,

- jh

--===============5046982326293499181==--

