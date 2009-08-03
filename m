Content-Type: multipart/mixed; boundary="===============4606256871779724118=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH 4/4] Add a MessageWaiting interface to track message
 waiting indications.
Date: Mon, 03 Aug 2009 11:32:33 -0500
Message-ID: <200908031132.33454.denkenz@gmail.com>
In-Reply-To: <fb249edb0908011609n553cea1dpa5bc52a987b2866c@mail.gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4606256871779724118==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi,

> 2009/7/31 Denis Kenzior <denkenz@gmail.com>:
> >> +     if (mw->messages[i] !=3D value) {
> >> +             mw->messages[i] =3D value;
> >> +
> >> +             if (!mw->pending)
> >> +                     mw->pending =3D g_timeout_add(0, mw_mwis_update,
> >> modem); +
> >> +             dbus_gsm_signal_property_changed(conn, modem->path,
> >> +                             MESSAGE_WAITING_INTERFACE,
> >> +                             mw_messages_property_name[i],
> >> +                             DBUS_TYPE_BYTE, &value);
> >> +     }
> >> +
> >> +     return dbus_message_new_method_return(msg);
> >> +}
> >
> > Ok, I'm a bit confused here.  Are you sure that MWIs should have the
> > ability to be cleared out by the user?  The way I understood it, the us=
er
> > dials the voice mail system and the provider sends another MWI message
> > which clears out the status.
>
> You're right, there's probably no point to provide this method.  I
> haven't found the exact statement in the docs saying that the provider
> should send a new MWI but it's logical.  Otherwise I thought the D-Bus
> client might be able to tell somehow that the mailbox should now have
> 1 message less and want to update us.

Ok, now you've taken out the method entirely.  We still want to set the MBD=
N =

:)  So just add SetProperty that can set the MBDN.

>
> >> +
> >> +enum mwi_information_type {
> >> +     MWI_UNSPECIFIED =3D -1,
> >> +     MWI_MESSAGES_WAITING =3D -2,
> >> +     MWI_NO_MESSAGES_WAITING =3D -3,
> >> +};
> >
> > Is there a reason these are negative?
>
> So the caller can give the exact number of messages (zero or positive)
> or partial information using one of the constants.
>

I'm still not sure what the point is, since you just set messages to 1 if =

MWI_MESSAGES_WAITING and to 0 if MWI_NO_MESSAGES_WAITING.  And MWI_UNSPECIF=
IED =

is just simply ignored.  Perhaps you want to break up the attributes into t=
wo:

FooMailWaiting -> True / False
FooMessages -> Number, with 0 in case we're not sure

Also, please move all the MWI parsing stuff to message-waiting.c since this =

will allow us to extend the interface more readily.  In particular I'd like=
 to =

eventually support Message ID, Message Calling Line Identity by exposing an =

additional EnhancedMessageInfo interface.

Names are for illustration only at this point:
EnhancedMessages -> "/modem1/mwi/4344", "/modem1/mwi/2255"

EnhancedMessageInfo Properties:

RetentionDays
Priority
CallingParty

However, this one's lower priority.

> Yes. :-)
>
> I'm thinking it's better to try to implement what's in the text so
> when someone needs to know how ofono will react to something, you can
> point at the specification, barring any TODOs in the code.
>

Sure, it might be a good idea to quote the relevant parts of the spec.

> > Can we instead process the different sources from highest to lowest
> > instead and bail out early?  No sense in calling message_waiting_notify
> > several times (and possibly emitting spurious signals) when only once is
> > required.
>
> We can but then we won't comply with that 23.040 9.2.3.24.2 above.
> There's also a tiny possibility someone might send us updates for the
> different mailboxes (out of the 5 types defined) one using DCS and
> another one in UDH.  In the attached patch I left this as is and made
> sure PropertyChanged is only sent from the time callback (bottom half)
> which was my original intention.  I can still change this.

I still don't understand why we can't do something like:

if sms_contains_enhanced_vm_iei(sms):
	handle_enhanced_vm_info
	return

if sms_contains_special_vm_iei(sms):
	discard =3D extract_discard_from_iei_data
	// Quote relevant part of the spec here
	if mwi_dcs_decode(sms, ... ,dcsdiscard)
		discard =3D discard || dcsdiscard
	return

if mwi_dcs_decode:
	handle simple DCS MWI
	return

if "Return Call Message"
	return

> >> +final:
> >> +     /* Only bother the Message Waiting interface with textual
> >> +      * notifications that are not to be stored together with other
> >> +      * Short Messages in ME.  The other messages will be delivered
> >> +      * to the user through normal SMS store.  */
> >
> > It sounds to me like we can completely ignore the text of such messages.
> >  The network is basically saying: "the text isn't important, the conten=
ts
> > are."
>
> Probably, although with the Return Call type of notification there's
> no other information beside the text.  I left it in the updated patch.

So I still say lets get rid of LastNotificationText entirely.  Remember, mo=
st =

likely scenario is that carriers will send something like:

.pid =3D Return Call
.dcs =3D mwi dcs
.uhdi =3D true
.udh =3D contains special iei, contains enhanced iei.

to cover all phase mobiles in some way.

The only case you're really covering here is if we get a pure Return Call =

Message.  This should not happen on any modern network, and  we should not =

give it to the MessageWaiting interface anyway, since there's nothing usefu=
l =

it can do with it.  Instead, we process it like any regular text SMS.  =


Regards,
-Denis

--===============4606256871779724118==--

