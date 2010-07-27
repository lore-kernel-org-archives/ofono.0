Content-Type: multipart/mixed; boundary="===============7664149187989895820=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 5/6] stk: Handle the Select Item proactive command.
Date: Mon, 26 Jul 2010 17:27:40 -0700
Message-ID: <1280190460.2621.67.camel@localhost.localdomain>
In-Reply-To: <1280150080-6257-5-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7664149187989895820==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andew,

> +	switch (result) {
> +	case STK_AGENT_RESULT_OK:
> +		type =3D STK_RESULT_TYPE_SUCCESS;
> +		break;
> +
> +	case STK_AGENT_RESULT_BACK:
> +		type =3D STK_RESULT_TYPE_GO_BACK;
> +		goto send;
> +
> +	case STK_AGENT_RESULT_TIMEOUT:
> +		type =3D STK_RESULT_TYPE_NO_RESPONSE;
> +		goto send;
> +
> +	case STK_AGENT_RESULT_TERMINATE:
> +	default:
> +		type =3D STK_RESULT_TYPE_USER_TERMINATED;
> +		goto send;
> +
> +	case STK_AGENT_RESULT_CANCEL:
> +		goto out;
> +	}

have you tested this? The STK_AGENT_RESULT_CANCEL will never be reached
since we hit default label first.

As a general rule, default label should always be the last one. And in
case this is an enum, you can just skip default label and let the
compiler warn you about unhandled enum entries.

So just duplicate the code or re-arrange the order and work with a
proper /* fall trough */ comment.

Regards

Marcel



--===============7664149187989895820==--

