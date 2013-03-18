Content-Type: multipart/mixed; boundary="===============1977430955143560513=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0 02/15] hfp_hf_bluez5: Register handsfree audio driver
Date: Mon, 18 Mar 2013 13:59:17 -0500
Message-ID: <51476405.9040502@gmail.com>
In-Reply-To: <1363092133-1092-3-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1977430955143560513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 03/12/2013 07:42 AM, Claudio Takahasi wrote:
> This patch registers the Handsfree Audio Card driver for devices
> compliant with HFP 1.5.
> ---
>   plugins/hfp_hf_bluez5.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>

For direct SCO connections I'd like to not require a dedicated driver =

(since it will be needed by HFP AG as well).  Perhaps if there is no =

driver registered we should fall back to direct SCO connection behavior.

Regards,
-Denis

--===============1977430955143560513==--

