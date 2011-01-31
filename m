Content-Type: multipart/mixed; boundary="===============2528117617583973016=="
MIME-Version: 1.0
From: Oleg Zhurakivskyy <oleg.zhurakivskyy@nokia.com>
Subject: Re: [PATCH 6/9] oFono smsagent enhancements to permit more	flexible
 parameter set to be dispatched.
Date: Mon, 31 Jan 2011 10:30:41 +0200
Message-ID: <4D467331.7060003@nokia.com>
In-Reply-To: <1296168037.1520.163.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2528117617583973016==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable


Hello Marcel,

On 01/28/2011 12:40 AM, ext Marcel Holtmann wrote:

> After talking to Kai I have an idea what you are aiming for. I think you
> are looking at the wrong API. You should look at the history API. Check
> out examples/history.c. That gives you the whole set of incoming and
> outgoing SMS and their status. It also includes the UUID for exactly the
> propose of proper tracking and storage.

Please take a look into plugins/messaging-agent.c, this API is already =

being used in order to receive the SMS events.

The smsagent.c API is just used for dispatching those events to the =

registered agents.

Regards,
Oleg

--===============2528117617583973016==--

