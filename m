Content-Type: multipart/mixed; boundary="===============4754838178692332849=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: Query related to UDUB for voice calls.
Date: Fri, 01 Oct 2010 17:56:11 -0500
Message-ID: <4CA6670B.90606@gmail.com>
In-Reply-To: <C681C76E0D5F1E4BB01DE79E0A80EEC702AC93D5@usrdes03.ebgroup.elektrobit.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4754838178692332849==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Rajesh,

Please, NO top posting on this list.

On 10/01/2010 04:31 PM, Rajesh.Nagaiah(a)elektrobit.com wrote:
> Hi Sankar, =

> =

> My understanding is that when a call is rejected by the user,
> irrespective of whether its an incoming call or a waiting call, the
> cause value for the release call should be set to UDUB, so that for the
> remote subscriber the User Busy note will be shown in the UI if the
> voice mailbox is not configured. In the message based modem case, we set
> the cause value to UDUB with the release call request and in the AT
> based modem case we should send AT+CHLD=3D0, which will in turn set UDUB.
> So for the Incoming call hangup case if we call vc->driver->hangup(vc,
> generic_callback, vc); in AT case it will send AT+CHUP which i am not
> sure is inturn going to set the cause value to UDUB or not (Someone with
> AT based modem experience can confirm this ???), but for message based
> modem case its going to call the release call request with cause value
> Release by user, which will be translated to normal call clearing.
> So in ofono core the hangup case for Incoming call should be handled in
> same way as Waiting call by calling vc->driver->set_udub(vc,
> generic_callback, vc);
> instead of vc->driver->hangup(vc, generic_callback, vc);, so that UDUB
> cause is sent to the remote party
> =


Unfortunately AT modems do not allow any CHLD operations on incoming
calls, including CHLD=3D0.  CHLD=3D0 can only be used to set UDUB on waiting
calls.  To release incoming calls you must use ATH or +CHUP.  Since AT
command modems are the only ones described by 3GPP standards, that is
the modem interface oFono assumes.

If your modem deviates from this standard, then you need to make sure to
send the proper release cause for incoming calls in the driver for your
target hardware.

Regards,
-Denis

--===============4754838178692332849==--

