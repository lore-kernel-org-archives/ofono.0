Content-Type: multipart/mixed; boundary="===============6224849711053399337=="
MIME-Version: 1.0
From: Sjur BRENDELAND <sjur.brandeland@stericsson.com>
Subject: RE: [PATCH v4 1/2] stemodem: Add RTNL functionality managing CAIF
 Network Interfaces.
Date: Thu, 11 Nov 2010 16:52:12 +0100
Message-ID: <81C3A93C17462B4BBD7E272753C105791945BBEAA6@EXDCVYMBSTM005.EQ1STM.local>
In-Reply-To: <1289453347.3266.32.camel@aeonflux>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============6224849711053399337==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Marcel.

> what happens for network triggered deactivation. Some networks here
> disconnect the GPRS context used MMS. Has some funny behavior that need
> to be taken into account.

Good question! When code reading with this in mind I realize that
we missed to mark the conn_info->interface as available by setting
cid =3D 0. This is bug, thank you for leading me to it.


FYI this is how CAIF and AT works together:
In order to have payload over CAIF there need to be
both a CAIF channel connected and a context activated with AT*EPPSD.
When Channel-ID configured for CAIF IP Interface and the Channel-Id given
in AT*EPPSD matches, the modem side will connect the CAIF Channel to
the Network Signaling Stack in the modem.

With this new patch CAIF channels are created statically from probe.
Activation and deactivation is controlled by AT*EPPSD, or notified by
+CGEV which will result in a CGACT status query.

If the network disconnects GPRS we should receive a
"+CGEV: NW DEACT", subsequent CGACT status query.
Here the connection (and CAIF Network Interface) should be
marked as unused by setting cid to zero.

> > +#define NLMSG_TAIL(nmsg) \
> > +   ((struct rtattr *) (((void *) (nmsg)) + NLMSG_ALIGN((nmsg)-
> >nlmsg_len)))
>
> We have no global define this? You wanted to look into that. What was
> the outcome of it?

I did mention this before - I have looked around, but he did not find
any relevant macro for this unfortunately.

>
> > +struct iplink_req {
> > +   struct nlmsghdr n;
> > +   struct ifinfomsg i;
> > +   char pad[1024];
>
> What is this huge pad for? It looks totally fishy to me.

The pad is there to hold the remaining of the rtnl attributes.
I'm working on restructuring this so that I can separate the
buffer holding the rtnl_message and the iplink_req.
I just have to make it work...

>
> > +static guint  rtnl_watch;
>
> Get rid of the double spaces for rtnl_watch.
>
> > +static GIOChannel *channel;
>
> If we follow your convention here and not to overload variables this
> might be better named rtnl_channel.
>
> And yes, I am fine with keeping it since there is no way to connect a
> netlink socket properly to just use send(). You will require to use
> sendto for everything.
>

OK, Done.

>
> > +static void store_newlink_param(struct iplink_req *req, unsigned
> short type,
> > +                                   int index, unsigned flags,
> > +                                   unsigned change, struct ifinfomsg *=
msg,
> > +                                   int bytes)
> > +{
> > +   const char *ifname =3D NULL;
> > +
> > +   get_ifname(msg, bytes, &ifname);
> > +   strncpy(req->ifname, ifname,
> > +                   sizeof(req->ifname));
> > +   req->ifname[sizeof(req->ifname)-1] =3D '\0';
> > +   req->ifindex =3D index;
> > +}
>
> So I think that store_newlink_... and get_ifname can be nicely combined
> into one helper function. And using extract_parameters() function name
> is a bit better.
>
> And please only add parameters to that function that you really need in
> there. And the iplink_req should be last parameter.
>
> As one general is to have input parameters first and then the output
> parameters last. So read this something like extract values from this
> structure to this structure.


Yes, I agree. I have squashed the two functions together and cleaned up the=
 parameters.
This is much nicer, thank you.

>
> > +static int send_rtnl_req(struct iplink_req *req)
> > +{
> > +   struct sockaddr_nl addr;
> > +   int sk =3D g_io_channel_unix_get_fd(channel);
> > +
> > +   memset(&addr, 0, sizeof(addr));
> > +   addr.nl_family =3D AF_NETLINK;
> > +
> > +   return sendto(sk, req, req->n.nlmsg_len, 0,
> > +                   (struct sockaddr *) &addr, sizeof(addr));
> > +}
>
> I don't think this should be a separate function. You use it only twice
> and having it close to the code using it would be better.

OK, good I have squashed these to functions as well.

>
> > +static struct iplink_req *find_request(guint32 seq)
> > +{
> > +   GSList *list;
> > +
> > +   for (list =3D pending_requests; list; list =3D list->next) {
> > +           struct iplink_req *req =3D list->data;
> > +
> > +           if (req->n.nlmsg_seq =3D=3D seq)
> > +                   return req;
> > +   }
> > +
> > +   return NULL;
> > +}
>
> I would move this function up in this file at the top. It should go
> close to the variable declaration for pending_request.

OK, done.

>
> > +static void rtnl_client_response(struct iplink_req *req, int result)
> > +{
> > +
> > +   if (req->callback && req->n.nlmsg_type =3D=3D RTM_NEWLINK)
> > +           req->callback(result, req->user_data,
> > +                           req->ifname, req->ifindex);
> > +
> > +   pending_requests =3D g_slist_remove(pending_requests, req);
> > +   g_free(req);
> > +}
>
> I don't like this split out. You already checked the nlmsg_type and
> here
> you keep checking it again just to reuse some code. This looks like
> waste to me.

I have squashed this into parse_rtnl_message, as you suggested.
I'm not really convinced this was any cleaner though..?
I end up with duplicating the code in the two if statements.

>
> > +static void parse_rtnl_message(void *buf, size_t len)
> > +{
> > +   struct ifinfomsg *msg;
> > +   struct iplink_req *req;
>
> Make it const void *buf.


OK, Done.

>
> An you can have more than one RTNL message inside this buffer. You need
> to be able to handle this. Otherwise you might loose responses. The
> case
> of just calling return when you received one of the two messages you
> care about is not really acceptable.

OK, done. I'll keep looping.

>
> > +   while (len > 0) {
> > +           struct nlmsghdr *hdr =3D buf;
> > +
> > +           if (!NLMSG_OK(hdr, len))
> > +                   break;
> > +
> > +           if (hdr->nlmsg_type =3D=3D RTM_NEWLINK) {
> > +                   req =3D g_slist_nth_data(pending_requests, 0);
> > +                   if (req =3D=3D NULL)
> > +                           break;
>
> How does this work? You just pick the first pending request and don't
> really compare the sequence number. Who guarantees the order of these
> events. I don't think we should be doing this.

I think that the kernel implementation of rtnl will guarantee the
requests to be processed in order. rtnetlink_rcv in ..net/core/rtnetlink.c
takes the rtnl_lock before processing the netlink messages.
I believe this will guarantee that the NEWLINK responses will be received
in the same order as they are sent.

>
> > +                   msg =3D (struct ifinfomsg *) NLMSG_DATA(hdr);
> > +                   store_newlink_param(req, msg->ifi_type,
> > +                                   msg->ifi_index, msg->ifi_flags,
> > +                                   msg->ifi_change, msg,
> > +                                   IFA_PAYLOAD(hdr));
> > +                   rtnl_client_response(req, 0);
> > +                   return;
> > +
> > +           } else if (hdr->nlmsg_type =3D=3D NLMSG_ERROR) {
>
> So I would prefer if you use a switch statement here. It is just easier
> to read. Especially inside a while() loop.

OK - I'll break coding-style rule M12. There are more than 40 RTM messages
I'm not handling, but no rule without exception :-)

>
> > +                   req =3D find_request(hdr->nlmsg_seq);
> > +                   if (req =3D=3D NULL)
> > +                           break;
> > +
> > +                   DBG("nlmsg error req");
> > +                   rtnl_client_response(req, -1);
> > +                   return;
> > +           }
>
> If I understand this right, then you can always find the pending
> request
> and remove it here. No need for rtnl_client_response at all.

Yes, I guess you are right. I can remove this callback.
Currently I am only actually interested in the result when
the interface is created successfully. Nothing particularly
is done in gprs-context.c if it fails.

>
> > +           len -=3D hdr->nlmsg_len;
> > +           buf +=3D hdr->nlmsg_len;
> > +   }
> > +}
> > +
> > +static int add_attribute(struct nlmsghdr *n, int maxlen, int type,
> > +                           const void *data, int datalen)
> > +{
> > +   int len =3D RTA_LENGTH(datalen);
> > +   struct rtattr *rta;
> > +
> > +   if ((int)(NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len)) > maxlen) {
>
> Why is this (int) cast needed. Can we just not used proper parameter
> for
> maxlen in the first place?

Yes, I have made the maxlen an unsigned int.

>
> > +   add_attribute(&req->n, sizeof(*req), IFLA_INFO_KIND,
> > +                   type, strlen(type));
>
> So add_attribute(..., "caif", 4) should be just fine.

OK, done.

>
> > +   data =3D NLMSG_TAIL(&req->n);
>
> Why is this assignment here and only used later on. I see that you do
> it
> for length calculation, but use a common variable name like data is a
> bit confusing.

This is used for length calculation, I'll rename it to data_start.

>
> +static void prep_rtnl_dellink_req(struct iplink_req *req, int
> ifindex)
> > +{
> > +   req->n.nlmsg_len =3D NLMSG_LENGTH(sizeof(struct ifinfomsg));
> > +   req->n.nlmsg_flags =3D NLM_F_REQUEST|NLM_F_CREATE|NLM_F_EXCL;
> > +   req->n.nlmsg_type =3D RTM_DELLINK;
> > +   req->n.nlmsg_seq =3D ++rtnl_seqnr;
> > +   req->i.ifi_family =3D AF_UNSPEC;
> > +   req->i.ifi_index =3D ifindex;
> > +}
>
> Actually having some generic function with a parameter of nlmsg_type
> that fills these details would be a good thing.

OK, done.

>
> > +static gboolean netlink_event(GIOChannel *chan,
> > +                           GIOCondition cond, gpointer data)
> > +{
> > +   unsigned char buf[4096];
> > +   gsize len;
> > +   GIOError err;
> > +
> > +   if (cond & (G_IO_NVAL | G_IO_HUP | G_IO_ERR)) {
> > +           rtnl_watch =3D 0;
> > +           return FALSE;
> > +   }
> > +
> > +   memset(buf, 0, sizeof(buf));
> > +
> > +   err =3D g_io_channel_read(chan, (gchar *) buf, sizeof(buf), &len);
> > +   if (err) {
> > +           if (err =3D=3D G_IO_ERROR_AGAIN)
> > +                   return TRUE;
> > +           rtnl_watch =3D 0;
> > +           return FALSE;
> > +   }
>
> Just use recv() here. I know that I would prefer to be using GIOChannel
> functions, but they don't work well on netlink sockets anyway, so don't
> bother with them at all.
>
> Sorry for confusing you and sending you into the wrong direction first.

Actually I think io_channel_read is just fine here. I think connman is doing
the same thing for rtnl. It is the sending part which is problematic.

>
> > +   parse_rtnl_message(buf, len);
> > +
> > +   return TRUE;
> > +}
> > +
> > +int caif_rtnl_init(void)
> > +{
> > +   struct sockaddr_nl addr;
> > +   int sk, err;
> > +
> > +   sk =3D socket(PF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
> > +   if (sk < 0)
> > +           return sk;
> > +
> > +   memset(&addr, 0, sizeof(addr));
> > +   addr.nl_family =3D AF_NETLINK;
> > +   addr.nl_groups =3D RTMGRP_LINK | RTMGRP_IPV4_IFADDR |
> RTMGRP_IPV4_ROUTE;
>
> You need IPV4_IFADDR and IPV4_ROUTE as well. I don't see you making use
> of them. Please only set LING since we don't wanna wake ofonod up for
> anything else.

Actually I guess I only need RTMGRP_LINK. I am only interested in creating
and removing the CAIF Interface. Setting the IP addresses and all the rest
is connman responsibility right?

>
> > +   err =3D bind(sk, (struct sockaddr *) &addr, sizeof(addr));
> > +   if (err < 0) {
> > +           close(sk);
> > +           return err;
> > +   }
> > +
> > +   channel =3D g_io_channel_unix_new(sk);
> > +   g_io_channel_set_flags(channel, G_IO_FLAG_NONBLOCK, NULL);
> > +   g_io_channel_set_close_on_unref(channel, TRUE);
> > +
> > +   rtnl_watch =3D g_io_add_watch(channel,
> > +                           G_IO_IN | G_IO_NVAL | G_IO_HUP | G_IO_ERR,
> > +                           netlink_event, NULL);
> > +   pending_requests =3D NULL;
>
> Please don't bother with setting it here to zero. Just set the global
> variable to NULL. The init and exit will be only called once anyway.

OK.

>
> > +
> > +   return 0;
> > +}
> > +
> > +void caif_rtnl_exit(void)
> > +{
> > +   GSList *list;
> > +
> > +   if (rtnl_watch > 0)
> > +           g_source_remove(rtnl_watch);
> > +
> > +   g_io_channel_unref(channel);
> > +
> > +   for (list =3D pending_requests; list; list =3D list->next) {
> > +           struct iplink_req *req =3D list->data;
> > +           g_free(req);
> > +   }
> > +
> > +   g_slist_free(pending_requests);
> > +}
> > +
> > +
> > +int caif_rtnl_create_interface(gpointer user_data, int type, int
> connid,
> > +           gboolean loop, caif_rtnl_create_cb_t cb)
> > +{
> > +   int err;
> > +   struct iplink_req *req;
>
> I prefer structs before int. Just a minor style thing.

OK,

>
> > +
> > +   req =3D g_try_new0(struct iplink_req, 1);
> > +   if (req =3D=3D NULL)
> > +           return -ENOMEM;
> > +
> > +   req->user_data =3D user_data;
> > +   req->type =3D type;
> > +   req->conn_id =3D connid;
> > +   req->loop_enabled =3D loop;
> > +   req->callback =3D cb;
> > +
> > +   err =3D prep_rtnl_newlink_req(req);
> > +   if (err < 0)
> > +           goto error;
>
> So if we split out creating the NLMSG header into one helper functions,
> then you can easily prep the RTNL newlink message here inside the
> function.

Even with creating this helper function you suggested
the prep_rtnl_newlink_req is on 45 lines. I think it makes sense
still keep then separate. It is no big deal for me, but I would prefer
to avoid such a large functions,

>
> This will also allow you to remove req->loop_enabled variables since I
> don't see need for storing them.

You are right, the loop_enabled variable is not currently needed.
However for various testing purposes we frequently want to run the CAIF Int=
erface
in loopback mode (e.g. testing loopback to the modem). loopback_mode will m=
ake the
interface swap src and destination ip addresses so we actually can do ping =
etc.
If you are OK with this, I would prefer to keep this in order to make testi=
ng easier.
But again, I'm easy...

>
> > +
> > +   err =3D send_rtnl_req(req);
> > +   if (err < 0)
> > +           goto error;
> > +
>
> Same here. Just putting the sendto() directly in here seems just fine.


OK, done.

>
> > +   pending_requests =3D g_slist_append(pending_requests, req);
> > +   return 0;
>
> Extra empty line before a label please.
>
> > +error:
> > +   g_free(req);
> > +   return err;
> > +
> > +}
> > +
> > +int caif_rtnl_delete_interface(int ifid)
> > +{
> > +   struct iplink_req req;
> > +   int err;
> > +   memset(&req, 0, sizeof(req));
> > +   prep_rtnl_dellink_req(&req, ifid);
> > +
> > +   err =3D send_rtnl_req(&req);
> > +   if (err < 0)
> > +           return err;
> > +
> > +   return 0;
> > +}
>
> Comments from above apply here.

OK, Done

>
> > diff --git a/drivers/stemodem/caif_rtnl.h
...
> > +typedef void (*caif_rtnl_create_cb_t) (int result, gpointer
> user_data,
> > +           char *ifname, int ifindex);
>
> Please don't use GLib types here. Using int and void * is better.
>
> So the user_data parameter should come always last. Do we need index
> and
> ifname? I think inside oFono we only care about ifname.


Yes, but ifindex is used when removing the CAIF IP Interface.
It makes life a lot easier when removing an interface.

>
> > +extern int caif_rtnl_create_interface(gpointer user_data, int type,
> int connid,
> > +           gboolean loop, caif_rtnl_create_cb_t cb);
>
> The user_data is always the last parameter. The only exception would be
> having a destruct callback.
>
> Please use int for loop.
>

Thank you for a very thorough review here Marcel.

I have done most of the updates, I could sent what I have now,
but I'd like to make it work again. Removing the pad and
split apart the request structure and the actual rtnl message
proved to be a bit of work....


Regards,
Sjur

--===============6224849711053399337==--

