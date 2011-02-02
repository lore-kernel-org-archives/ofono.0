Content-Type: multipart/mixed; boundary="===============1604197625032015008=="
MIME-Version: 1.0
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: Re: Selecting multiple radio access technologies in oFono
Date: Wed, 02 Feb 2011 10:46:10 -0200
Message-ID: <AANLkTincQujFn0X8J5SuvJU4-1uJaK_Bd34pmuQvvsYh@mail.gmail.com>
In-Reply-To: <24601CEAED63B94588D46990641D59241B7B4D8DB8@EXDCVYMBSTM005.EQ1STM.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1604197625032015008==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kjetil,

On Wed, Feb 2, 2011 at 10:00 AM, Kjetil ASDAL
<kjetil.asdal@stericsson.com> wrote:
> When you say "band selection", I assume you are talking about frequency b=
ands.
> AFAIK, the frequency band is a setting within the radio access technology=
, and
> I don't think it is possible to "disable" LTE by deselecting certain freq=
uency

I don't know about LTE, but I can effectively disable umts in my
huawei modem just by choosing a frequency not available in my country.
Then, when going online the modem is forced to use one of the GSM
ones.


> bands. Furthermore, AFAIK, there are no AT commands for doing frequency b=
and
> selection.

It depends on the modem. See the implementation for huawei in
drivers/huaweimodem/radio-settings.c:huawei_set_band(). It uses the
AT^SYSCFG command that is specific to huawei modems.




regards,
Lucas De Marchi

--===============1604197625032015008==--

