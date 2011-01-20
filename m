Content-Type: multipart/mixed; boundary="===============2223267744227511756=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/2] simutil: SIM applications directory decoding utils.
Date: Thu, 20 Jan 2011 11:24:19 -0600
Message-ID: <4D386FC3.1070703@gmail.com>
In-Reply-To: <1295424478-12049-2-git-send-email-andrew.zaborowski@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2223267744227511756==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 01/19/2011 02:07 AM, Andrzej Zaborowski wrote:
> ---
>  src/simutil.c |   57 +++++++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  src/simutil.h |    8 ++++++++
>  2 files changed, 65 insertions(+), 0 deletions(-)
> =


Patch has been applied with one minor amend on my part:

> +struct ofono_sim_app_record {
> +	unsigned char aid[16];
> +	int aid_len;
> +	char *label;
> +};
> +

The struct name was changed to sim_app_record since it is not part of
the ofono public / private API.

Regards,
-Denis

--===============2223267744227511756==--

