Content-Type: multipart/mixed; boundary="===============6517830636502562306=="
MIME-Version: 1.0
From: Aki Niemi <aki.niemi@nokia.com>
Subject: Re: [PATCH 2/4] Enable alphabets in smsutils
Date: Fri, 03 Sep 2010 15:15:51 +0300
Message-ID: <1283516151.25646.2.camel@tucson.research.nokia.com>
In-Reply-To: <4C7FD6E8.206@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6517830636502562306==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Thu, 2010-09-02 at 18:55 +0200, ext Denis Kenzior wrote:
> > -	if (offset !=3D 0)
> > -		template.submit.udhi =3D FALSE;
> > -
> =

> This part doesn't look right.  The check should actually set udhi to
> TRUE, since we can be issuing a return in the next if statement...

That's why it's removed. This was doing nothing before, as offset at
this point was always zero, and the template had anyway been memset to
zero.

> > +enum sms_alphabet {
> > +	SMS_ALPHABET_DEFAULT =3D 0,
> > +	SMS_ALPHABET_TURKISH,
> > +	SMS_ALPHABET_SPANISH,
> > +	SMS_ALPHABET_PORTUGUESE,
> > +	SMS_ALPHABET_REDUCED,
> > +	SMS_ALHPABET_INVALID,
> =

> Why is the INVALID part needed at all?

Removed.

> > +};
> > +
> >  enum sms_mwi_type {
> >  	SMS_MWI_TYPE_VOICE =3D 0,
> >  	SMS_MWI_TYPE_FAX =3D 1,
> > @@ -516,6 +525,11 @@ void status_report_assembly_expire(struct status_r=
eport_assembly *assembly,
> >  					time_t before, GFunc foreach_func,
> >  					gpointer data);
> >  =

> > +GSList *sms_text_prepare_with_alphabet(const char *utf8, guint16 ref,
> > +					gboolean use_16bit, int *ref_offset,
> > +					gboolean use_delivery_reports,
> > +					enum sms_alphabet alphabet);
> > +
> >  GSList *sms_text_prepare(const char *utf8, guint16 ref,
> >  				gboolean use_16bit, int *ref_offset,
> >  				gboolean use_delivery_reports);
> =

> Do you have time to write unit tests for this as well?

I'll do that.

Cheers,
Aki


--===============6517830636502562306==--

