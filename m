Content-Type: multipart/mixed; boundary="===============2277847083733649469=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [SMS D-Bus 08/23] export sms_assembly_encode_address
Date: Wed, 07 Jul 2010 16:28:58 -0700
Message-ID: <1278545338.2327.134.camel@localhost.localdomain>
In-Reply-To: <4C350642.7050304@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2277847083733649469==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Wed, 2010-07-07 at 15:57 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> >  void sms_assembly_expire(struct sms_assembly *assembly, time_t before);
> > +gboolean sms_assembly_encode_address(const struct sms_address *in,
> > +				     char *straddr);
> >  =

> >  struct status_report_assembly *status_report_assembly_new(const char *=
imsi);
> >  void status_report_assembly_free(struct status_report_assembly *assemb=
ly);
> =

> Can we rename this into sms_address_to_hex_string?  That seems to
> reflect the intent a bit better.

Ok -- this will then touch a few more other sites in the code.



--===============2277847083733649469==--

