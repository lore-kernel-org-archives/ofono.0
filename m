Content-Type: multipart/mixed; boundary="===============5677000123472467948=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 0/2] gemalto: netmon driver
Date: Mon, 11 Jan 2021 13:56:22 -0600
Message-ID: <d88b88b9-c250-5dd9-f361-ea348704392f@gmail.com>
In-Reply-To: <20210110194405.1994055-1-geomatsi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5677000123472467948==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sergey,

On 1/10/21 1:44 PM, Sergey Matyukevich wrote:
> Hello Denis and all,
> =

> This patch series implements netmon driver for gemalto modems that are
> able to provide basic measurements using AT+CQS and AT^SMONI commands.
> =

> This patch series is intendedly marked as RFC. In addition to general

I guess you mean intentionally here...

> feedback for this v1 I would like to clarify the right way to handle
> negative values that can be returned by modem. For instance, this

So the short answer is: You're not supposed to even have negative numbers i=
n AT =

commands.  And since oFono follows 27.007, which is itself based on AT comm=
ands, =

negative numbers do not really exist at the API level.

Refer to ITU v.250 Section 5.4.2.1 "Numeric constants".  Strings are also =

supposed to be formatted in a certain way, which the firmware isn't doing =

properly either...  The fact that you have to resort to using =

next_unquoted_string is kind of telling.

> is the case for the values measured in dBm including EC/n0 and RSCP.
> Currently such values are discarded by CELL_INFO_DICT_APPEND macro.

I would guess your best bet would be to re-scale from what Gemalto firmware =

reports into something that 27.007 recommends.  You may have to refer to 27=
.007, =

Section 8.69 to see what the scale is according to 3GPP.

Regards,
-Denis
--===============5677000123472467948==--

