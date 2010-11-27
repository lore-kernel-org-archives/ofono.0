Content-Type: multipart/mixed; boundary="===============5666206557652062655=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: [PATCH 1/9] coding-style: add rule about checking NULL pointer
Date: Sat, 27 Nov 2010 07:57:47 -0800
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702CCBC85@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <1290872345-15698-2-git-send-email-lucas.demarchi@profusion.mobi>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5666206557652062655==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Lucas
  =

> +M13: Check for pointer being NULL
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +When checking if a pointer or a return value is NULL, explicitly =

> +compare to NULL rather than use the shorter check with "!" operator.
> +
> +Example:
> +1)
> +array =3D g_try_new0(int, 20);
> +if (!array)	// Wrong
> +	return;
> +
> +2)
> +if (!g_at_chat_get_slave(chat))	// Wrong
> +	return -EINVAL;
> +
> +3)
> +array =3D g_try_new0(int, 20);
> +if (!array)	// Correct

Shouldn't be if (array =3D=3D NULL) // Correct :)?

BR,
Rajesh

--===============5666206557652062655==--

