Content-Type: multipart/mixed; boundary="===============1663594214825881054=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v1] Read EF_ICCID property of SIM
Date: Wed, 19 May 2010 23:52:36 -0500
Message-ID: <201005192352.36288.denkenz@gmail.com>
In-Reply-To: <20100520100148.GA18006@gumpy.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1663594214825881054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Daniel,

> Tested with phonesim.
> =

> +#define OFONO_MAX_ICCID_LENGTH 20
> +

For future reference, if a define is not used or planned to be used by plug=
ins, =

there's no need to declare it in the public API.  I fixed it for you :)

Patch has been applied.

Thanks,
-Denis

--===============1663594214825881054==--

