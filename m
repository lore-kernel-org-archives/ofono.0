Content-Type: multipart/mixed; boundary="===============6770565894957860363=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH RESEND] stemodem: Change use of types
Date: Tue, 23 Nov 2010 03:07:17 -0600
Message-ID: <4CEB8445.9030103@gmail.com>
In-Reply-To: <1290372915-7911-3-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6770565894957860363==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

On 11/21/2010 02:55 PM, Sjur Br=C3=A6ndeland wrote:
> From: Sjur Br=C3=A6ndeland <sjur.brandeland@stericsson.com>
> =

> Use the type __u32 for sequence counting rather than guint32,
> and "void *" instead of gpointer.
> Reduce the size of RTNL message buffer from 4096 to 1024,
> as this should be sufficient to hold the NEWLINK message.
> =

> ---
> Last patch was sent with base64 encoding :-(
> =

>  drivers/stemodem/caif_rtnl.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> =


Patch has been applied, thanks.

Regards,
-Denis

--===============6770565894957860363==--

