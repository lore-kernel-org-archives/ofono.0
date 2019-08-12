Content-Type: multipart/mixed; boundary="===============1768442805757636174=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v2] gprs: Do not detach when running LTE and GPRS is
 unavailable.
Date: Mon, 12 Aug 2019 15:47:14 -0500
Message-ID: <7e251286-c23c-6ac7-2afe-029621544c9a@gmail.com>
In-Reply-To: <20190812203756.32082-1-richard.rojfors@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1768442805757636174==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Richard,

On 8/12/19 3:37 PM, richard.rojfors(a)gmail.com wrote:
> From: Richard R=C3=B6jfors <richard@puffinpack.se>
> =

> There are cases where the gprs status might updated to for instance
> "unknown" while LTE is the bearer.
> In that case we should not set the attach state to FALSE,
> since then running LTE the conext activation reflects the attached
> state.
> ---
>   src/gprs.c | 23 ++++++++++++++++++++---
>   1 file changed, 20 insertions(+), 3 deletions(-)
> =


Applied, thanks.

Regards,
-Denis


--===============1768442805757636174==--

