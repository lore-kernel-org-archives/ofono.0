Content-Type: multipart/mixed; boundary="===============6393290251517272328=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] plugins: quectel: Fix compiler warning
Date: Tue, 24 Sep 2019 09:55:09 -0500
Message-ID: <9f5674c3-38a0-d8ef-9ebd-55f3bb9a8aad@gmail.com>
In-Reply-To: <20190922205321.3438-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6393290251517272328==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 9/22/19 3:53 PM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> plugins/quectel.c: In function =E2=80=98quectel_pre_sim=E2=80=99:
> plugins/quectel.c:1150:20: error: unused variable =E2=80=98sim=E2=80=99 [=
-Werror=3Dunused-variable]
>    struct ofono_sim *sim;
> ---
>   plugins/quectel.c | 1 -
>   1 file changed, 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis


--===============6393290251517272328==--

