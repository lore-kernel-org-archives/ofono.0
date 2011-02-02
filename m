Content-Type: multipart/mixed; boundary="===============3157457103291732859=="
MIME-Version: 1.0
From: Kjetil ASDAL <kjetil.asdal@stericsson.com>
Subject: RE: Selecting multiple radio access technologies in oFono
Date: Wed, 02 Feb 2011 14:10:56 +0100
Message-ID: <24601CEAED63B94588D46990641D59241B7B4D8E68@EXDCVYMBSTM005.EQ1STM.local>
In-Reply-To: <AANLkTincQujFn0X8J5SuvJU4-1uJaK_Bd34pmuQvvsYh@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3157457103291732859==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas,

Lucas wrote:
 =

> I don't know about LTE, but I can effectively disable umts in my
> huawei modem just by choosing a frequency not available in my country.
> Then, when going online the modem is forced to use one of the GSM
> ones.
 =

That may very well be so, but I still think this is at best a funny way =

to disable LTE (or any other RAT for that matter). I should come right =

out and say that I am far from an expert on how the radio stack operates, =

but I suspect that by doing what you propose, the radio will have to do =

periodical "measurements" to see if the chosen frequency band has become =

available, and this could result in some extra power consumption.

> It depends on the modem. See the implementation for huawei in
> drivers/huaweimodem/radio-settings.c:huawei_set_band(). It uses the
> AT^SYSCFG command that is specific to huawei modems.

Of course you are right; it definitely depends on the modem and what AT =

commands are supported. What I meant (but did not write) was that there =

are no standard AT commands (i.e. from 3GPP TS 27.007) for this.

Regards, =

Kjetil

--===============3157457103291732859==--

