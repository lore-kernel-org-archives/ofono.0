Content-Type: multipart/mixed; boundary="===============1938586339094808250=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v0 2/2] hfp_hf_bluez5: Only register modems for Paired
 devices
Date: Wed, 30 Jan 2013 21:44:23 -0600
Message-ID: <5109E897.2020800@gmail.com>
In-Reply-To: <1359563056-24294-2-git-send-email-claudio.takahasi@openbossa.org>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1938586339094808250==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Vinicius,

On 01/30/2013 10:24 AM, Claudio Takahasi wrote:
> From: Vinicius Costa Gomes<vinicius.gomes@openbossa.org>
>
> When there are many devices around that support the HFP AG profile,
> we may have a lot of modems that the user will never use.
> ---
>   plugins/hfp_hf_bluez5.c | 61 +++++++++++++++++++++++++++++++++---------=
-------
>   1 file changed, 41 insertions(+), 20 deletions(-)
>

Patch has been applied, however:

> -	if (g_str_equal("Alias", name) =3D=3D FALSE)
> +	if (g_str_equal("Paired", name) =3D=3D TRUE) {
> +		modem_register_from_proxy(proxy, path);
>   		return;
> +	}

This part looks suspicious in the case where Paired goes to false.  If =

BlueZ behaves in a certain way when the device is unpaired then I'd like =

to see a comment here explaining that.

Regards,
-Denis

--===============1938586339094808250==--

