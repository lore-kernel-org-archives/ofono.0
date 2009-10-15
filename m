Content-Type: multipart/mixed; boundary="===============6711901871839438054=="
MIME-Version: 1.0
From: Bastian, Waldo <waldo.bastian@intel.com>
Subject: RE: oFono gets multiplexer support
Date: Thu, 15 Oct 2009 14:57:37 -0700
Message-ID: <97D5E1BB8FC13D4EA3B34BAE8E6898C99F9F2F02@orsmsx508.amr.corp.intel.com>
In-Reply-To: <200910151616.58076.denkenz@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6711901871839438054==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> Hi All,
> =

> Just to let you know the initial support for multiplexing has been added
> to oFono.  The multiplexer infrastructure is fully customizable through
> the use of drivers.  Two drivers are currently supported, GSM 27.010 Basic
> and Advanced modes.

Is it a correct understanding that modem's that provide kernel drivers that=
 provide multiple TTY's and do the multiplexing in kernel space will not ne=
ed to integrate with any of this and can just create multiple GAtChat objec=
ts in their oFono modem driver?

I notice that g_at_mux_create_channel() doesn't take a DLC as argument. So =
when the calypso driver defines
	#define VOICE_DLC 0
the result will be that DLC 1 will be used for VOICE_DLC, correct?

Cheers,
Waldo

--===============6711901871839438054==--

