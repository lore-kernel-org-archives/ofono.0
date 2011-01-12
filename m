Content-Type: multipart/mixed; boundary="===============6038814098668965517=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] test: add disable-call-forwarding
Date: Wed, 12 Jan 2011 08:18:01 -0800
Message-ID: <1294849081.3873.85.camel@aeonflux>
In-Reply-To: <1294825320-2928-1-git-send-email-jarko.poutiainen@tieto.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6038814098668965517==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jarko,

>  Makefile.am                  |    3 +-
>  test/disable-call-forwarding |   53 ++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 55 insertions(+), 1 deletions(-)
>  create mode 100755 test/disable-call-forwarding

Applying: test: add disable-call-forwarding
error: patch failed: Makefile.am:449
error: Makefile.am: patch does not apply
Patch failed at 0001 test: add disable-call-forwarding

> diff --git a/Makefile.am b/Makefile.am
> index 4dec90a..2df0fbd 100644
> --- a/Makefile.am
> +++ b/Makefile.am
> @@ -449,7 +449,8 @@ test_scripts =3D test/backtrace \
>  		test/set-tty \
>  		test/set-gsm-band \
>  		test/set-umts-band \
> -		test/lockdown-modem
> +		test/lockdown-modem \
> +		test/disable-call-forwarding

The error message is not surprising actually. You need to send patches
that depend on each other to applied one before the other one as
sequence of patches. This one is conflicting with your previous one ;)

Regards

Marcel



--===============6038814098668965517==--

