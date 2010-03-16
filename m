Content-Type: multipart/mixed; boundary="===============8402122162060668979=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 4/4] Add parser for location information objects
Date: Tue, 16 Mar 2010 11:46:04 -0700
Message-ID: <1268765164.2700.27.camel@localhost.localdomain>
In-Reply-To: <1268733700-30154-4-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8402122162060668979==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

>  src/simutil.c |    2 +-
>  src/simutil.h |    1 +
>  src/stkutil.c |   40 +++++++++++++++++++++++++++++++++++++---
>  src/stkutil.h |    9 +++++++++
>  4 files changed, 48 insertions(+), 4 deletions(-)
> =

> diff --git a/src/simutil.c b/src/simutil.c
> index d9383b7..65ffa36 100644
> --- a/src/simutil.c
> +++ b/src/simutil.c
> @@ -538,7 +538,7 @@ static char *sim_network_name_parse(const unsigned ch=
ar *buffer, int length,
>  	return ret;
>  }
>  =

> -static void parse_mcc_mnc(const guint8 *bcd, char *mcc, char *mnc)
> +void parse_mcc_mnc(const guint8 *bcd, char *mcc, char *mnc)
>  {
>  	static const char digit_lut[] =3D "0123456789*#abd\0";
>  	guint8 digit;
> diff --git a/src/simutil.h b/src/simutil.h
> index 043c21f..09964a8 100644
> --- a/src/simutil.h
> +++ b/src/simutil.h
> @@ -181,6 +181,7 @@ const struct sim_eons_operator_info *sim_eons_lookup(=
struct sim_eons *eons,
>  						const char *mnc);
>  void sim_eons_free(struct sim_eons *eons);
>  =

> +void parse_mcc_mnc(const guint8 *bcd, char *mcc, char *mnc);
>  struct sim_spdi *sim_spdi_new(const guint8 *tlv, int length);
>  gboolean sim_spdi_lookup(struct sim_spdi *spdi,
>  				const char *mcc, const char *mnc);
> diff --git a/src/stkutil.c b/src/stkutil.c
> index 9f3bc0b..9fa7705 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -413,7 +413,7 @@ static gboolean parse_dataobj_file_list(struct compre=
hension_tlv_iter *iter,
>  	GSList **fl =3D user;
>  	const unsigned char *data;
>  	unsigned int len;
> -	unsigned int i;
> +	unsigned int i =3D 1;
>  	unsigned int start =3D 1;
>  	struct stk_file *sf;

this change makes no sense to me. Please only initialize variables when
really needed. I really want the compiler to warn us when we use
variables unexpectedly.

Regards

Marcel



--===============8402122162060668979==--

