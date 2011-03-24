Content-Type: multipart/mixed; boundary="===============8947856317176400636=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] Set owner CSSU/CSSI support task
Date: Thu, 24 Mar 2011 13:33:17 -0500
Message-ID: <4D8B8E6D.8070500@gmail.com>
In-Reply-To: <1300991378-24934-1-git-send-email-nicolas.bertrand@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8947856317176400636==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

On 03/24/2011 01:29 PM, Nicolas Bertrand wrote:
> ---
>  TODO |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
> =


In the future please prefix TODO changes with TODO:.  E.g. TODO: Set
Owner...

> diff --git a/TODO b/TODO
> index ed644c9..6769906 100644
> --- a/TODO
> +++ b/TODO
> @@ -21,3 +21,7 @@ Call Management
>  - Add support for +CSSU / +CSSI notifications.  These can be used to sim=
ulate
>    the remote party putting the call on hold, retrieving or creating an m=
pty
>    call.
> +
> +  Priority: Low
> +  Complexity: C1
> +  Owner: Nicolas Bertrand <nicolas.bertrand@linux.intel.com>
> \ No newline at end of file

Please configure your editor to include an newline at EOF.

I fixed these for you and pushed the patch, thanks.

Regards,
-Denis

--===============8947856317176400636==--

