Content-Type: multipart/mixed; boundary="===============0002800582258324780=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] mbim: add an optional TEMP_FAILURE_RETRY macro copy
Date: Fri, 24 May 2019 11:57:18 -0500
Message-ID: <d2308267-d504-8b6d-20bf-cdf016138317@gmail.com>
In-Reply-To: <20190524012030.28913-1-raj.khem@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0002800582258324780==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/23/2019 08:20 PM, Khem Raj wrote:
> Fixes build on musl which does not provide this macro
> =

> Signed-off-by: Khem Raj <raj.khem@gmail.com>

No Signed-off-by for oFono patch submissions please

> ---
>   drivers/mbimmodem/mbim-private.h | 9 +++++++++
>   1 file changed, 9 insertions(+)
> =


I solved this by introducing L_TFR in ell, commit:
8198b3689490eb81fdc7ce42f4ec1ac7321a1e3c

And reworked all use of TFR/TEMP_FAILURE_RETRY to use that instead.

Regards,
-Denis

--===============0002800582258324780==--

