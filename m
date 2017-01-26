Content-Type: multipart/mixed; boundary="===============7462933948288727679=="
MIME-Version: 1.0
From: gluedig@gmail.com
Subject: Re: [PATCH 2/4] plugins: support for Telit LE910 V2 modem
Date: Thu, 26 Jan 2017 10:09:18 +0100
Message-ID: <3026e500-7392-f3e8-3ee1-0e0817e5b392@gmail.com>
In-Reply-To: <9d8917de-c2ec-70e5-32fb-64ccc5897de2@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7462933948288727679==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On 01/25/2017 05:37 PM, Denis Kenzior wrote:
> On 01/25/2017 04:41 AM, Piotr Haber wrote:
>> LE910 V2 is next generation Telit LTE modem.
>> It supports 3GPP Rel. 9 LTE Cat. 4 over multiple bands.
>> Default USB composition uses PID 0x36 and
>> consists of 6 CDC-ACM serial ports and 1 CDC-NCM network adapter.
>> ---
>>  Makefile.am       |   3 +
>>  plugins/le910v2.c | 400
>> ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 403 insertions(+)
>>  create mode 100644 plugins/le910v2.c
>>
> =

> Can you add the LE910 changes into the HE910 driver?  The two are 99%
> the same except for HE910 supporting voice calls and LE910 using a
> different gprs_context driver.
> =

> There's no sense in maintaining a 400 line driver that is virtually
> identical to what we already have.
> =

> Regards,
> -Denis
> =


Hi,
of course you are right.

I would prepare a series of patches that renames he910 plugin to xe910 -
this is how Telit calls the whole family that consists of lots of models
form 2g (GE910) through 3/3.5g (HE910, DE910, UE910, HE910V2) to
4g(LE910, LE910V2)

Then I'll add support for LE910V2 to xe910 plugin.
How does it sound?

Piotr

--===============7462933948288727679==--

