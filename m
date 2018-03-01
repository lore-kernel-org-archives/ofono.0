Content-Type: multipart/mixed; boundary="===============1886788324911748232=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 1/4] qmi: add LTE atom driver
Date: Thu, 01 Mar 2018 08:50:16 -0600
Message-ID: <29677724-540d-a05a-1f0a-2ab53261f44b@gmail.com>
In-Reply-To: <20180301104804.24058-2-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1886788324911748232==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 03/01/2018 04:48 AM, Jonas Bonn wrote:
> This patch adds an LTE atom for QMI modems.
> =

> This atom sets the APN that the LTE default bearer should use when
> establishing its PDP context.  For the Quectel EC21 that I'm testing
> with, this is effected by setting the APN on profile ID 1 from which the
> default settings appear to be taken.  As I don't have any other QMI
> modem to test with, I can not say for sure that all modems work in this
> manner.
> =

> Once configured, the default profile settings are used when the
> modem connects to the network; for this reason, the LTE atom needs
> to be instantiated in post_sim, before the modem is set online.
> ---
>   Makefile.am            |   1 +
>   drivers/qmimodem/lte.c | 182 ++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   2 files changed, 183 insertions(+)
>   create mode 100644 drivers/qmimodem/lte.c
> =


Please merge patch 1 & 2 together, that's how we usually do it anyway.

> +struct lte_data {
> +	struct qmi_service *wds;
> +	char* apn;
> +};

Why do you need the apn?  I don't see it used anywhere.  Also not our =

style, should be char *apn.

The rest looks fine to me.

Regards,
-Denis

--===============1886788324911748232==--

