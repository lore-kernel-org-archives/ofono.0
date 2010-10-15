Content-Type: multipart/mixed; boundary="===============8679904114078920556=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [RFC PATCH 2/8] simutil: response-handler returns now also
 file-status
Date: Fri, 15 Oct 2010 07:20:46 -0500
Message-ID: <4CB8471E.6030104@gmail.com>
In-Reply-To: <1287090175-3018-3-git-send-email-petteri.tikander@ixonos.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8679904114078920556==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Petteri,

On 10/14/2010 04:02 PM, Petteri Tikander wrote:
> ---
>  src/simutil.c |    5 ++++-
>  src/simutil.h |   10 +++++++++-
>  2 files changed, 13 insertions(+), 2 deletions(-)
> =

>  =

> +/* 51.011 Section 9.3 */
> +enum sim_file_status {
> +	SIM_FILE_STATUS_INVALID			=3D 0x00,

This enum value was not being used and I removed it afterwards.

> +	SIM_FILE_STATUS_VALID			=3D 0x01,
> +	SIM_FILE_STATUS_RW_WHEN_INVALID		=3D 0x04,
> +};
> +

Otherwise, patch looked good and has been applied.

Regards,
-Denis

--===============8679904114078920556==--

