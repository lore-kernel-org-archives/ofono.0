Content-Type: multipart/mixed; boundary="===============8067517373872831171=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH_v0 1/6] doc: Add DormantInterval property
Date: Wed, 07 Dec 2011 06:34:41 -0600
Message-ID: <4EDF5D61.8080609@gmail.com>
In-Reply-To: <1323273951-24162-2-git-send-email-guillaume.zajac@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8067517373872831171==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Guillaume,

On 12/07/2011 10:05 AM, Guillaume Zajac wrote:
> ---
>  doc/cdma-connman-api.txt |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
> =

> diff --git a/doc/cdma-connman-api.txt b/doc/cdma-connman-api.txt
> index 48699a3..a6d1e56 100644
> --- a/doc/cdma-connman-api.txt
> +++ b/doc/cdma-connman-api.txt
> @@ -35,6 +35,11 @@ Properties	boolean Powered [readwrite]
>  			Contains whether the connection is dormant.  Will
>  			always be false if the connection is not powered.
>  =

> +		int DormantInterval [readwrite]
> +
> +			Contains the interval in seconds to enter in dormant
> +			Mode.
> +

Why would the user want to mess with this setting? What would be the
right interval?  Remember, oFono only exports settings that are useful
to show to the user, and that the user can understand what to do with.
This this one certainly doesn't fit the above description.

Besides, we should simply disable dormancy mode in the first place.  The
base station can more intelligently manage that anyway.

>  		string Username [readwrite]
>  =

>  			Holds the username to be used for authentication

Regards,
-Denis

--===============8067517373872831171==--

