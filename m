Content-Type: multipart/mixed; boundary="===============8050375592658451636=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: How to get the OMA DRM right object file coming from WAP Push?
Date: Thu, 25 Nov 2010 10:40:33 +0100
Message-ID: <1290678033.4795.1.camel@aeonflux>
In-Reply-To: <1290676025.5365.24.camel@tucson>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8050375592658451636==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Aki,

> > Can the two methods help me to handle files from WAP  push?
> =

> Yes. You need to implement the PushNotificationAgent interface, and
> register this object with oFono using the RegisterAgent() method.

there is actually a test/test-push-notification Python example in the
code base that shows how this works.

Regards

Marcel



--===============8050375592658451636==--

