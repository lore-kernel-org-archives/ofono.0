Content-Type: multipart/mixed; boundary="===============2194496197624236884=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 3/4] stk: Handling of Send USSD proactive command
Date: Wed, 15 Sep 2010 12:15:20 -0500
Message-ID: <4C90FF28.3010903@gmail.com>
In-Reply-To: <1284500992-20180-1-git-send-email-jeevaka.badrappan@elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2194496197624236884==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jeevaka,

On 09/14/2010 04:49 PM, Jeevaka Badrappan wrote:
> ---
>  src/stk.c |  173 +++++++++++++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 files changed, 172 insertions(+), 1 deletions(-)
>

This patch has been applied, but refactored afterward.

> +			rsp.result.type =3D STK_RESULT_TYPE_USSD_RETURN_ERROR;
> +			rsp.result.additional =3D (unsigned char *) &error;
> +			rsp.result.additional_len =3D 1;

This part made no sense to me, why are we sending our internal error
enum to the SIM?

Regards,
-Denis

--===============2194496197624236884==--

