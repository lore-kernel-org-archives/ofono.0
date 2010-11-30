Content-Type: multipart/mixed; boundary="===============8522465821660471682=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH 3/3] stk: Handle provide local info proactive command
Date: Tue, 30 Nov 2010 22:43:23 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802C4036D@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <1291113890-24465-3-git-send-email-yang.gu@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8522465821660471682==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

 =

Hi Yang,

>  =

> +static void get_time(struct stk_response *rsp) {
> +	time_t now;
> +	struct tm *t;
> +
> +	time(&now);
> +	t =3D localtime(&now);
> +
> +	rsp->result.type =3D STK_RESULT_TYPE_SUCCESS;
> +
> +	if (t->tm_year > 100)
> +		rsp->provide_local_info.datetime.year =3D =

> t->tm_year - 100;
> +	else
> +		rsp->provide_local_info.datetime.year =3D t->tm_year;
> +

Incase of error, localtime shall return a null pointer. I think its
better to add the NULL check. =


Regards,
Jeevaka

--===============8522465821660471682==--

