Content-Type: multipart/mixed; boundary="===============0404522323530128941=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] simutil: Minor style fixes and indentation
Date: Wed, 22 Dec 2010 20:42:26 -0600
Message-ID: <4D12B712.4080006@gmail.com>
In-Reply-To: <1292924062-16665-1-git-send-email-jessica.j.nilsson@stericsson.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0404522323530128941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jessica,

On 12/21/2010 03:34 AM, Jessica Nilsson wrote:
> ---
>  src/simutil.h |  110 ++++++++++++++++++++++++++++-----------------------=
-----
>  1 files changed, 55 insertions(+), 55 deletions(-)
> =


<snip>

> @@ -319,24 +319,24 @@ gboolean comprehension_tlv_iter_next(struct compreh=
ension_tlv_iter *iter);
>  unsigned short comprehension_tlv_iter_get_tag(struct comprehension_tlv_i=
ter *i);
>  gboolean comprehension_tlv_get_cr(struct comprehension_tlv_iter *iter);
>  unsigned int comprehension_tlv_iter_get_length(
> -					struct comprehension_tlv_iter *iter);
> +	struct comprehension_tlv_iter *iter);

Actually the preferred style is to indent at least past the opening
brace.  Indenting further is acceptable as well (as long as you don't
hit the 80 character limit)

If this is not possible due to hitting the 80 character limit, then
indenting as far as possible to the right without hitting the limit is
preferred.

>  const unsigned char *comprehension_tlv_iter_get_data(
> -					struct comprehension_tlv_iter *iter);
> +	struct comprehension_tlv_iter *iter);
>  =

>  void comprehension_tlv_iter_copy(struct comprehension_tlv_iter *from,
>  					struct comprehension_tlv_iter *to);
>  =

>  gboolean comprehension_tlv_builder_init(
> -				struct comprehension_tlv_builder *builder,
> -				unsigned char *pdu, unsigned int size);
> +	struct comprehension_tlv_builder *builder,
> +	unsigned char *pdu, unsigned int size);
>  gboolean comprehension_tlv_builder_next(
> -				struct comprehension_tlv_builder *builder,
> -				gboolean cr, unsigned short tag);
> +	struct comprehension_tlv_builder *builder,
> +	gboolean cr, unsigned short tag);
>  gboolean comprehension_tlv_builder_set_length(
> -				struct comprehension_tlv_builder *builder,
> -				unsigned int len);
> +	struct comprehension_tlv_builder *builder,
> +	unsigned int len);
>  unsigned char *comprehension_tlv_builder_get_data(
> -				struct comprehension_tlv_builder *builder);
> +	struct comprehension_tlv_builder *builder);
>  =

>  void ber_tlv_iter_init(struct ber_tlv_iter *iter, const unsigned char *p=
du,
>  			unsigned int len);
> @@ -348,7 +348,7 @@ unsigned int ber_tlv_iter_get_tag(struct ber_tlv_iter=
 *iter);
>  =

>  enum ber_tlv_data_type ber_tlv_iter_get_class(struct ber_tlv_iter *iter);
>  enum ber_tlv_data_encoding_type
> -	ber_tlv_iter_get_encoding(struct ber_tlv_iter *iter);
> +ber_tlv_iter_get_encoding(struct ber_tlv_iter *iter);

Lets actually be consistent with the rest of this file and put the
struct ber_tlv_iter *iter on a separate line.  Similar to how e.g.
gboolean comprehension_tlv_builder_set_length is done.

>  =

>  /*
>   * This will return the short tag along with class and encoding informat=
ion.
> @@ -382,7 +382,7 @@ unsigned char *ber_tlv_builder_get_data(struct ber_tl=
v_builder *builder);
>  gboolean ber_tlv_builder_recurse(struct ber_tlv_builder *builder,
>  					struct ber_tlv_builder *recurse);
>  gboolean ber_tlv_builder_recurse_comprehension(struct ber_tlv_builder *b=
uilder,
> -				struct comprehension_tlv_builder *recurse);
> +						struct comprehension_tlv_builder *recurse);
>  void ber_tlv_builder_optimize(struct ber_tlv_builder *builder,
>  				unsigned char **pdu, unsigned int *len);
>  =

> @@ -394,13 +394,13 @@ void sim_eons_add_opl_record(struct sim_eons *eons,
>  				const guint8 *contents, int length);
>  void sim_eons_optimize(struct sim_eons *eons);
>  const struct sim_eons_operator_info *sim_eons_lookup_with_lac(
> -						struct sim_eons *eons,
> -						const char *mcc,
> -						const char *mnc,
> -						guint16 lac);
> +	struct sim_eons *eons,
> +	const char *mcc,
> +	const char *mnc,
> +	guint16 lac);

Indenting the original one more would actually be the preferred style

>  const struct sim_eons_operator_info *sim_eons_lookup(struct sim_eons *eo=
ns,
> -						const char *mcc,
> -						const char *mnc);
> +							const char *mcc,
> +							const char *mnc);

Looks good.

>  void sim_eons_free(struct sim_eons *eons);
>  =

>  void sim_parse_mcc_mnc(const guint8 *bcd, char *mcc, char *mnc);
> @@ -439,10 +439,10 @@ gboolean sim_parse_2g_get_response(const unsigned c=
har *response, int len,
>  					unsigned char *file_status);
>  =

>  gboolean sim_ust_is_available(unsigned char *service_ust, unsigned char =
len,
> -						enum sim_ust_service index);
> +				enum sim_ust_service index);
>  gboolean sim_est_is_active(unsigned char *service_est, unsigned char len,
> -						enum sim_est_service index);
> +				enum sim_est_service index);
>  gboolean sim_sst_is_available(unsigned char *service_sst, unsigned char =
len,
> -						enum sim_sst_service index);
> +				enum sim_sst_service index);
>  gboolean sim_sst_is_active(unsigned char *service_sst, unsigned char len,
> -						enum sim_sst_service index);
> +				enum sim_sst_service index);

The originals are actually fine.

Regards,
-Denis

--===============0404522323530128941==--

