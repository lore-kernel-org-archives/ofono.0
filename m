Content-Type: multipart/mixed; boundary="===============8651580622031513534=="
MIME-Version: 1.0
From: Neil Jerram <neil@ossau.uklinux.net>
Subject: Re: PATCH: Enable udev-based autodetection of calypso modem on
 Freerunner
Date: Tue, 21 Dec 2010 12:01:00 +0000
Message-ID: <87bp4f9vyb.fsf@ossau.uklinux.net>
In-Reply-To: <4D0FE94B.1010502@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8651580622031513534==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Denis Kenzior <denkenz@gmail.com> writes:

> We prefer if you use git send-email to format the patch for
> submission.

Sure, I will do that in future.  Thanks for looking at the patch anyway.

> I think the better way would be to drop a udev rule directly into
> /etc/udev.d or similar.  The rule should be as simple as:
> KERNEL=3D=3D"ttySAC0", ENV{OFONO_DRIVER}=3D"calypso"

Do you mean in another file than 97-ofono.rules?

> Let me know if this works for you and I can add a comment in the calypso
> plugin.

Will do.  Thanks again,

    Neil

--===============8651580622031513534==--

