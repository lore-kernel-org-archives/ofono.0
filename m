Content-Type: multipart/mixed; boundary="===============7440013207753926043=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Subject: RFC Migrate from RFC2822 to ISO8601 for time
 representations
Date: Mon, 19 Oct 2009 12:20:15 -0500
Message-ID: <200910191220.15942.denkenz@gmail.com>
In-Reply-To: <1255901578.3235.0.camel@raptor>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7440013207753926043==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Olivier,

> the format used to represent time in ofono is currently RFC2822 which is
> complex and a bit deprecated. I think it would be better to move to
> ISO8601 which is a well used and supported [1] format and simpler to pars=
e.

So I don't have a problem with the patch, since RFC822 does indeed have iss=
ues =

with i18n.  However, this will break existing applications which will need =
to =

be updated to the new format.

If no one objects in the next 24 hours or so I will apply this one.

Regards,
-Denis

--===============7440013207753926043==--

