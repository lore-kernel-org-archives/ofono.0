Content-Type: multipart/mixed; boundary="===============6444837331664533750=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] stemodem: Always run +CGACT? when we get +CGEV.
Date: Fri, 14 Jan 2011 14:33:07 +0100
Message-ID: <1295011987.3873.130.camel@aeonflux>
In-Reply-To: <1295003884-11243-1-git-send-email-maritsofie.henriksen8@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6444837331664533750==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marit,

> Remove checks for certain values of CGEV, and instead we will
> always run CGACT? to check what contexts that are active.
> ---
>  drivers/stemodem/gprs-context.c |   10 +++-------
>  1 files changed, 3 insertions(+), 7 deletions(-)

patch has been applied. Thanks.

Regards

Marcel



--===============6444837331664533750==--

