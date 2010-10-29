Content-Type: multipart/mixed; boundary="===============4701500472640696478=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: oFono SMS Validity Period and Message Class support
Date: Fri, 29 Oct 2010 12:20:12 -0500
Message-ID: <4CCB024C.60809@gmail.com>
In-Reply-To: <C6FAFDDBC4402D44BFC43E57565F0219045093F4@ala-mail09.corp.ad.wrs.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4701500472640696478==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

On 10/29/2010 03:43 AM, Su, Yong wrote:
> Hi, all:
>  =

> We are using ofono to send sms with validity period and message class in =
our project.
> but by checking source code, it seems ofono doesn't support these require=
ments.   =


oFono does not allow you to set the validity period and simply
hard-codes it (I believe 48 hours).  Unless you have a really good
reason why you want to set the validity period, this isn't likely to change.

Sending SMS messages other than class unspecified makes no sense and
will not be supported.  If you have some extremely specific use case in
mind where this does make sense, please write your own oFono plugin.

> =

> Current implemntation is the dbus interface "SendMessage" contains "To" a=
nd "Text" only.
>  =

> Does oFono plan to support these extra fields when sending sms?

Right now the answer is no.

Regards,
-Denis

--===============4701500472640696478==--

