Content-Type: multipart/mixed; boundary="===============1056292769487823572=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v3] huawei: fix AT^DDSETEX=2 timing
Date: Sat, 24 Mar 2012 11:51:31 -0700
Message-ID: <1332615091.1870.78.camel@aeonflux>
In-Reply-To: <1332597824-4217-2-git-send-email-devel@jlranta.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1056292769487823572==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

> Voice output serial port is enabled on some Huawei models (e.g. E169)
> without problems, but for example on E173u-2 it is never enabled
> during an incoming call. There might also be other Huawei models
> having the same issue.
> =

> I traced the issue down to "^DDSETEX" AT command, which is used
> to notify the device to start streaming audio. It seems that Ofono
> sends this command too early on incoming calls. The command should
> always be sent *after* the dial "D" or answer "A" command. The patch
> fixes this behavior and afterwards voice will also work on E173u-2.
> =

> Signed-off-by: Jarkko Lehtoranta <devel@jlranta.com>

I forgot one thing, we do not do Signed-off-by lines. I fixed this for
you.

> ---
>  drivers/huaweimodem/voicecall.c |   12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)

Patch has been applied.

Regards

Marcel



--===============1056292769487823572==--

