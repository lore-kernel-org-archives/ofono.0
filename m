Content-Type: multipart/mixed; boundary="===============2664035606490329188=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [patch 0/6] Initial patches for gatchat PPP support
Date: Fri, 12 Mar 2010 15:42:52 -0800
Message-ID: <1268437372.2906.8.camel@localhost.localdomain>
In-Reply-To: <20100311140025.68be02ed@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2664035606490329188==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> These patches implement PPP support for gatchat.  They're not complete, b=
ut =

> are useful enough to play with if anyone wants to.  I included a patch to
> gsmdial which allows you to invoke the PPP routines after the CONNECT
> callback.  This patch will create a TUN interface, which you will then
> have to manually configure using the IP Address and DNS information that
> is output by gsmdial to stdout.  There are many items yet to be done, =

> mostly they fall into these categories: =

> 	* clean exit and Link Loss path
> 	* Cleanup and deallocate memory properly	=

> 	* Implement Error path (Configure-Reject etc).
>  =

> I tested this on the AT&T sierra modem, but not with any other modem.
> I appreciate your feedback.

some general comments. Please fix your .gitconfig for using git
send-email to show your name along with the email address. Otherwise
Denis or I have to go into every patch and fix it up.

All exported structs should be typedefed and its content hidden. If they
are not meant to be public or can be kept private to the source file
where they are used, then that is preferred.

And of course everything public needs to be namespaced with GAtPPP and
g_at_ppp to have a clear distinction and not clashes.

Two question come to my mind. Have looked into assuring that everything
is big endian safe? What about unaligned access to the data structures?
Seems in some cases you take uint16 and unit32 directly from the stream.
Both things can be fixed up later with patches on top of it, but please
keep it in mind.

Regards

Marcel



--===============2664035606490329188==--

