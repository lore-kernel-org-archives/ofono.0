Content-Type: multipart/mixed; boundary="===============3206677336479933873=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Fix issue with AT parser in gatserver
Date: Thu, 07 Jul 2011 01:02:34 -0500
Message-ID: <4E154BFA.50504@gmail.com>
In-Reply-To: <1310048369-31394-1-git-send-email-frederic.dalleau@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3206677336479933873==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Fr=C3=A9d=C3=A9ric,

On 07/07/2011 09:19 AM, Fr=C3=A9d=C3=A9ric Dalleau wrote:
> This patch fix an issue with AT parser in gatserver.
> =

> If an empty command is issued after AT, then 2 answers are sent. The pars=
er can
> also get in a bad state where next commands will not be handled. After th=
at the
> parser will get back on his feets. This is caused by reentrency: =

> new_bytes() calls g_at_server_send_final(), which in turns calls server_r=
esume
> which calls new_bytes() again synchronously.
> =


We should not try to set the read handler if it already set.  Have you
tried adding:

if (server->suspended =3D=3D FALSE)
	return;

to server_resume()?

Regards,
-Denis

--===============3206677336479933873==--

