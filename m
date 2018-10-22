Content-Type: multipart/mixed; boundary="===============8226973679644697030=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] atmodem/atutil: at_util_gprs_proto_to_pdp_type
Date: Mon, 22 Oct 2018 15:04:10 -0500
Message-ID: <3bc03dbb-985d-1250-86ee-2bdd9478489d@gmail.com>
In-Reply-To: <20181022185608.27760-1-gciofono@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8226973679644697030==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Giacinto,

On 10/22/2018 01:56 PM, Giacinto Cifelli wrote:
> This function converts the ofono enum ofono_gprs_auth_method
> into the value of the 3GPP 27.007 to pass to the AT command
> ---
>   drivers/atmodem/atutil.c | 16 ++++++++++++++++
>   drivers/atmodem/atutil.h |  3 +++
>   2 files changed, 19 insertions(+)
> =


Your commit header does not match the patch contents or description. =

You might want to slow down a bit.

Anyway, I renamed this to at_util_gprs_auth_method_to_auth_proto to =

match 3GPP naming & the naming of the pdp_type conversion function in =

the next patch.  And fixed up the commit description / header.

Applied, thanks.

Regards,
-Denis

--===============8226973679644697030==--

