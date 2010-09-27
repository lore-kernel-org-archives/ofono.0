Content-Type: multipart/mixed; boundary="===============6941198709268930410=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/5] stk: Support send ss response
Date: Sun, 26 Sep 2010 19:48:48 -0500
Message-ID: <4C9FE9F0.2020509@gmail.com>
In-Reply-To: <1285064479-12907-3-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6941198709268930410==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

On 09/21/2010 05:21 AM, Yang Gu wrote:
> ---
>  src/stkutil.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> =

> diff --git a/src/stkutil.c b/src/stkutil.c
> index cdd6b4e..d35094b 100644
> --- a/src/stkutil.c
> +++ b/src/stkutil.c
> @@ -5449,6 +5449,8 @@ const unsigned char *stk_pdu_from_response(const st=
ruct stk_response *response,
>  					&response->select_item.item_id,
>  					NULL);
>  		break;
> +	case STK_COMMAND_TYPE_SEND_SS:
> +		break;

This seems wrong, isn't the additional information field mandatory?

Regards,
-Denis

--===============6941198709268930410==--

