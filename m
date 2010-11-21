Content-Type: multipart/mixed; boundary="===============4083722333005001374=="
MIME-Version: 1.0
From: Sjur =?unknown-8bit?q?Br=C3=A6ndeland?= <sjurbren@gmail.com>
Subject: Re: [PATCH v2 2/2] stemodem: Use RTNL to create network interfaces.
Date: Sun, 21 Nov 2010 23:54:17 +0100
Message-ID: <AANLkTikfA8LJ_-hrR1gXipTiv9UR0FQzsOFY1d6xKc8G@mail.gmail.com>
In-Reply-To: <d34704fde1df023d47b287f4dad2a528.squirrel@squirrel-webmail.surftown.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4083722333005001374==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi George.

> it looks as if two functions:
>
> caif_if_create/remove (struct conn_info *conn)
>
> do nothing but verify the return results of functions:
>
> caif_rtnl_create_interface/caif_rtnl_delete_interface
>
> declared in in =C2=A0caif_rtnl.h
>
> Which means if you #include caif_rtnl.h in gprs-context.c
> create/delete_interface will be available directly without any wrappers
> and could make your code run a bit faster and easier to understand?
> Unless I missed something.

Thank you for reviewing this patch :-)
Yes, you are right concerning caif_if_create, I'll change this.
But caif_if_remove needs to stay as is,
it is called from g_slist_foreach and must have the list node as argument.

BTW you should take a look at http://ofono.org/wiki/ofono-etiquette.
Top-posting is not exactly popular on this list ;-)

Regards,
Sjur

--===============4083722333005001374==--

