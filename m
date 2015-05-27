Content-Type: multipart/mixed; boundary="===============8150109010045594436=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: bug reactivating primary context?
Date: Wed, 27 May 2015 12:16:41 -0500
Message-ID: <5565FBF9.6090706@gmail.com>
In-Reply-To: <5565F9C5.2070607@dynamicdevices.co.uk>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8150109010045594436==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Alex,

 >
> I'd like just to verify that this isn't an issue for Cinterion devices /
> plugin.  Is it fair to assume that if there is an issue with context
> activation and deactivation then I would not have a ppp0 interface
> brought up after running the context deactivation and activation test
> scripts?

Correct.  I do not recall that this particular issue was ever reported =

for Cinterion devices.  Only certain models of Huawei modems & maybe one =

or two other USB stick type devices.

>
> [ all working - connected on ppp0 ]
> /usr/lib/ofono/test/deactivate-context
> /usr/lib/ofono/test/activate-context
> [ all working - connected on ppp0 ]
>
> That all seems OK here on Cinterion EHS6.
>

Good to know.  Thanks for confirming this one.

Regards,
-Denis


--===============8150109010045594436==--

