Content-Type: multipart/mixed; boundary="===============9052680186263664706=="
MIME-Version: 1.0
From: oleg.zhurakivskyy@nokia.com
Subject: RE: [PATCH 6/9] oFono smsagent enhancements to permit more	flexible
 parameter set to be dispatched.
Date: Thu, 27 Jan 2011 14:38:12 +0000
Message-ID: <CBAD88B23448774582E4323588D6B5D205F6B31E@008-AM1MPN1-007.mgdnok.nokia.com>
In-Reply-To: <1296134302.1520.154.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============9052680186263664706==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hello Marcel,

That's in order to include the uuid (so we can correlate sms_send_pending a=
nd sms_send_status). Possibly, in order to include some other parameters, w=
ithout affecting the other users of the sms_agent_dispatch_datagram().

Please take a look into the messaging_agent_sms_send_pending(), messaging_a=
gent_sms_send_status() in order to get a better understanding of the use.

Regards,
Oleg
________________________________________
From: ofono-bounces(a)ofono.org [ofono-bounces(a)ofono.org] on behalf of ex=
t Marcel Holtmann [marcel(a)holtmann.org]

> diff --git a/src/smsagent.h b/src/smsagent.h

I have a bunch of comments for the other patches, but what is this
about? I don't see any need to it.

Regards

Marcel
--===============9052680186263664706==--

