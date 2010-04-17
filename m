Content-Type: multipart/mixed; boundary="===============4363110005270832458=="
MIME-Version: 1.0
From: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH 3/3] ppp: use GAtHDLC
Date: Sat, 17 Apr 2010 15:36:57 -0700
Message-ID: <1271543817.22838.31.camel@localhost.localdomain>
In-Reply-To: <1271528135-12337-4-git-send-email-kristen@linux.intel.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4363110005270832458==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Kristen,

> +static void ppp_record(GAtPPP *ppp, gboolean in, guint8 *data, guint16 l=
ength)
> +{
> +	guint16 len =3D htons(length);
> +	guint32 ts;
> +	struct timeval now;
> +	unsigned char id;
> +	int err;
> +
> +	if (ppp->record_fd < 0)
> +		return;
> +
> +	gettimeofday(&now, NULL);
> +	ts =3D htonl(now.tv_sec & 0xffffffff);
> +
> +	id =3D 0x07;
> +	err =3D write(ppp->record_fd, &id, 1);
> +	err =3D write(ppp->record_fd, &ts, 4);
> +
> +	id =3D in ? 0x02 : 0x01;
> +	err =3D write(ppp->record_fd, &id, 1);
> +	err =3D write(ppp->record_fd, &len, 2);
> +	err =3D write(ppp->record_fd, data, length);
> +}
> +

there is one change that has to happen first here. We need to add
g_at_hdlc_set_recording. And this needs to take a file name and an
actual format parameter. With pppdump being the initial format.

Then the g_at_ppp_set_recoding can just call the HDLC recording function
and set this. I do wanna have this in a central place. And at the same
time allow recording of other HDLC based data formats that Wireshark
eventually can support.

Regards

Marcel



--===============4363110005270832458==--

