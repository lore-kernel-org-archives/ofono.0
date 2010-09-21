Content-Type: multipart/mixed; boundary="===============5207911136815525120=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH 5/5] cf: Handle send ss proactive command
Date: Tue, 21 Sep 2010 22:28:35 +0300
Message-ID: <B668883EB5DD7144ADFC248A72176EA802A51C75@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1285064479-12907-6-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5207911136815525120==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Yang,

> --- a/src/stk.c
> +++ b/src/stk.c

> +	unsigned char addnl[2];
> +
> +	default:
> +		DBG("Send ss finishes with error type: %d",
error->type);
> +		rsp.result.type =3D STK_RESULT_TYPE_SS_RETURN_ERROR;
> +		addnl[0] =3D (unsigned char) error->error;
> +		addnl[1] =3D STK_RESULT_ADDNL_SS_PB_NO_SPECIFIC_CAUSE;
> +		rsp.result.additional =3D addnl;
> +		rsp.result.additional_len =3D 2;
> +		break;
> +	}
> +

Isn't the above code, has to be something like =


	unsigned char addnl;

	default:
		rsp.result.type =3D STK_RESULT_TYPE_SS_RETURN_ERROR;
		addnl =3D STK_RESULT_ADDNL_SS_PB_NO_SPECIFIC_CAUSE;
		rsp.result.additional =3D &addnl;
		rsp.result.additional_len =3D 1; =


Regards,
jeevaka

--===============5207911136815525120==--

