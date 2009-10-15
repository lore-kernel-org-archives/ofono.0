Content-Type: multipart/mixed; boundary="===============0834243259132286732=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: oFono gets multiplexer support
Date: Thu, 15 Oct 2009 16:22:28 -0500
Message-ID: <200910151622.28940.denkenz@gmail.com>
In-Reply-To: <97D5E1BB8FC13D4EA3B34BAE8E6898C99F9F2F02@orsmsx508.amr.corp.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0834243259132286732==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Waldo,

> Is it a correct understanding that modem's that provide kernel drivers th=
at
> provide multiple TTY's and do the multiplexing in kernel space will not
> need to integrate with any of this and can just create multiple GAtChat
> objects in their oFono modem driver?

If the modem driver can take advantage of a kernel space multiplexer, that =
is =

fine.

>
> I notice that g_at_mux_create_channel() doesn't take a DLC as argument. So
> when the calypso driver defines #define VOICE_DLC 0
> the result will be that DLC 1 will be used for VOICE_DLC, correct?

The real assignment of DLC channels is done inside GAtMux.  What you see in =

the driver is unrelated, but most likely will work like you outline by magi=
c =

:)

Regards,
-Denis

--===============0834243259132286732==--

