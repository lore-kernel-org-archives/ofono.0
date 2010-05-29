Content-Type: multipart/mixed; boundary="===============3739181209098470085=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [Patch]: Reducing clutter in the src directory + Introduction of
 HACKING file
Date: Sat, 29 May 2010 11:56:06 +0200
Message-ID: <1275126966.4706.87.camel@aeonflux.t-mobile.de>
In-Reply-To: <AANLkTimH1toWxblwfhPh4b0_1N80bT13XAmCT7-y1Z3x@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3739181209098470085==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Naresh,

> I generally prefer to keep the header files separate then the actual
> source files. I had also
> moved the xml files into an xml folder. But I have now reverted those cha=
nges.
> =

> >> I have also added a HACKING file for people to quickly understand and
> >> grasp the concept and execution of phonesim.
> >
> > Please send that as a separate patch.
> =

> Patch file for HACKING attached.

please create patches with git format-patch and make sure the commit
message is split in a subject and body. Also check that it applies
cleanly with git am. Your current patch doesn't. So please redo this and
send it again.

Also I prefer to get patches inline. It is not a hard requirement, but
makes things a lot easier. Using git send-email is helpful here.

Regards

Marcel



--===============3739181209098470085==--

