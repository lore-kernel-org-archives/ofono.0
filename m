Content-Type: multipart/mixed; boundary="===============1597892285639644763=="
MIME-Version: 1.0
From: Giacinto Cifelli <gciofono@gmail.com>
Subject: Re: [PATCH 1/3] radio-settings: adding UE dual mode operation property
Date: Mon, 13 May 2019 10:54:17 +0200
Message-ID: <CAKSBH7H_+b2N-+mjactBsBrMQfr+b0RD7UOyqP3UtBcXi_DrBA@mail.gmail.com>
In-Reply-To: <1557737355-25408-1-git-send-email-antara.borwankar@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1597892285639644763==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Antara,

On Mon, May 13, 2019 at 10:46 AM Antara Borwankar
<antara.borwankar@intel.com> wrote:
>
> Added two new values for TechnologyPreference property
> as follows:
> "umts,gsm"      Dual mode operation with UMTS
>                 and GSM radio access whith preference
>                 for UMTS.
> "lte,umts"      Dual mode operation with LTE
>                 and UMTS radio access with preference
>                 for LTE.

It looks like an explosive list.
First of all, there are several use cases for gsm+lte, which should
also be added.
But then there will be a 5g to the list, and all possible combinations
of technologies, and most likely there should be a split for LTE, with
normalLTE, catM and NB-IoT, and all the possible combinations thereof.
I would prefer to have it as a vendor-specific extension, so that the
combinations can also be controlled at the model level.

> ---
>  doc/radio-settings-api.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/doc/radio-settings-api.txt b/doc/radio-settings-api.txt
> index 03868a9..9663b07 100644
> --- a/doc/radio-settings-api.txt
> +++ b/doc/radio-settings-api.txt
> @@ -44,6 +44,12 @@ Properties   string TechnologyPreference [readwrite]
>                                 "gsm"   Only GSM used for radio access.
>                                 "umts"  Only UMTS used for radio access.
>                                 "lte"   Only LTE used for radio access.
> +                               "umts,gsm"      Dual mode operation with =
UMTS
> +                                       and GSM radio access whith prefer=
ence
> +                                       for UMTS.
> +                               "lte,umts"      Dual mode operation with =
LTE
> +                                       and UMTS radio access with prefer=
ence
> +                                       for LTE.
>
>                 array{string} AvailableTechnologies [readonly, optional]
>
> --
> 1.9.1
>
> _______________________________________________
> ofono mailing list
> ofono(a)ofono.org
> https://lists.ofono.org/mailman/listinfo/ofono

--===============1597892285639644763==--

