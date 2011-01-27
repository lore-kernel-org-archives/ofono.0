Content-Type: multipart/mixed; boundary="===============3404361561265117720=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH 6/9] oFono smsagent enhancements to permit more flexible
 parameter set to be dispatched.
Date: Thu, 27 Jan 2011 23:40:37 +0100
Message-ID: <1296168037.1520.163.camel@aeonflux>
In-Reply-To: <CBAD88B23448774582E4323588D6B5D205F6B31E@008-AM1MPN1-007.mgdnok.nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============3404361561265117720==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Oleg,

so first things first, please no top posting on this mailing list.

> That's in order to include the uuid (so we can correlate sms_send_pending=
 and sms_send_status). Possibly, in order to include some other parameters,=
 without affecting the other users of the sms_agent_dispatch_datagram().
> =

> Please take a look into the messaging_agent_sms_send_pending(), messaging=
_agent_sms_send_status() in order to get a better understanding of the use.

After talking to Kai I have an idea what you are aiming for. I think you
are looking at the wrong API. You should look at the history API. Check
out examples/history.c. That gives you the whole set of incoming and
outgoing SMS and their status. It also includes the UUID for exactly the
propose of proper tracking and storage.

Regards

Marcel



--===============3404361561265117720==--

