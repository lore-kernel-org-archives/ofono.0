Content-Type: multipart/mixed; boundary="===============4264927289942735574=="
MIME-Version: 1.0
From: Su, Yong <Yong.Su@windriver.com>
Subject: RE: [PATCH] Add support for text mode SMS sending
Date: Tue, 24 Aug 2010 04:04:07 -0700
Message-ID: <C6FAFDDBC4402D44BFC43E57565F021903A4E500@ala-mail09.corp.ad.wrs.com>
In-Reply-To: <1282646727.6841.18.camel@localhost.localdomain>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4264927289942735574==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hi, Marcel,
 =


> -----Original Message-----
> From: Marcel Holtmann [mailto:marcel(a)holtmann.org] =

> Sent: 2010=E5=B9=B48=E6=9C=8824=E6=97=A5 18:45
> To: ofono(a)ofono.org
> Cc: Su, Yong
> Subject: Re: [PATCH] Add support for text mode SMS sending
> =

> Hi Yong,
>  =

> > +/*
> > + * Send AT command with length.
> > + * Such as SMS text mode which contains 0x00 or 0x0A, 0x0D =

>  */ guint =

> > +g_at_chat_send_with_len(GAtChat *chat, const char *cmd, int cmdlen,
> > +		const char **prefix_list, GAtResultFunc func,
> > +		gpointer user_data, GDestroyNotify notify);
> > +
> =

> so in theory we could handle 0x0a and 0x0d automatically as =

> long as they are included in "". I don't see a huge problem with that.
> =

> What is the 0x00 character used for in an SMS text mode AT command.
> Maybe I am missing something obvious, but this needs a bit =

> more details.

0x00 character used in UCS2 BE format. For example,
Character "F"  encoding bytes is 0x00, 0x46 when sending sms on some CDMA p=
hones.

> Right now I am not liking this split with _with_len() at all.

What's your suggestion about this function? Thanks

> =

> Regards
> =

> Marcel
> =

> =

>=20

--===============4264927289942735574==--

