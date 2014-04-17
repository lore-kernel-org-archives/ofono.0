Content-Type: multipart/mixed; boundary="===============0093805037956120889=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] mbpi: Parse gsm provider name
Date: Wed, 16 Apr 2014 23:07:54 -0500
Message-ID: <534F539A.3010700@gmail.com>
In-Reply-To: <1397656836-27803-1-git-send-email-slava.monich@jolla.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0093805037956120889==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Slava,

On 04/16/2014 09:00 AM, Slava Monich wrote:
> This gives the provisioning plugin more information to work with and
> improves the chance of automatically picking the right AP in case if
> we have more than one for the same mcc/mnc combination.
> ---
>  include/gprs-provision.h |  1 +
>  plugins/mbpi.c           | 47 ++++++++++++++++++++++++++++++++++++++++++=
+----
>  2 files changed, 44 insertions(+), 4 deletions(-)
> =


I fail to see the point for this patch.  It makes no sense on its own.

> diff --git a/include/gprs-provision.h b/include/gprs-provision.h
> index e9eec61..0129cd0 100644
> --- a/include/gprs-provision.h
> +++ b/include/gprs-provision.h
> @@ -31,6 +31,7 @@ extern "C" {
>  struct ofono_gprs_provision_data {
>  	enum ofono_gprs_context_type type;
>  	enum ofono_gprs_proto proto;
> +	char *provider_name;

I fail to see why this would be required here?  It is not utilized
anywhere else...

Regards,
-Denis

--===============0093805037956120889==--

