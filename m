Content-Type: multipart/mixed; boundary="===============0658955699952485901=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: PPP broken by 6fc119d9eaee5f9cc37a5a7198d1c55ef98fd645
Date: Fri, 04 Jan 2019 10:56:16 -0600
Message-ID: <ad6e869c-4c38-8bd8-52ec-fdcaf54c33ff@gmail.com>
In-Reply-To: <b7e415c0-e006-ebad-8d10-387b8a2b2916@geanix.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0658955699952485901==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Martin,

> It doesn't work, because the early return skips the call to =

> ppp_set_auth() in the last switch block.
> =

> Calling the function before returning works though:

This is still wrong.  lcp_rcr processes many options, AUTH_PROTO being =

only a small subset.  So you can't simply return RCR_ACCEPT here.

rfc1661 doesn't seem to allow one to reject authentication besides using =

an RCR_REJECT.  Maybe someone can play with sending a RCR_NAK and =

suggesting 0 as the AUTH_PROTO.

I suspect the real fix is to force G_AT_PPP_METHOD_CHAP in =

at_gprs_activate_primary even if OFONO_GPRS_AUTH_METHOD_NONE is given in =

the context configuration.

Unless of course the modem firmware supports taking the username / =

password via AT commands or can understand an RCR_REJECT without going =

into an infinite loop.

Regards,
-Denis

--===============0658955699952485901==--

