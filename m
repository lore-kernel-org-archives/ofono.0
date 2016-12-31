Content-Type: multipart/mixed; boundary="===============2444201214013281125=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] smsutil: Prevent out of bounds reads in cbs_decode_text
Date: Fri, 30 Dec 2016 18:20:06 -0600
Message-ID: <79393124-5502-430d-ac12-033ce22ccbb7@gmail.com>
In-Reply-To: <1483292882-18897-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2444201214013281125==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 01/01/2017 11:48 AM, Slava Monich wrote:
> Valgrind was complaining about it like this:
>
> =3D=3D18099=3D=3D Conditional jump or move depends on uninitialised value=
(s)
> =3D=3D18099=3D=3D    at 0x4C32281: strspn
> =3D=3D18099=3D=3D    by 0x41286B: cbs_decode_text (smsutil.c:4140)
> =3D=3D18099=3D=3D    by 0x40675C: test_cbs_encode_decode (test-sms.c:1417)
> ---
>  src/smsutil.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>

Applied, thanks.

Regards,
-Denis


--===============2444201214013281125==--

