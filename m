Content-Type: multipart/mixed; boundary="===============5279511549424066482=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] qmimodem: add debug helper qmi_result_tlv_walk
Date: Tue, 16 May 2017 13:09:52 -0500
Message-ID: <107d77aa-0854-2005-3f4d-91089a56772b@gmail.com>
In-Reply-To: <20170516133807.32368-1-lynxis@fe80.eu>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============5279511549424066482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alexander,

On 05/16/2017 08:38 AM, Alexander Couzens wrote:
> qmi_result_tlv_walk prints the type and length field
> of a result to DBG()
> ---
>  drivers/qmimodem/qmi.c | 17 +++++++++++++++++
>  drivers/qmimodem/qmi.h |  2 +-
>  2 files changed, 18 insertions(+), 1 deletion(-)
>

<snip>

> -
> +void qmi_result_tlv_walk(struct qmi_result *result);
>

Can we name this a bit more descriptively?  qmi_result_dump, or =

qmi_result_print_tlvs, qmi_result_print, etc.

Regards,
-Denis

--===============5279511549424066482==--

