Content-Type: multipart/mixed; boundary="===============8551410948180488788=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] TODO: Add vCard export to SM/ME stores
Date: Fri, 12 Nov 2010 17:29:35 +0900
Message-ID: <1289550575.3266.103.camel@aeonflux>
In-Reply-To: <1289543973-7518-1-git-send-email-jaakko.j.kiviluoto@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8551410948180488788==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jaakko,

>  TODO |   11 +++++++++++
>  1 files changed, 11 insertions(+), 0 deletions(-)
> =

> diff --git a/TODO b/TODO
> index bf2305b..9dcb43f 100644
> --- a/TODO
> +++ b/TODO
> @@ -496,3 +496,14 @@ Miscellaneous
>  =

>    Priority: Low
>    Complexity: C4
> +
> +- Enable exporting contact information from vCard data to SM and ME stor=
es.
> +  Need to implement a robust vCard parser that can extract at least the
> +  fields supported by the existing phonebook module.  Functionality shou=
ld
> +  be analoguous to existing import functionality.

and you will not be able to write a robust vCard parser that we can
safely run as root or with any kind of ofonod privileges. It is just way
too risky from a security point of view.

To support this feature then first we need to convert the current
feature into returning a dict. And then have this feature using a dict
as input.

Regards

Marcel



--===============8551410948180488788==--

