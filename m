Content-Type: multipart/mixed; boundary="===============0952222600150727077=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] unit: Avoid use of uninitialised data in test-simutil
Date: Thu, 24 Aug 2017 17:28:33 -0500
Message-ID: <3b166e53-12d0-cb7b-6d95-787e4b58b903@gmail.com>
In-Reply-To: <1503613051-17235-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0952222600150727077==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 08/24/2017 05:17 PM, Slava Monich wrote:
> GTest: run: /testsimutil/ber tlv encode EFpnn
> =3D=3D16777=3D=3D Conditional jump or move depends on uninitialised value=
(s)
> =3D=3D16777=3D=3D    at 0x4068CB: ber_tlv_iter_next (simutil.c:369)
> =3D=3D16777=3D=3D    by 0x406C39: ber_tlv_find_by_tag (simutil.c:483)
> =3D=3D16777=3D=3D    by 0x407E1D: sim_eons_add_pnn_record (simutil.c:1027)
> =3D=3D16777=3D=3D    by 0x402C39: test_ber_tlv_builder_efpnn (test-simuti=
l.c:181)
> =3D=3D16777=3D=3D    by 0x4EA3A80: g_test_run_suite_internal
> =3D=3D16777=3D=3D    by 0x4EA3F9A: g_test_run_suite
> =3D=3D16777=3D=3D    by 0x4EA3FD0: g_test_run
> =3D=3D16777=3D=3D    by 0x4042FA: main (test-simutil.c:518)
> ---
>   unit/test-simutil.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============0952222600150727077==--

