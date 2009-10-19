Content-Type: multipart/mixed; boundary="===============7407261303555858576=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Subject: RFC Migrate from RFC2822 to ISO8601 for time
 representations
Date: Tue, 20 Oct 2009 01:34:59 +0200
Message-ID: <1255995299.10779.0.camel@localhost.localdomain>
In-Reply-To: <200910191220.15942.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7407261303555858576==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > the format used to represent time in ofono is currently RFC2822 which is
> > complex and a bit deprecated. I think it would be better to move to
> > ISO8601 which is a well used and supported [1] format and simpler to pa=
rse.
> =

> So I don't have a problem with the patch, since RFC822 does indeed have i=
ssues =

> with i18n.  However, this will break existing applications which will nee=
d to =

> be updated to the new format.
> =

> If no one objects in the next 24 hours or so I will apply this one.

go ahead and apply the patch. Lets break the apps now. I am perfectly
fine with this patch and it makes sense.

Regards

Marcel



--===============7407261303555858576==--

