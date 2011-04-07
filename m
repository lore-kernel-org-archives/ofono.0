Content-Type: multipart/mixed; boundary="===============5044369952717769758=="
MIME-Version: 1.0
From: Claudio Degioanni <claudio.degioanni@zirak.it>
Subject: Re: Trouble using Huwei E160G
Date: Thu, 07 Apr 2011 08:43:08 +0200
Message-ID: <4D9D5CFC.1070406@zirak.it>
In-Reply-To: <0E7E5CACD8E9F248AA009C292CC772A048E3ED@ALA-MBA.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5044369952717769758==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

HI Caiwen,

Il 06/04/2011 10.36, Zhang, Caiwen ha scritto:
> Hi Claudio,
>
>> I have made the test proposed, I still recive the same error :)
> ofonod[2329]: drivers/atmodem/gprs-context.c:at_gprs_context_probe() =

> ofonod[2329]: Missing support for TUN/TAP devices
>
> It seems you device doesn't support TUN/TAP. at_gprs_context_probe return=
 -ENODEV,
> So it cause the gprs context driver is not set (ofono_gprs_context->drive=
r is NULL).
>> Any suggestion ?
> Remove TUN checking code, in drivers/atmodem/gprs-context.c:at_gprs_conte=
xt_probe()
>
> Hope it help.

Thank you very much for feedback, I have checked the target kernel and
support for TUN (CONFIG_TUN) it disabled.

regs
Claudio
> Caiwen
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> http://lists.ofono.org/listinfo/ofono


--===============5044369952717769758==--

