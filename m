Content-Type: multipart/mixed; boundary="===============0480482243848414612=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 2/2] atmodem/atutil: at_util_get_cgdcont_command
Date: Mon, 22 Oct 2018 15:06:31 -0500
Message-ID: <69badd78-c5f2-30a7-7e51-d1a3908be311@gmail.com>
In-Reply-To: <20181022185608.27760-2-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0480482243848414612==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 10/22/2018 01:56 PM, Giacinto Cifelli wrote:
> The function at_util_get_cgdcont_command computes the AT+CGDCONT
> string, as per 3GPP 27.007.
> It uses a second function, at_util_gprs_proto_to_pdp_type,
> that returns the pdp_type string for the command
> ---
>   drivers/atmodem/atutil.c | 27 +++++++++++++++++++++++++++
>   drivers/atmodem/atutil.h | 13 +++++++++++++
>   2 files changed, 40 insertions(+)
> =


Applied, thanks.

Regards,
-Denis


--===============0480482243848414612==--

