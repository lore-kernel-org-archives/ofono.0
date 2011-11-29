Content-Type: multipart/mixed; boundary="===============0344056903831417482=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v0 1/3] doc: Add RoamingAllowed property
Date: Tue, 29 Nov 2011 11:40:39 -0600
Message-ID: <4ED51917.9010808@gmail.com>
In-Reply-To: <1322757634-18468-2-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0344056903831417482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 12/01/2011 10:40 AM, Guillaume Zajac wrote:
> ---
>  doc/cdma-connman-api.txt |    8 ++++++++
>  1 files changed, 8 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/cdma-connman-api.txt b/doc/cdma-connman-api.txt
> index 48699a3..319c973 100644
> --- a/doc/cdma-connman-api.txt
> +++ b/doc/cdma-connman-api.txt
> @@ -45,6 +45,14 @@ Properties	boolean Powered [readwrite]
>  			Holds the password to be used for authentication
>  			purposes.
>  =

> +		boolean RoamingAllowed [readwrite]
> +
> +			Contains whether data roaming is allowed.  In the off
> +			setting, if the packet radio registration state
> +			indicates that the modem is roaming, oFono will
> +			automatically shutdown connection and no further
> +			connection establishment will be possible.
> +

I'm still not convinced this is really needed.  Can you discuss a
specific usecase you are trying to take care of here?

Regards,
-Denis

--===============0344056903831417482==--

