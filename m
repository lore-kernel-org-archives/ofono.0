Content-Type: multipart/mixed; boundary="===============3902849848293344276=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: VS: [RFC PATCH 1/4] SetProperty for UseDeliveryReports.
 smsutil.c/h.
Date: Mon, 07 Jun 2010 13:16:42 -0500
Message-ID: <201006071316.42597.denkenz@gmail.com>
In-Reply-To: <EA8B5A37FEEFC048AF3F8170D2819913B8C1280A50@jklmail01.ixonos.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3902849848293344276==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pasi,

> >  GSList *sms_text_prepare(const char *utf8, guint16 ref,
> > -                               gboolean use_16bit, int *ref_offset);
> > +                               gboolean use_16bit, int *ref_offset,
> > +                               const gboolean use_delivery_reports);
> >
> > gboolean cbs_dcs_decode(guint8 dcs, gboolean *udhi, enum sms_class *cls,
> >                         enum sms_charset *charset, gboolean *compressed,
> =

> Ah, no need for const before gboolean, as Denis said. Do I need to send
>  another patch, or can you remove it?

I applied all four patches and fixed it up for you... This time ;)

Regards,
-Denis

--===============3902849848293344276==--

