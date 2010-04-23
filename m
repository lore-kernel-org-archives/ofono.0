Content-Type: multipart/mixed; boundary="===============0449232903434443501=="
MIME-Version: 1.0
From: Denis Kenzior <denkenz@gmail.com>
Subject: Re: [PATCH] usbpnmodem: configure usbpn interfaces automatically
Date: Fri, 23 Apr 2010 13:00:21 -0500
Message-ID: <201004231300.22037.denkenz@gmail.com>
In-Reply-To: <1272035118-26998-1-git-send-email-Pekka.Pessi@nokia.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============0449232903434443501==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Pekka,

> ---
>  drivers/isimodem/isimodem.c |    2 +-
>  gisi/netlink.c              |  246
>  +++++++++++++++++++++++++++++++++++++++--- gisi/netlink.h              |=
  =

>  11 ++-
>  plugins/usbpnmodem.c        |   10 ++-
>  4 files changed, 246 insertions(+), 23 deletions(-)

So again, you're mixing library and driver / plugin patches.  There's nothi=
ng =

wrong with sending a series of several...

> =

> diff --git a/drivers/isimodem/isimodem.c b/drivers/isimodem/isimodem.c
> index e6e0bc1..b6ae82b 100644
> --- a/drivers/isimodem/isimodem.c
> +++ b/drivers/isimodem/isimodem.c
> @@ -256,7 +256,7 @@ static int isi_modem_probe(struct ofono_modem *modem)
>  		return -errno;
>  	}
> =

> -	link =3D g_pn_netlink_by_name(ifname);
> +	link =3D g_pn_netlink_by_modem(idx);
>  	if (link) {
>  		DBG("%s: %s", ifname, strerror(EBUSY));
>  		return -EBUSY;
> diff --git a/gisi/netlink.c b/gisi/netlink.c
> index 1a18b45..36bf273 100644
> --- a/gisi/netlink.c
> +++ b/gisi/netlink.c
> @@ -68,6 +68,7 @@
>  #define RTA_NEXT(rta,attrlen)	((attrlen) -=3D RTA_ALIGN((rta)->rta_len),=
 \
>  	(struct rtattr*)(void*)(((char*)(rta)) + RTA_ALIGN((rta)->rta_len)))
> =

> +#define SIZE_NLMSG (16384)
> =

>  struct _GPhonetNetlink {
>  	GPhonetNetlinkFunc callback;
> @@ -98,18 +99,6 @@ GPhonetNetlink *g_pn_netlink_by_modem(GIsiModem *idx)
>  	return NULL;
>  }
> =

> -GPhonetNetlink *g_pn_netlink_by_name(const char *ifname)
> -{
> -	if (ifname =3D=3D NULL) {
> -		return g_pn_netlink_by_modem(make_modem(0));
> -	} else {
> -		GIsiModem *idx =3D g_isi_modem_by_name(ifname);
> -		if (!idx)
> -			return NULL;
> -		return g_pn_netlink_by_modem(idx);
> -	}
> -}
> -

Removal of this function can be done in a separate patch so that it is much =

easier to review.

>  static void bring_up(unsigned ifindex)
>  {
>  	struct ifreq req =3D { .ifr_ifindex =3D ifindex, };
> @@ -124,6 +113,25 @@ error:
>  	close(fd);
>  }
> =

> +static int netlink_socket(void)
> +{
> +	int fd;
> +	int bufsize =3D SIZE_NLMSG;
> +
> +	fd =3D socket(PF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
> +	if (fd =3D=3D -1)
> +		return -1;
> +
> +	if (setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &bufsize, (sizeof bufsize))) {
> +		int error =3D errno;
> +		g_warning("sockopt(SO_RCVBUF): %s", strerror(error));
> +		close(fd), fd =3D -1;
> +		errno =3D error;
> +	}
> +
> +	return fd;
> +}
> +
>  static void g_pn_nl_addr(GPhonetNetlink *self, struct nlmsghdr *nlh)
>  {
>  	int len;
> @@ -196,7 +204,7 @@ static gboolean g_pn_nl_process(GIOChannel *channel,
>  GIOCondition cond, {
>  	struct {
>  		struct nlmsghdr nlh;
> -		char buf[16384];
> +		char buf[SIZE_NLMSG];
>  	} resp;
>  	struct iovec iov =3D { &resp, (sizeof resp), };
>  	struct msghdr msg =3D { .msg_iov =3D &iov, .msg_iovlen =3D 1, };
> @@ -225,10 +233,11 @@ static gboolean g_pn_nl_process(GIOChannel *channel,
>  GIOCondition cond,
> =

>  		switch (nlh->nlmsg_type) {
>  		case NLMSG_ERROR: {
> -			const struct nlmsgerr *err;
> -			err =3D (struct nlmsgerr *)NLMSG_DATA(nlh);
> -			g_critical("Netlink error: %s", strerror(-err->error));
> -			return FALSE;
> +			const struct nlmsgerr *err =3D NLMSG_DATA(nlh);
> +			if (err->error)
> +				g_critical("Netlink error: %s",
> +					strerror(-err->error));

Since oFono is a daemon, you really might want to rethink the use of =

g_critical.  See how gatchat handles this.

> +			return TRUE;
>  		}
>  		case RTM_NEWADDR:
>  		case RTM_DELADDR:
> @@ -271,6 +280,7 @@ static int g_pn_netlink_getlink(int fd)
>  		      (struct sockaddr *)&addr, sizeof(addr));
>  }
> =

> +

Why exactly is there an extra space?

>  GPhonetNetlink *g_pn_netlink_start(GIsiModem *idx,
>  				   GPhonetNetlinkFunc callback,
>  				   void *data)
> @@ -281,7 +291,7 @@ GPhonetNetlink *g_pn_netlink_start(GIsiModem *idx,
>  	unsigned group =3D RTNLGRP_LINK;
>  	unsigned interface =3D g_isi_modem_index(idx);
> =

> -	fd =3D socket(PF_NETLINK, SOCK_DGRAM, NETLINK_ROUTE);
> +	fd =3D netlink_socket();
>  	if (fd =3D=3D -1)
>  		return NULL;
> =

> @@ -332,3 +342,203 @@ void g_pn_netlink_stop(GPhonetNetlink *self)
>  		free(self);
>  	}
>  }
> +
> +static int netlink_getack(int fd)
> +{
> +	struct {
> +		struct nlmsghdr nlh;
> +		char buf[SIZE_NLMSG];
> +	} resp;
> +	struct iovec iov =3D { &resp, (sizeof resp), };
> +	struct msghdr msg =3D { .msg_iov =3D &iov, .msg_iovlen =3D 1, };
> +	ssize_t ret;
> +	struct nlmsghdr *nlh =3D &resp.nlh;
> +
> +	ret =3D recvmsg(fd, &msg, 0);
> +	if (ret =3D=3D -1)
> +		return -errno;
> +
> +	if (msg.msg_flags & MSG_TRUNC) {
> +		g_critical("Netlink message of %zu bytes truncated at %zu",
> +				ret, (sizeof resp));
> +		return -EIO;
> +	}
> +
> +	for (; NLMSG_OK(nlh, (size_t)ret); nlh =3D NLMSG_NEXT(nlh, ret)) {
> +
> +		if (nlh->nlmsg_type =3D=3D NLMSG_DONE)
> +			return 0;
> +
> +		if (nlh->nlmsg_type =3D=3D NLMSG_ERROR) {
> +			struct nlmsgerr *err =3D NLMSG_DATA(nlh);
> +			return err->error;
> +		}
> +	}
> +
> +	return -EIO;
> +}
> +
> +/* Set local address */
> +static int netlink_setaddr(int fd, uint32_t ifa_index, uint8_t ifa_local)
> +{
> +	struct ifaddrmsg *ifa;
> +	struct rtattr *rta;
> +	uint32_t reqlen =3D NLMSG_LENGTH(NLMSG_ALIGN(sizeof *ifa) + RTA_SPACE(1=
));
> +	struct req {
> +		struct nlmsghdr nlh;
> +		char buf[512];
> +	} req =3D {
> +		.nlh =3D {
> +			.nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK,
> +			.nlmsg_type =3D RTM_NEWADDR,
> +			.nlmsg_pid =3D getpid(),
> +			.nlmsg_len =3D reqlen,
> +		},
> +	};
> +
> +	struct sockaddr_nl addr =3D { .nl_family =3D AF_NETLINK, };
> +
> +	ifa =3D NLMSG_DATA(&req.nlh);
> +	ifa->ifa_family =3D AF_PHONET;
> +	ifa->ifa_prefixlen =3D 0;
> +	ifa->ifa_index =3D ifa_index;
> +
> +	rta =3D IFA_RTA(ifa);
> +	rta->rta_type =3D IFA_LOCAL;
> +	rta->rta_len =3D RTA_LENGTH(1);
> +	*(uint8_t *)RTA_DATA(rta) =3D ifa_local;
> +
> +	if (sendto(fd, &req, reqlen, 0, (void *)&addr, sizeof addr) =3D=3D -1)
> +		return -errno;
> +
> +	return 0;
> +}
> +
> +int g_pn_netlink_set_address(GIsiModem *idx, uint8_t local)
> +{
> +	int fd =3D -1;
> +	uint32_t ifindex;
> +	int error =3D 0;
> +
> +	if (idx =3D=3D NULL)
> +		return -ENODEV;
> +
> +	if (local !=3D PN_DEV_PC && local !=3D PN_DEV_SOS)
> +		return -EINVAL;
> +
> +	ifindex =3D g_isi_modem_index(idx);
> +
> +	fd =3D netlink_socket();
> +	if (fd =3D=3D -1)
> +		goto error;
> +
> +	error =3D netlink_setaddr(fd, ifindex, local);
> +	if (error)
> +		goto error;
> +
> +	error =3D netlink_getack(fd);
> +	if (error)
> +		goto error;
> +
> +	close(fd);
> +	return 0;
> +
> +error:
> +	if (!error)
> +		error =3D -(errno ? errno : -EIO);
> +	if (fd !=3D -1)
> +		close(fd);
> +	return error;
> +}
> +
> +/* Add remote address */
> +static int netlink_addroute(int fd, uint32_t ifa_index, uint8_t remote)
> +{
> +	struct rtmsg *rtm;
> +	struct rtattr *rta;
> +	uint32_t reqlen =3D NLMSG_LENGTH(
> +		NLMSG_ALIGN(sizeof *rtm) +
> +		RTA_SPACE(1) +
> +		RTA_SPACE(sizeof ifa_index));
> +	struct req {
> +		struct nlmsghdr nlh;
> +		char buf[512];
> +	} req =3D {
> +		.nlh =3D {
> +			.nlmsg_flags =3D NLM_F_REQUEST | NLM_F_ACK
> +					| NLM_F_CREATE | NLM_F_APPEND,
> +			.nlmsg_type =3D RTM_NEWROUTE,
> +			.nlmsg_pid =3D getpid(),
> +			.nlmsg_len =3D reqlen,
> +		},
> +	};
> +	size_t buflen =3D (sizeof req.buf) - (sizeof *rtm);
> +
> +	struct sockaddr_nl addr =3D { .nl_family =3D AF_NETLINK, };
> +
> +	rtm =3D NLMSG_DATA(&req.nlh);
> +	rtm->rtm_family =3D AF_PHONET;
> +	rtm->rtm_dst_len =3D 6;
> +	rtm->rtm_src_len =3D 0;
> +	rtm->rtm_tos =3D 0;
> +
> +	rtm->rtm_table =3D RT_TABLE_MAIN;
> +	rtm->rtm_protocol =3D RTPROT_STATIC;
> +	rtm->rtm_scope =3D RT_SCOPE_UNIVERSE;
> +	rtm->rtm_type =3D RTN_UNICAST;
> +	rtm->rtm_flags =3D 0;
> +
> +	rta =3D IFA_RTA(rtm);
> +	rta->rta_type =3D RTA_DST;
> +	rta->rta_len =3D RTA_LENGTH(1);
> +	*(uint8_t *)RTA_DATA(rta) =3D remote;
> +
> +	rta =3D RTA_NEXT(rta, buflen);
> +	rta->rta_type =3D RTA_OIF;
> +	rta->rta_len =3D RTA_LENGTH(sizeof ifa_index);
> +	*(uint32_t *)(void *)RTA_DATA(rta) =3D ifa_index;
> +

I'm running away scared from this one...

> +	if (sendto(fd, &req, reqlen, 0, (void *)&addr, sizeof addr) =3D=3D -1)
> +		return -errno;
> +
> +	return 0;
> +}
> +
> +int g_pn_netlink_add_route(GIsiModem *idx, uint8_t remote)
> +{
> +	int fd =3D -1;

This initialization is pointless

> +	uint32_t ifindex;
> +	int error =3D 0;
> +
> +	if (idx =3D=3D NULL)
> +		return -ENODEV;
> +
> +	if (remote !=3D PN_DEV_SOS && remote !=3D PN_DEV_HOST)
> +		return -EINVAL;
> +
> +	ifindex =3D g_isi_modem_index(idx);
> +
> +	fd =3D netlink_socket();
> +	if (fd =3D=3D -1)
> +		goto error;
> +
> +	error =3D netlink_addroute(fd, ifindex, remote);
> +	if (error)
> +		goto error;
> +
> +	error =3D netlink_getack(fd);
> +	if (error)
> +		goto error;
> +
> +	close(fd);
> +	return 0;
> +
> +error:
> +	if (!error)
> +		error =3D -errno;
> +	if (!error)
> +		error =3D -EIO;

Ok, what in the world does this do? Seriously please re-do this logic.

> +	if (fd !=3D -1)
> +		close(fd);
> +	return error;
> +}
> diff --git a/gisi/netlink.h b/gisi/netlink.h
> index dfade5b..5b58fa4 100644
> --- a/gisi/netlink.h
> +++ b/gisi/netlink.h
> @@ -41,13 +41,17 @@ typedef enum {
>  	PN_LINK_UP
>  } GPhonetLinkState;
> =

> +enum {
> +	PN_DEV_PC =3D 0x10,	/* PC Suite */
> +	PN_DEV_HOST =3D 0x00,	/* Modem */
> +	PN_DEV_SOS =3D 0x6C,	/* Symbian or Linux */
> +};
> +
>  typedef void (*GPhonetNetlinkFunc)(GIsiModem *idx,
>  			GPhonetLinkState st,
>  			char const *iface,
>  			void *data);
> =

> -GPhonetNetlink *g_pn_netlink_by_name(char const *ifname);
> -
>  GPhonetNetlink *g_pn_netlink_by_modem(GIsiModem *idx);
> =

>  GPhonetNetlink *g_pn_netlink_start(GIsiModem *idx,
> @@ -56,6 +60,9 @@ GPhonetNetlink *g_pn_netlink_start(GIsiModem *idx,
> =

>  void g_pn_netlink_stop(GPhonetNetlink *self);
> =

> +int g_pn_netlink_set_address(GIsiModem *, uint8_t local);
> +int g_pn_netlink_add_route(GIsiModem *, uint8_t remote);
> +
>  #ifdef __cplusplus
>  }
>  #endif
> diff --git a/plugins/usbpnmodem.c b/plugins/usbpnmodem.c
> index 5f06e9d..e1ce4fd 100644
> --- a/plugins/usbpnmodem.c
> +++ b/plugins/usbpnmodem.c
> @@ -49,6 +49,7 @@ static void usbpn_status_cb(GIsiModem *idx,
>  				void *data)
>  {
>  	struct ofono_modem *modem;
> +	int error;
> =

>  	DBG("Phonet link %s (%u) is %s",
>  		ifname, g_isi_modem_index(idx),
> @@ -63,12 +64,17 @@ static void usbpn_status_cb(GIsiModem *idx,
>  	if (st =3D=3D PN_LINK_REMOVED)
>  		return;
> =

> -	link =3D g_pn_netlink_by_name(ifname);
> -	if (link) {
> +	if (g_pn_netlink_by_modem(idx)) {
>  		DBG("Modem for interface %s already exists", ifname);
>  		return;
>  	}
> =

> +	error =3D g_pn_netlink_set_address(idx, PN_DEV_SOS);
> +	if (error && error !=3D -EEXIST) {
> +		DBG("g_pn_netlink_set_address: %s\n", strerror(-error));
> +		return;
> +	}
> +
>  	modem =3D ofono_modem_create(NULL, "isimodem");
>  	if (!modem)
>  		return;
> =


Regards,
-Denis

--===============0449232903434443501==--

