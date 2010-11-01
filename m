Content-Type: multipart/mixed; boundary="===============7433103061878655523=="
MIME-Version: 1.0
From: Su, Yong <Yong.Su@windriver.com>
Subject: RE: oFono SMS Validity Period and Message Class support
Date: Sun, 31 Oct 2010 20:58:01 -0700
Message-ID: <C6FAFDDBC4402D44BFC43E57565F021904590D9D@ala-mail09.corp.ad.wrs.com>
In-Reply-To: <4CCB024C.60809@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7433103061878655523==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable



Hi,
 =


> -----Original Message-----
> From: Denis Kenzior [mailto:denkenz(a)gmail.com] =

> Sent: 2010?10?30? 1:20
> To: ofono(a)ofono.org
> Cc: Su, Yong
> Subject: Re: oFono SMS Validity Period and Message Class support
> =

> Hi,
> =

> On 10/29/2010 03:43 AM, Su, Yong wrote:
> > Hi, all:
> >  =

> > We are using ofono to send sms with validity period and =

> message class in our project.
> > but by checking source code, it seems ofono doesn't support =

> these requirements.   =

> =

> oFono does not allow you to set the validity period and =

> simply hard-codes it (I believe 48 hours).  Unless you have a =

> really good reason why you want to set the validity period, =

> this isn't likely to change.
> =

> Sending SMS messages other than class unspecified makes no =

> sense and will not be supported.  If you have some extremely =

> specific use case in mind where this does make sense, please =

> write your own oFono plugin.
> =

> > =

> > Current implemntation is the dbus interface "SendMessage" =

> contains "To" and "Text" only.
> >  =

> > Does oFono plan to support these extra fields when sending sms?
> =

> Right now the answer is no.
> =

> Regards,
> -Denis
> =

> =


Thanks. I know these fields are less used.

But our customer require our phone must support to set SMS validity period =
and Message Class.

So, we will write oFono plugin to reslove it.


--===============7433103061878655523==--

