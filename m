Content-Type: multipart/mixed; boundary="===============6148834415619087329=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: RE: [PATCH v4 1/2] stemodem: Add RTNL functionality managing CAIF
 Network Interfaces.
Date: Fri, 12 Nov 2010 07:33:57 +0900
Message-ID: <1289514837.3266.88.camel@aeonflux>
In-Reply-To: <81C3A93C17462B4BBD7E272753C105791945BBEAA6@EXDCVYMBSTM005.EQ1STM.local>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6148834415619087329==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

> > what happens for network triggered deactivation. Some networks here
> > disconnect the GPRS context used MMS. Has some funny behavior that need
> > to be taken into account.
> =

> Good question! When code reading with this in mind I realize that
> we missed to mark the conn_info->interface as available by setting
> cid =3D 0. This is bug, thank you for leading me to it.

fall into a similar trap with GPRS support for IFX. =


> FYI this is how CAIF and AT works together:
> In order to have payload over CAIF there need to be
> both a CAIF channel connected and a context activated with AT*EPPSD.
> When Channel-ID configured for CAIF IP Interface and the Channel-Id given
> in AT*EPPSD matches, the modem side will connect the CAIF Channel to
> the Network Signaling Stack in the modem.
> =

> With this new patch CAIF channels are created statically from probe.
> Activation and deactivation is controlled by AT*EPPSD, or notified by
> +CGEV which will result in a CGACT status query.
> =

> If the network disconnects GPRS we should receive a
> "+CGEV: NW DEACT", subsequent CGACT status query.
> Here the connection (and CAIF Network Interface) should be
> marked as unused by setting cid to zero.

Sounds good to me.

Does anything cleans up the channel when oFono unexpectedly crashes?

> > > +#define NLMSG_TAIL(nmsg) \
> > > +   ((struct rtattr *) (((void *) (nmsg)) + NLMSG_ALIGN((nmsg)-
> > >nlmsg_len)))
> >
> > We have no global define this? You wanted to look into that. What was
> > the outcome of it?
> =

> I did mention this before - I have looked around, but he did not find
> any relevant macro for this unfortunately.

I might just overread your response. Just wanted to make sure.

> > > +struct iplink_req {
> > > +   struct nlmsghdr n;
> > > +   struct ifinfomsg i;
> > > +   char pad[1024];
> >
> > What is this huge pad for? It looks totally fishy to me.
> =

> The pad is there to hold the remaining of the rtnl attributes.
> I'm working on restructuring this so that I can separate the
> buffer holding the rtnl_message and the iplink_req.
> I just have to make it work...

I think you can just use a stack buffer when you actually send the
message. This is damn ugly and from a security point it actually scares
me.

Please only keep the seqnum in here. Since that is the only thing you
need to find that pending request. Just get rid of everything that you
don't need for the callback.

> > > +static void rtnl_client_response(struct iplink_req *req, int result)
> > > +{
> > > +
> > > +   if (req->callback && req->n.nlmsg_type =3D=3D RTM_NEWLINK)
> > > +           req->callback(result, req->user_data,
> > > +                           req->ifname, req->ifindex);
> > > +
> > > +   pending_requests =3D g_slist_remove(pending_requests, req);
> > > +   g_free(req);
> > > +}
> >
> > I don't like this split out. You already checked the nlmsg_type and
> > here
> > you keep checking it again just to reuse some code. This looks like
> > waste to me.
> =

> I have squashed this into parse_rtnl_message, as you suggested.
> I'm not really convinced this was any cleaner though..?
> I end up with duplicating the code in the two if statements.

We will see. I might have been wrong, but in my mind it just locked
fine. I will take a second look when you send the updated patch.

> > An you can have more than one RTNL message inside this buffer. You need
> > to be able to handle this. Otherwise you might loose responses. The
> > case
> > of just calling return when you received one of the two messages you
> > care about is not really acceptable.
> =

> OK, done. I'll keep looping.
> =

> >
> > > +   while (len > 0) {
> > > +           struct nlmsghdr *hdr =3D buf;
> > > +
> > > +           if (!NLMSG_OK(hdr, len))
> > > +                   break;
> > > +
> > > +           if (hdr->nlmsg_type =3D=3D RTM_NEWLINK) {
> > > +                   req =3D g_slist_nth_data(pending_requests, 0);
> > > +                   if (req =3D=3D NULL)
> > > +                           break;
> >
> > How does this work? You just pick the first pending request and don't
> > really compare the sequence number. Who guarantees the order of these
> > events. I don't think we should be doing this.
> =

> I think that the kernel implementation of rtnl will guarantee the
> requests to be processed in order. rtnetlink_rcv in ..net/core/rtnetlink.c
> takes the rtnl_lock before processing the netlink messages.
> I believe this will guarantee that the NEWLINK responses will be received
> in the same order as they are sent.

it might be keeping the order, but I wouldn't count on it. And just
using your find request function would make this code simpler.

> > > +                   msg =3D (struct ifinfomsg *) NLMSG_DATA(hdr);
> > > +                   store_newlink_param(req, msg->ifi_type,
> > > +                                   msg->ifi_index, msg->ifi_flags,
> > > +                                   msg->ifi_change, msg,
> > > +                                   IFA_PAYLOAD(hdr));
> > > +                   rtnl_client_response(req, 0);
> > > +                   return;
> > > +
> > > +           } else if (hdr->nlmsg_type =3D=3D NLMSG_ERROR) {
> >
> > So I would prefer if you use a switch statement here. It is just easier
> > to read. Especially inside a while() loop.
> =

> OK - I'll break coding-style rule M12. There are more than 40 RTM messages
> I'm not handling, but no rule without exception :-)

Good point, but that rule does not apply here.

1) This is not our enum and comes from an external header file. We have
no control over and should not make such assumptions that M12 would
apply. It really only applies to our own enums. So using a default
statement is a good idea here.

2) This is part of wire protocol. And in that case you should always
write secure code to protect unexpected packets. So using a default is a
good idea as well.

Maybe someone needs to update our coding style document to include this.


> > > +                   req =3D find_request(hdr->nlmsg_seq);
> > > +                   if (req =3D=3D NULL)
> > > +                           break;
> > > +
> > > +                   DBG("nlmsg error req");
> > > +                   rtnl_client_response(req, -1);
> > > +                   return;
> > > +           }
> >
> > If I understand this right, then you can always find the pending
> > request
> > and remove it here. No need for rtnl_client_response at all.
> =

> Yes, I guess you are right. I can remove this callback.
> Currently I am only actually interested in the result when
> the interface is created successfully. Nothing particularly
> is done in gprs-context.c if it fails.

That is not what I meant. We should find that request and call the
callback, but I think this can be done a more generic way.

So whatever message you get, find the request that it belongs to. You
need that request struct anyway. And then just reply here.

> > > +static gboolean netlink_event(GIOChannel *chan,
> > > +                           GIOCondition cond, gpointer data)
> > > +{
> > > +   unsigned char buf[4096];
> > > +   gsize len;
> > > +   GIOError err;
> > > +
> > > +   if (cond & (G_IO_NVAL | G_IO_HUP | G_IO_ERR)) {
> > > +           rtnl_watch =3D 0;
> > > +           return FALSE;
> > > +   }
> > > +
> > > +   memset(buf, 0, sizeof(buf));
> > > +
> > > +   err =3D g_io_channel_read(chan, (gchar *) buf, sizeof(buf), &len);
> > > +   if (err) {
> > > +           if (err =3D=3D G_IO_ERROR_AGAIN)
> > > +                   return TRUE;
> > > +           rtnl_watch =3D 0;
> > > +           return FALSE;
> > > +   }
> >
> > Just use recv() here. I know that I would prefer to be using GIOChannel
> > functions, but they don't work well on netlink sockets anyway, so don't
> > bother with them at all.
> >
> > Sorry for confusing you and sending you into the wrong direction first.
> =

> Actually I think io_channel_read is just fine here. I think connman is do=
ing
> the same thing for rtnl. It is the sending part which is problematic.

We should not be using that in ConnMan either actually. The _read is
fine, but deprecated. The new _read_chars is doing buffering and a bit
nasty in that area. So really just use recv() here.

> > > +   parse_rtnl_message(buf, len);
> > > +
> > > +   return TRUE;
> > > +}
> > > +
> > > +int caif_rtnl_init(void)
> > > +{
> > > +   struct sockaddr_nl addr;
> > > +   int sk, err;
> > > +
> > > +   sk =3D socket(PF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
> > > +   if (sk < 0)
> > > +           return sk;
> > > +
> > > +   memset(&addr, 0, sizeof(addr));
> > > +   addr.nl_family =3D AF_NETLINK;
> > > +   addr.nl_groups =3D RTMGRP_LINK | RTMGRP_IPV4_IFADDR |
> > RTMGRP_IPV4_ROUTE;
> >
> > You need IPV4_IFADDR and IPV4_ROUTE as well. I don't see you making use
> > of them. Please only set LING since we don't wanna wake ofonod up for
> > anything else.
> =

> Actually I guess I only need RTMGRP_LINK. I am only interested in creating
> and removing the CAIF Interface. Setting the IP addresses and all the rest
> is connman responsibility right?

Yes. You should not mess with IP addresses.

> > > +
> > > +   req =3D g_try_new0(struct iplink_req, 1);
> > > +   if (req =3D=3D NULL)
> > > +           return -ENOMEM;
> > > +
> > > +   req->user_data =3D user_data;
> > > +   req->type =3D type;
> > > +   req->conn_id =3D connid;
> > > +   req->loop_enabled =3D loop;
> > > +   req->callback =3D cb;
> > > +
> > > +   err =3D prep_rtnl_newlink_req(req);
> > > +   if (err < 0)
> > > +           goto error;
> >
> > So if we split out creating the NLMSG header into one helper functions,
> > then you can easily prep the RTNL newlink message here inside the
> > function.
> =

> Even with creating this helper function you suggested
> the prep_rtnl_newlink_req is on 45 lines. I think it makes sense
> still keep then separate. It is no big deal for me, but I would prefer
> to avoid such a large functions,

As I said above, it looked good in my head. Maybe I was wrong, but in
general this is pretty simple sequential stuff. So it can be in one
function and still be easy readable. Lets have a look on how it looks
and then decide.

> > This will also allow you to remove req->loop_enabled variables since I
> > don't see need for storing them.
> =

> You are right, the loop_enabled variable is not currently needed.
> However for various testing purposes we frequently want to run the CAIF I=
nterface
> in loopback mode (e.g. testing loopback to the modem). loopback_mode will=
 make the
> interface swap src and destination ip addresses so we actually can do pin=
g etc.
> If you are OK with this, I would prefer to keep this in order to make tes=
ting easier.
> But again, I'm easy...

Having loopback mode is fine. I just meant that you don't have to store
the variable in the request struct since you build the request already.

Please store only things in your request struct that you do need later
on.

> > > diff --git a/drivers/stemodem/caif_rtnl.h
> ...
> > > +typedef void (*caif_rtnl_create_cb_t) (int result, gpointer
> > user_data,
> > > +           char *ifname, int ifindex);
> >
> > Please don't use GLib types here. Using int and void * is better.
> >
> > So the user_data parameter should come always last. Do we need index
> > and
> > ifname? I think inside oFono we only care about ifname.
> =

> =

> Yes, but ifindex is used when removing the CAIF IP Interface.
> It makes life a lot easier when removing an interface.

I saw that later. Then the result is pointless. Just negative ifindex
could be used for errors.

So this should be (int index, const char *interface, void *user_data).

> Thank you for a very thorough review here Marcel.

No problem. Just RTNL takes always a bit to get used to again ;)

> I have done most of the updates, I could sent what I have now,
> but I'd like to make it work again. Removing the pad and
> split apart the request structure and the actual rtnl message
> proved to be a bit of work....

Sounds good.

Regards

Marcel



--===============6148834415619087329==--

