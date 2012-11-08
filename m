Content-Type: multipart/mixed; boundary="===============2911722243470044819=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Alcatel Onetouch X515 support
Date: Thu, 08 Nov 2012 09:43:03 -0600
Message-ID: <509BD307.2010108@gmail.com>
In-Reply-To: <CABvLYuCg20pYAfkLmaAMFDJO8u6xpvX=gC2mfm9228_iGruQEA@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2911722243470044819==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Cedric,

On 11/08/2012 09:29 AM, Cedric Jehasse wrote:
>     The design philosophy is to not perform any polling in the core.
>       The modem driver has to take care of this.
>
> Ok. So in case of the atmodem driver, would it be correct to move this
> retrying of AT+CPIN? to at_cpin_cb and only call the cb from the core
> once the reply is not CME Error SIM Busy?

The SIM busy stuff is tricky.  oFono reads lots of files from the SIM =

before even checking CPIN.  So you need to check the CPIN SIM busy =

condition before signaling that the SIM is inserted.  As I said, check =

how other Qualcomm based devices are doing this.  E.g. Huawei, ZTE, etc.

Regards,
-Denis

--===============2911722243470044819==--

