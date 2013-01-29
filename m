Content-Type: multipart/mixed; boundary="===============3292259578931236362=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v1 3/8] hfp_hf_bluez5: Add SCO listen socket
Date: Tue, 29 Jan 2013 09:02:26 -0600
Message-ID: <5107E482.90606@gmail.com>
In-Reply-To: <1359407468-5110-4-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3292259578931236362==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Claudio,

On 01/28/2013 03:11 PM, Claudio Takahasi wrote:
> This patch adds the initial SCO server socket handling. BtIO and BlueZ
> functions should not be used, with the new Profile API the objetive is
> to get rid of these dependencies.
> ---
>   plugins/hfp_hf_bluez5.c | 77 ++++++++++++++++++++++++++++++++++++++++++=
+++++++
>   1 file changed, 77 insertions(+)
>

Patch has been applied, however I had to amend:

> +	if (setsockopt(sk, SOL_BLUETOOTH, BT_DEFER_SETUP,
> +				&defer_setup, sizeof(defer_setup))<  0) {
> +		ofono_warn("Can't enable deferred setup: %s (%d)",
> +						strerror(errno), errno);
> +	}

These brackets are not necessary.  Also, in the future you might want to =

set a flag here indicating that only HFP 1.5 support is available.

Regards,
-Denis

--===============3292259578931236362==--

