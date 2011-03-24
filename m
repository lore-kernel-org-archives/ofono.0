Content-Type: multipart/mixed; boundary="===============0145998867587015742=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gatserver: add v250 ATL and ATM commands
Date: Thu, 24 Mar 2011 13:29:10 -0500
Message-ID: <4D8B8D76.3000507@gmail.com>
In-Reply-To: <1300964569-6164-1-git-send-email-olivier.guiter@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0145998867587015742==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Olivier,

> +static void at_l_cb(GAtServer *server, GAtServerRequestType type,
> +			GAtResult *result, gpointer user_data)
> +{
> +	s_template_cb(type, result, server, &server->v250.s5, "L", 0, 3);

Copy paste error?  I presume you mean v250.l here

Regards,
-Denis

--===============0145998867587015742==--

