Content-Type: multipart/mixed; boundary="===============1318890898482558606=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH QMI LTE v2 04/13] gprs: _cid_activated is an 'attaching'
 state
Date: Fri, 14 Apr 2017 17:29:15 -0500
Message-ID: <c2bd5d42-c895-eb92-50e7-7a04c249550e@gmail.com>
In-Reply-To: <20170414213646.32066-5-jonas@southpole.se>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1318890898482558606==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Jonas,

On 04/14/2017 04:36 PM, Jonas Bonn wrote:
> ofono_gprs_status_notify is an asynchronous notification that messes
> with the 'attached' state of the GPRS atom.  This method is normally
> prevented from running while an attach is in progress because the
> attachment machinery wants to finish up and make it's own determination
> of attach state.
>
> When automatic context activation is relevant, as for LTE networks,
> the ofono_gprs_cid_activated machinery replaces the usual set_attach
> machinery for attaching to the network.  The cid_activated variant,
> however, does not guard against simulatenous invocations of
> ofono_gprs_status_notify.  This causes a race whereby status_notify
> sets the state to 'attached' before the context is fully constructed
> and set to active.  If the connection manager sees the 'attached'
> state before there are any 'active' contexts, it may decide to
> activate a context manually which is not the correct behaviour for
> this type of network.
>
> This patch makes the *_cid_activated machinery an 'attaching' state,
> introducing the same guards that set_attached has to prevent
> ofono_gprs_status_notify from running concurrently.
> ---
>  src/gprs.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>

This looks reasonable to me.  Applied, thanks.

Regards,
-Denis


--===============1318890898482558606==--

