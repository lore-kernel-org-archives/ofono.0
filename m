Content-Type: multipart/mixed; boundary="===============1280399298977684412=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 5/5] Implement STATUS polling in atmodem driver,
 enable it for phonesim & atgen.
Date: Wed, 31 Mar 2010 11:42:23 -0700
Message-ID: <1270060943.22331.4.camel@localhost.localdomain>
In-Reply-To: <1270011519-6947-1-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1280399298977684412==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrzej,

> +
> +	if (!g_at_result_iter_next_hexstring(&iter, &response, &len))
> +		return;
> +
> +	if (rlen !=3D len * 2 || len < 2 || (response[len - 2] !=3D 0x90 &&
> +				response[len - 2] !=3D 0x91) ||
> +			(response[len - 2] =3D=3D 0x90 && response[len - 1] !=3D 0))
> +		return;
> +

let me re-write this into something readable ;)

	if (len < 2 || rlen !=3D len * 2)
		return;

	if (response[len - 2] !=3D 0x90 || response[len - 2] !=3D 0x91)
		return;

	if (response[len - 2] =3D=3D 0x90 && response[len - 1] !=3D 0)
		return;

And please add comments on top of the if statements to explain what they
are checking for.

Regards

Marcel



--===============1280399298977684412==--

