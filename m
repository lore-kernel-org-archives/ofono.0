Content-Type: multipart/mixed; boundary="===============8152820128892646631=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] isi: fix handling of incoming calls
Date: Mon, 08 Nov 2010 11:49:45 -0600
Message-ID: <4CD83839.4070901@gmail.com>
In-Reply-To: <1289229107-2046-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8152820128892646631==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

On 11/08/2010 09:11 AM, Pekka.Pessi(a)nokia.com wrote:
> From: Pekka Pessi <Pekka.Pessi@nokia.com>
> =

> Isimodem driver reports the incoming call as soon as possible, however,
> it is not possible to answer to an incoming a call before it is in
> "MT-ALERTING" or "WAITING" state.
> =

> Also, report the early incoming call state to the core as "waiting" or
> "alerting", depending on the state of the other calls.

oFono's 'alerting' state is a 27.007 based one.  Namely alerting the
remote party has started on an outgoing call.  So signaling alerting
state on an incoming call makes no sense.  Or did you mean "incoming" here?

Regards,
-Denis

--===============8152820128892646631==--

