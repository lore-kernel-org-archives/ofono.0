Content-Type: multipart/mixed; boundary="===============7880769806391555068=="
MIME-Version: 1.0
From: kristen@linux.intel.com
Subject: [patch 0/6] Initial patches for gatchat PPP support
Date: Thu, 11 Mar 2010 14:00:25 -0800
Message-ID: <20100311140025.68be02ed@kcaccard-MOBL3>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============7880769806391555068==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

These patches implement PPP support for gatchat.  They're not complete, but =

are useful enough to play with if anyone wants to.  I included a patch to
gsmdial which allows you to invoke the PPP routines after the CONNECT
callback.  This patch will create a TUN interface, which you will then
have to manually configure using the IP Address and DNS information that
is output by gsmdial to stdout.  There are many items yet to be done, =

mostly they fall into these categories: =

	* clean exit and Link Loss path
	* Cleanup and deallocate memory properly	=

	* Implement Error path (Configure-Reject etc).
 =

I tested this on the AT&T sierra modem, but not with any other modem.
I appreciate your feedback.

--===============7880769806391555068==--

