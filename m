Content-Type: multipart/mixed; boundary="===============8849198156667363913=="
MIME-Version: 1.0
From: Jeevaka.Badrappan@elektrobit.com
Subject: RE: [PATCH] stkutil: fix crash issue cause by null length of text
 string
Date: Tue, 07 Dec 2010 23:55:46 +0200
Message-ID: <B668883EB5DD7144ADFC248A72176EA802C40DAC@fioues07.ebgroup.elektrobit.com>
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D40188136D95B11@irsmsx501.ger.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8849198156667363913==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi Guillaume,
 =

> =

> According to 3GPP TS 31.124 a null length for the text string =

> should be allowed. An empty string must be returned to the =

> user in this case.
> ---
>  src/stkutil.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> =


Agree. As per the 3GPP TS 31.124 null text string will be indicated with
length 0.
So, in first place if (text =3D=3D NULL) check in handle_command_get_input, =

handle_command_get_inkey has to be removed. Removing this check will
result
in crash due to the fact that we are not handling this case properly
neither
in parse_dataobj_text nor in corresponding stkagent functions.

There are 2ways to solve this issue:

First option - Fix provided in the function parse_dataobj_text( e.g.
*text =3D "")
Second option - In all the stk_agent_ function which has this text
string we =

                need to check for NULL and assign it to empty string if
it is NULL.
      =

First option seems to be right and also better one.

In both the cases, if (text =3D=3D NULL) check in handle_command_get_inkey,
handle_command_get_input etc needs to be removed.

Regards,
Jeevaka

--===============8849198156667363913==--

