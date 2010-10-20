Content-Type: multipart/mixed; boundary="===============3492349203921685403=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] isi: fix SMS
Date: Wed, 20 Oct 2010 12:56:34 -0500
Message-ID: <4CBF2D52.30601@gmail.com>
In-Reply-To: <1287593094-29153-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3492349203921685403==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 10/20/2010 11:44 AM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> Read absence/presence flags from correct field.
> =

> Try to avoid overwriting other SMS parameters but SCA address.
> =

> Use g_isi_(v)send().
> ---
>  drivers/isimodem/sms.c |   93 +++++++++++++++++++++++++++++-------------=
------
>  1 files changed, 56 insertions(+), 37 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============3492349203921685403==--

