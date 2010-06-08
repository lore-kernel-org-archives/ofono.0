Content-Type: multipart/mixed; boundary="===============3494666033854161852=="
MIME-Version: 1.0
From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
Subject: Re: [RFC patches 02/13] sms_send_message: add a short roadmap
Date: Tue, 08 Jun 2010 22:37:44 +0000
Message-ID: <1276036931.2478.62.camel@localhost.localdomain>
In-Reply-To: <201005280934.36704.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3494666033854161852==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

On Fri, 2010-05-28 at 07:34 -0700, Denis Kenzior wrote: =

> Hi Inaky,
> =

> > From: Inaky Perez-Gonzalez <inaky.perez-gonzalez@intel.com>
> > =

> > ---
> >  src/sms.c |   13 +++++++++++++
> >  1 files changed, 13 insertions(+), 0 deletions(-)
> > =

> =

> Applied with s/D-BUS/D-Bus

Thank you for applying, but please *don't* do it like that.

Complain and ask me to fix it, I'll be happy to comply and resend, but
by modifying the commit yourself you drive git crazy and create
conflicts between my commits and yours.

Now I have to go for a time-consuming process of finding which ones are
and working around it. You might have saved some of your time in doing
that, but it is way less that the one I am going to use on resolving the
mess on each commit *plus* I don't get to really learn / set on stone
what your preferences are so these review round trips become less
frequent in the long term. We both loose here.




--===============3494666033854161852==--

