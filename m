Content-Type: multipart/mixed; boundary="===============5644426293176220875=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/7] Return newly-queried barring status.
Date: Thu, 18 Mar 2010 11:39:35 -0500
Message-ID: <201003181139.35438.denkenz@gmail.com>
In-Reply-To: <1268923471-29059-2-git-send-email-ppessi@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5644426293176220875==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

>  	for (i =3D cb->query_start; i <=3D cb->query_end; i++) {
>  		cb->cur_locks[i] =3D cb->new_locks[i];
> -		cb->new_locks[i] =3D 0;
>  	}

Can you also ensure that if a loop / if statement no longer requires braces =

that your patch also takes care of that too?  I fixed it up for you afterwa=
rd.

Patch has been applied, thanks.

Regards,
-Denis

Regards,
-Denis

--===============5644426293176220875==--

