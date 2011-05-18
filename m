Content-Type: multipart/mixed; boundary="===============6056895812576749084=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] voicecall: create generic dial function
Date: Tue, 17 May 2011 23:46:25 -0500
Message-ID: <4DD34F21.1000101@gmail.com>
In-Reply-To: <1305211258-8189-2-git-send-email-frederic.danis@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6056895812576749084==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 05/12/2011 09:40 AM, Fr=C3=A9d=C3=A9ric Danis wrote:
> split manager_dial between generic and dbus parts
> ---
>  src/voicecall.c |  106 +++++++++++++++++++++++++++++++++++++++++--------=
------
>  1 files changed, 79 insertions(+), 27 deletions(-)
> =

> diff --git a/src/voicecall.c b/src/voicecall.c
> index d46f463..037caac 100644
> --- a/src/voicecall.c
> +++ b/src/voicecall.c
> @@ -42,6 +42,17 @@
>  =

>  #define VOICECALL_FLAG_SIM_ECC_READY 0x1
>  =

> +enum dial_error {
> +	DIAL_NO_ERROR,
> +	DIAL_TOO_MANY_CALLS,
> +	DIAL_INVALID_PHONE,
> +	DIAL_NO_NETWORK,
> +	DIAL_NOT_SUPPORTED,
> +	DIAL_INCOMING,
> +	DIAL_BUSY,
> +	DIAL_ACTIVE
> +};
> +

Lets try to re-use errno.h for this.

e.g. NO_ERROR -> 0

TOO_MANY_CALLS -> -EPERM

INVALID_PHONE -> -EINVAL

NO_NETWORK -> -ENETDOWN

NOT_SUPPORTED -> -ENOTSUP

INCOMING, BUSY, ACTIVE -> -EBUSY or -EPERM

Regards,
-Denis

--===============6056895812576749084==--

