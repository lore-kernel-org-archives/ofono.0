Content-Type: multipart/mixed; boundary="===============1251231125041465231=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCHv2 2/3] doc: Describe DBus method to set delivery-report
Date: Wed, 08 Aug 2012 12:06:58 -0500
Message-ID: <50229CB2.4090800@gmail.com>
In-Reply-To: <1344432106-23105-3-git-send-email-ronald.tessier@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1251231125041465231==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Ronald,

On 08/08/2012 08:21 AM, Ronald Tessier wrote:
> ---
>   doc/service-api.txt |   13 +++++++++++++
>   1 file changed, 13 insertions(+)
>

I applied this patch, but see below.

> diff --git a/doc/service-api.txt b/doc/service-api.txt
> index 02396ff..25f2d0d 100644
> --- a/doc/service-api.txt
> +++ b/doc/service-api.txt
> @@ -82,6 +82,12 @@ Methods		array{object,dict} GetMessages()
>
>   			Possible Errors: [service].Error.InvalidArguments
>
> +		void SetProperty(string name, variant value)
> +
> +			Changes the value of the specified property.
> +
> +			Possible Errors: [service].Error.InvalidArguments
> +

You are still missing GetProperties doc additions and implementation. =

Please send these as separate patches.

Regards,
-Denis

--===============1251231125041465231==--

