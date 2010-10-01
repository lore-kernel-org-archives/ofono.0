Content-Type: multipart/mixed; boundary="===============8515260649411405414=="
MIME-Version: 1.0
From: Rajesh.Nagaiah@elektrobit.com
Subject: RE: Query related to UDUB for voice calls.
Date: Fri, 01 Oct 2010 14:31:42 -0700
Message-ID: <C681C76E0D5F1E4BB01DE79E0A80EEC702AC93D5@usrdes03.ebgroup.elektrobit.com>
In-Reply-To: <AANLkTim_eSE2qwKUzbfNYhmxu73As=pDvyriVhqWWaXa@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============8515260649411405414==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sankar, =


My understanding is that when a call is rejected by the user,
irrespective of whether its an incoming call or a waiting call, the
cause value for the release call should be set to UDUB, so that for the
remote subscriber the User Busy note will be shown in the UI if the
voice mailbox is not configured. In the message based modem case, we set
the cause value to UDUB with the release call request and in the AT
based modem case we should send AT+CHLD=3D0, which will in turn set UDUB.
So for the Incoming call hangup case if we call vc->driver->hangup(vc,
generic_callback, vc); in AT case it will send AT+CHUP which i am not
sure is inturn going to set the cause value to UDUB or not (Someone with
AT based modem experience can confirm this ???), but for message based
modem case its going to call the release call request with cause value
Release by user, which will be translated to normal call clearing.
So in ofono core the hangup case for Incoming call should be handled in
same way as Waiting call by calling vc->driver->set_udub(vc,
generic_callback, vc);
instead of vc->driver->hangup(vc, generic_callback, vc);, so that UDUB
cause is sent to the remote party


BR,
Rajesh

________________________________

From: ofono-bounces(a)ofono.org [mailto:ofono-bounces(a)ofono.org] On Behalf
Of Sankar
Sent: 01 October 2010 02:33
To: ofono(a)ofono.org
Subject: Query related to UDUB for voice calls.


Hi,

I was referring to the voice calls portion of ofono and I have a query
related to user determined user busy. =


In the ofono core, if the user rejects a voice call, based on the call
status, respective driver function is called. I have pasted the code
below.

static DBusMessage *voicecall_hangup( =

DBusConnection *conn,
                    DBusMessage *msg, void *data)
{
            /* According to various specs, other than 27.007, +CHUP is
used
     * to reject an incoming call
     */
    if (call->status =3D=3D CALL_STATUS_INCOMING) {
        if (vc->driver->hangup =3D=3D NULL)
            return __ofono_error_not_implemented(msg);

        vc->pending =3D dbus_message_ref(msg);
        vc->driver->hangup(vc, generic_callback, vc);

        return NULL;
    }

    if (call->status =3D=3D CALL_STATUS_WAITING) {
        if (vc->driver->set_udub =3D=3D NULL)
            return __ofono_error_not_implemented(msg);

        vc->pending =3D dbus_message_ref(msg);
        vc->driver->set_udub(vc, generic_callback, vc);

        return NULL;
    }

}

But as per the 3GPP TS 22001 v6.0.0, UDUB applies to an incoming call
also. Below is the excerpt from the specification.

C.3 =


User Determined User Busy (UDUB) condition

This condition occurs when a call is offered to a user equipment and the
UE responds "user busy" because the
subscribers resources (terminal or person using them) are busy. Then the
PLMN will clear the call with the indication
"busy" back towards the calling subscriber (see also clause 4).

Can some please clarify if the above behaviour in ofono core is proper
or this need to be corrected?

Thanks,
Sankar.=20

--===============8515260649411405414==--

