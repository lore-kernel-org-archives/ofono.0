Content-Type: multipart/mixed; boundary="===============3795229581433286949=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [SMS D-Bus 08/23] export sms_assembly_encode_address
Date: Wed, 07 Jul 2010 17:57:06 -0500
Message-ID: <4C350642.7050304@gmail.com>
In-Reply-To: <17909479c05535fa1100ecc9c0318ddab79cfc64.1277507431.git.inaky.perez-gonzalez@intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3795229581433286949==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Inaky,

>  void sms_assembly_expire(struct sms_assembly *assembly, time_t before);
> +gboolean sms_assembly_encode_address(const struct sms_address *in,
> +				     char *straddr);
>  =

>  struct status_report_assembly *status_report_assembly_new(const char *im=
si);
>  void status_report_assembly_free(struct status_report_assembly *assembly=
);

Can we rename this into sms_address_to_hex_string?  That seems to
reflect the intent a bit better.

Regards,
-Denis

--===============3795229581433286949==--

