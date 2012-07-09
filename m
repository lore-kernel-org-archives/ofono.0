Content-Type: multipart/mixed; boundary="===============7130202964072910090=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 1/2] test-ussd becomes send-ussd
Date: Mon, 09 Jul 2012 13:39:29 -0300
Message-ID: <1341851969.16443.0.camel@aeonflux>
In-Reply-To: <4FFB0629.9070304@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7130202964072910090==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

> > ---
> >   test/send-ussd |   75 +++++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
> >   test/test-ussd |   75 -----------------------------------------------=
---------
> >   2 files changed, 75 insertions(+), 75 deletions(-)
> >   create mode 100755 test/send-ussd
> >   delete mode 100755 test/test-ussd
> >
> =

> Why don't we just get rid of test-ussd and create a new send-ussd script =

> that doesn't do any stdin handling.  Something along the lines of:
> =

> ss.GetProperties()
> =

> if state =3D=3D 'idle'
> 	rsp =3D ss.Initiate()
> elif state =3D=3D 'user-response'
> 	rsp =3D ss.Respond()
> =

> print response
> =

> And perhaps another ussd related script that just cancels the request. =

> Would this satisfy your requirements?

are the existing test/initiate-ussd and test/cancel-ussd not good
enough?

Regards

Marcel



--===============7130202964072910090==--

