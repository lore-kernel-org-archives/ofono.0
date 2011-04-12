Content-Type: multipart/mixed; boundary="===============7191974301322841407=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/6] stkutil.c: Send at least the data currently available
Date: Mon, 11 Apr 2011 23:40:26 -0500
Message-ID: <4DA3D7BA.4050001@gmail.com>
In-Reply-To: <1302280411-20762-4-git-send-email-philippe.nunes@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7191974301322841407==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

On 04/08/2011 11:33 AM, Philippe Nunes wrote:
> ---
>  src/stkutil.c |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> =

> diff --git a/src/stkutil.c b/src/stkutil.c
> index 7299fb5..ee59841 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -5655,7 +5655,8 @@ static gboolean build_receive_data(struct stk_tlv_b=
uilder *builder,
>  	const struct stk_response_receive_data *receive_data =3D
>  		&response->receive_data;
>  =

> -	if (response->result.type !=3D STK_RESULT_TYPE_SUCCESS)
> +	if (response->result.type !=3D STK_RESULT_TYPE_SUCCESS &&
> +			response->result.type !=3D STK_RESULT_TYPE_MISSING_INFO)
>  		return TRUE;
>  =

>  	if (receive_data->rx_data.len) {

Does this check also belong on other data object builders?

Regards,
-Denis

--===============7191974301322841407==--

