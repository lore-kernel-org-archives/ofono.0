Content-Type: multipart/mixed; boundary="===============2033747280742381740=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Patch on unsupported AT command
Date: Fri, 13 Nov 2009 10:38:29 -0600
Message-ID: <200911131038.30246.denkenz@gmail.com>
In-Reply-To: <1258111132.3299.10.camel@violet>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2033747280742381740==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

> I think this might need a GAtChat quirk function where we can add extra
> terminator responses that will be recognized. And maybe even translated
> into something meaningful.

Originally I had the terminators freely definable on the GAtChat + some =

hardcoded ones, but abandoned that approach since it didn't seem useful.  =

Perhaps this needs to be resurrected.

>
> Denis, or do you want this quirked in every plugin or modem driver?

I do prefer non-standard terminators to be setup in the plugin/driver.

Regards,
-Denis

--===============2033747280742381740==--

