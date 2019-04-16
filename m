Content-Type: multipart/mixed; boundary="===============0705118866186961186=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] gprs: Always store RoamingAllowed as a boolean.
Date: Tue, 16 Apr 2019 11:46:33 -0500
Message-ID: <d93ad775-f2cd-39e5-a089-e22d6b64d242@gmail.com>
In-Reply-To: <20190416060926.9021-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0705118866186961186==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 04/16/2019 01:09 AM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> In one instance it was stored as boolean and another as int.
> Since its always parsed as a boolean and it is a boolean,
> always store it as boolean.
> ---
>   src/gprs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> =


Applied, thanks.

Regards,
-Denis

--===============0705118866186961186==--

