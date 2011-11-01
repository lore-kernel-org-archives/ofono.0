Content-Type: multipart/mixed; boundary="===============4816509729678020953=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH v5] hfp_hf: BT address exposed through Serial property
Date: Tue, 01 Nov 2011 18:52:51 -0500
Message-ID: <4EB08653.5030400@gmail.com>
In-Reply-To: <1320241555-16727-1-git-send-email-mikel.astiz@bmw-carit.de>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4816509729678020953==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Mikel,

On 11/02/2011 08:45 AM, Mikel Astiz wrote:
> The devinfo atom is created in pre_sim (instead of probe).
> ---
>  plugins/hfp_hf.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
> =


Patch has been applied, I did fix up a minor style violation in a follow
on commit:
> @@ -239,6 +246,10 @@ static int hfp_hf_probe(const char *device, const ch=
ar *dev_addr,
>  	return 0;
>  =

>  free:
> +	if (data !=3D NULL) {
> +		g_free(data->handsfree_path);
> +	}
> +

The brackets are not needed...

Regards,
-Denis

--===============4816509729678020953==--

