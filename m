Content-Type: multipart/mixed; boundary="===============0196593574108870133=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 03/17] Add parser for access technology objects
Date: Tue, 20 Apr 2010 16:53:36 -0500
Message-ID: <201004201653.36622.denkenz@gmail.com>
In-Reply-To: <1271744112-32285-3-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0196593574108870133==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> ---
>  src/stkutil.c |   20 ++++++++++++++++++++
>  src/stkutil.h |    9 +++++++++
>  2 files changed, 29 insertions(+), 0 deletions(-)
> =

> diff --git a/src/stkutil.c b/src/stkutil.c
> index 0d4be68..d690f51 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
>  /*
> + * According to 102.223 Section 8.61 the length of CTLV is 1 byte. This
>  means + * that the maximum size is 127 according to the rules of CTLVs.
> + */
> +struct stk_access_technology {
> +	unsigned char tech[127];
> +	unsigned char len;
> +};
> +

Please look at 3GPP TS 31.124, my interpretation is that access technology =
is =

a single byte.  102.223 is not really helping here.

Regards,
-Denis

--===============0196593574108870133==--

