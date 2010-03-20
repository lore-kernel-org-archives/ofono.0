Content-Type: multipart/mixed; boundary="===============1609485820618424299=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [patch 1/6] Add PPP protocol support with HDLC framing
Date: Sat, 20 Mar 2010 16:33:32 +0100
Message-ID: <1269099212.2700.179.camel@localhost.localdomain>
In-Reply-To: <20100319124607.6655ec44@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1609485820618424299==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> This patch implements the basic PPP protocol.  LCP, NCP etc. are handled =
in a
> different patch.
> =

> ---
>  Makefile.am      |    4 =

>  gatchat/gatppp.c |  133 ++++++++++++++++
>  gatchat/gatppp.h |   59 +++++++
>  gatchat/ppp.c    |  455 ++++++++++++++++++++++++++++++++++++++++++++++++=
+++++++
>  gatchat/ppp.h    |  130 +++++++++++++++
>  5 files changed, 780 insertions(+), 1 deletion(-)

please keep the patches whitespace clean. Otherwise you will make it
really hard and complicated for everybody if we have to do whitespace
cleanup in between patches.

Applying: Add PPP protocol support with HDLC framing
/data/devel/ofono/.git/rebase-apply/patch:572: space before tab in indent.
        	if (status !=3D G_IO_STATUS_NORMAL && status !=3D G_IO_STATUS_AGAI=
N)
/data/devel/ofono/.git/rebase-apply/patch:573: space before tab in indent.
                	return FALSE;
fatal: 2 lines add whitespace errors.

Using an editor that visualizes whitespaces and tabs might help here.

And empty lines at the end of a file. Please remove them and if your
editor is too stupid, then please pick a different editor.

Applying: Add PPP protocol support with HDLC framing
/data/devel/ofono/.git/rebase-apply/patch:166: new blank line at EOF.
+
/data/devel/ofono/.git/rebase-apply/patch:230: new blank line at EOF.
+
fatal: 2 lines add whitespace errors.

Before you submit any patches, you might wanna quickly check with git am
that they still apply. My .gitconfig uses a strict apply policy:

[diff]
	color =3D auto
	check =3D true
[apply]
	whitespace =3D error
[format-patch]
	check =3D true

Having diff and format-patch color your whitespace damages is always a
good idea. Then you see what is wrong.

Regards

Marcel



--===============1609485820618424299==--

