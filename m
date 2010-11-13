Content-Type: multipart/mixed; boundary="===============4495129512927718482=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH v5] stemodem: Add RTNL functionality managing CAIF Network
 Interfaces.
Date: Sat, 13 Nov 2010 10:29:25 +0900
Message-ID: <1289611765.3266.122.camel@aeonflux>
In-Reply-To: <1289558490-22481-1-git-send-email-sjurbren@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4495129512927718482==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Sjur,

>  Makefile.am                  |    2 +
>  drivers/stemodem/caif_rtnl.c |  340 ++++++++++++++++++++++++++++++++++++=
++++++
>  drivers/stemodem/caif_rtnl.h |   29 ++++
>  3 files changed, 371 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/stemodem/caif_rtnl.c
>  create mode 100644 drivers/stemodem/caif_rtnl.h

I applied this patch now, but I had to fix this up a bit. You have to
send a patch that updates this one.

> +#define RTNL_MSG_SIZE 4096
> +
> +struct rtnl_msg {
> +	struct nlmsghdr n;
> +	struct ifinfomsg i;
> +	char data[RTNL_MSG_SIZE];
> +};

Is this not a bit big?

> +struct iplink_req {
> +	guint32 rtnlmsg_seqnr;

Use the proper nlmsg_seqnr type that you get from RTNL.

> +	gpointer user_data;

Use void * here since your callback does as well.

> +	caif_rtnl_create_cb_t callback;
> +};
> +
> +static GSList *pending_requests;
> +static guint32 rtnl_seqnr;
> +static guint rtnl_watch;
> +static GIOChannel *rtnl_channel;
> +
> +static struct iplink_req *find_request(guint32 seq)
> +{

seq should match RTNL given type.

> +	GSList *list;
> +
> +	for (list =3D pending_requests; list; list =3D list->next) {
> +		struct iplink_req *req =3D list->data;
> +
> +		if (req->rtnlmsg_seqnr =3D=3D seq)
> +			return req;
> +	}
> +
> +	return NULL;
> +}
> +
> +static void parse_newlink_param(struct ifinfomsg *msg, int size,
> +						int *ifindex, char *ifname)
> +{
> +	struct rtattr *attr;
> +
> +	for (attr =3D IFLA_RTA(msg); RTA_OK(attr, size);
> +		attr =3D RTA_NEXT(attr, size)) {
> +
> +		if (attr->rta_type =3D=3D IFLA_IFNAME &&
> +				ifname !=3D NULL) {
> +
> +			strncpy(ifname, RTA_DATA(attr), IF_NAMESIZE);
> +			ifname[IF_NAMESIZE-1] =3D '\0';
> +			break;
> +		}
> +	}
> +
> +	*ifindex =3D msg->ifi_index;
> +}
> +
> +static void parse_rtnl_message(const void *buf, size_t len)
> +{
> +	struct ifinfomsg *msg;
> +	struct iplink_req *req =3D NULL;

This is bad. Please only do assignment if there is no other way around
it. I fixed this for you.

Regards

Marcel



--===============4495129512927718482==--

