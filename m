Content-Type: multipart/mixed; boundary="===============7121017950392433457=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] stk: Additional info for failed Send USSD case
Date: Thu, 30 Sep 2010 19:11:03 -0500
Message-ID: <4CA52717.1030009@gmail.com>
In-Reply-To: <1285763296-7208-2-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7121017950392433457==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

> +	unsigned char addnl;

Lets try to be consistent with other parts of stk.c.
Use unsigned char no_cause[] =3D { 0x00 };

>  =

>  	if (stk->pending_cmd->send_ussd.alpha_id &&
>  			stk->pending_cmd->send_ussd.alpha_id[0])
> @@ -1661,7 +1662,14 @@ static void send_ussd_callback(int error, int dcs,=
 const unsigned char *msg,
>  		break;
>  =

>  	default:
> -		send_simple_response(stk, STK_RESULT_TYPE_USSD_RETURN_ERROR);
> +		rsp.result.type =3D STK_RESULT_TYPE_USSD_RETURN_ERROR;
> +		addnl =3D 0; /* No specific cause can be given */
> +		rsp.result.additional =3D &addnl;
> +		rsp.result.additional_len =3D 1;
> +

Then rsp.result.additional_len =3D sizeof(no_cause);
rsp.result.additional =3D no_cause

> +		if (stk_respond(stk, &rsp, stk_command_cb))
> +			stk_command_cb(&failure, stk);
> +
>  		break;
>  	}
>  }

Otherwise looks good.

Regards,
-Denis

--===============7121017950392433457==--

