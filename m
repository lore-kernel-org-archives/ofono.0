Content-Type: multipart/mixed; boundary="===============6474471401844120941=="
MIME-Version: 1.0
From: Sjur BRENDELAND <sjur.brandeland@stericsson.com>
Subject: RE: [PATCH v4 1/2] stemodem: Add RTNL functionality managing CAIF
 Network Interfaces.
Date: Fri, 12 Nov 2010 11:21:50 +0100
Message-ID: <81C3A93C17462B4BBD7E272753C105791945C0C40A@EXDCVYMBSTM005.EQ1STM.local>
In-Reply-To: <1289514837.3266.88.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6474471401844120941==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel.

> Does anything cleans up the channel when oFono unexpectedly crashes?

No not yet. I suppose the interface will continue up until someone
destroys it. Should we simply destroy all CAIF interfaces
if oFono crashes? I think this would be the simplest approach.

BTW, how does connman behave in this case? Will it do any attempt
to clean up IP interfaces when it notices that oFono APIs has gone missing?
And what about modem state, is it taken back to flight-mode (AT+CFUN=3D0) in
order to reset everything?

If you don't mind, I would prefer to do restart handling as the next step.
It would be nice to finish this patch review first, what do you think?

> =

> I think you can just use a stack buffer when you actually send the
> message. This is damn ugly and from a security point it actually scares
> me.
> =

> Please only keep the seqnum in here. Since that is the only thing you
> need to find that pending request. Just get rid of everything that you
> don't need for the callback.

Yes, done.

> > I have squashed this into parse_rtnl_message, as you suggested.
> > I'm not really convinced this was any cleaner though..?
> > I end up with duplicating the code in the two if statements.
> =

> We will see. I might have been wrong, but in my mind it just locked
> fine. I will take a second look when you send the updated patch.

OK, tell me what you think about the next patch then.

> > I think that the kernel implementation of rtnl will guarantee the
> > requests to be processed in order. rtnetlink_rcv in
> ..net/core/rtnetlink.c
> > takes the rtnl_lock before processing the netlink messages.
> > I believe this will guarantee that the NEWLINK responses will be
> received
> > in the same order as they are sent.
> =

> it might be keeping the order, but I wouldn't count on it. And just
> using your find request function would make this code simpler.

The seqnr is not present in the message header of this response message,
so this will not be possible. I would prefer to stick with the current
implementation. Or do you see another way forward?
 =

> > > > +                   req =3D find_request(hdr->nlmsg_seq);
> > > > +                   if (req =3D=3D NULL)
> > > > +                           break;
> > > > +
> > > > +                   DBG("nlmsg error req");
> > > > +                   rtnl_client_response(req, -1);
> > > > +                   return;
> > > > +           }
> > >
> > > If I understand this right, then you can always find the pending
> > > request
> > > and remove it here. No need for rtnl_client_response at all.
> >
> > Yes, I guess you are right. I can remove this callback.
> > Currently I am only actually interested in the result when
> > the interface is created successfully. Nothing particularly
> > is done in gprs-context.c if it fails.
> =

> That is not what I meant. We should find that request and call the
> callback, but I think this can be done a more generic way.
> =

> So whatever message you get, find the request that it belongs to. You
> need that request struct anyway. And then just reply here.

OK, I think I have done so. Have a look when I send the next patch.

> > Actually I think io_channel_read is just fine here. I think connman
> is doing
> > the same thing for rtnl. It is the sending part which is problematic.
> =

> We should not be using that in ConnMan either actually. The _read is
> fine, but deprecated. The new _read_chars is doing buffering and a bit
> nasty in that area. So really just use recv() here.

OK, I've changed it to recv.

> > > So if we split out creating the NLMSG header into one helper
> functions,
> > > then you can easily prep the RTNL newlink message here inside the
> > > function.
> >
> > Even with creating this helper function you suggested
> > the prep_rtnl_newlink_req is on 45 lines. I think it makes sense
> > still keep then separate. It is no big deal for me, but I would
> prefer
> > to avoid such a large functions,
> =

> As I said above, it looked good in my head. Maybe I was wrong, but in
> general this is pretty simple sequential stuff. So it can be in one
> function and still be easy readable. Lets have a look on how it looks
> and then decide.

OK, I've squashed the two functions. =


> =

> > > This will also allow you to remove req->loop_enabled variables
> since I
> > > don't see need for storing them.
> >
> > You are right, the loop_enabled variable is not currently needed.
> > However for various testing purposes we frequently want to run the
> CAIF Interface
> > in loopback mode (e.g. testing loopback to the modem). loopback_mode
> will make the
> > interface swap src and destination ip addresses so we actually can do
> ping etc.
> > If you are OK with this, I would prefer to keep this in order to make
> testing easier.
> > But again, I'm easy...
> =

> Having loopback mode is fine. I just meant that you don't have to store
> the variable in the request struct since you build the request already.
> =

> Please store only things in your request struct that you do need later
> on.

OK, done. This struct is much smaller now.

> =

> > > > diff --git a/drivers/stemodem/caif_rtnl.h
> > ...
> > > > +typedef void (*caif_rtnl_create_cb_t) (int result, gpointer
> > > user_data,
> > > > +           char *ifname, int ifindex);
...
> > Yes, but ifindex is used when removing the CAIF IP Interface.
> > It makes life a lot easier when removing an interface.
> =

> I saw that later. Then the result is pointless. Just negative ifindex
> could be used for errors.
> =

> So this should be (int index, const char *interface, void *user_data).

OK, done.

> > Thank you for a very thorough review here Marcel.
> =

> No problem. Just RTNL takes always a bit to get used to again ;)

Yes, ditto.  Going from ioctl with just a couple of function calls into rtnl
has been surprisingly complex.

Regards,
Sjur



--===============6474471401844120941==--

