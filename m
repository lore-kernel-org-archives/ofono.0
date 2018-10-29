Content-Type: multipart/mixed; boundary="===============8828225271889137692=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 6/9] stkutil: remove test for impossible condition
Date: Mon, 29 Oct 2018 13:59:38 -0500
Message-ID: <582439e5-df7f-6e3d-b20a-335cae2bd97a@gmail.com>
In-Reply-To: <20181026101319.27709-7-jonas@norrbonn.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8828225271889137692==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 10/26/2018 05:13 AM, Jonas Bonn wrote:
> From: Jonas Bonn <jonas@southpole.se>
> =

> 'string' is an array and therefore never NULL so this test always fails.
> ---
>   src/stkutil.c | 3 ---
>   1 file changed, 3 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============8828225271889137692==--

