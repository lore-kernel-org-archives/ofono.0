Content-Type: multipart/mixed; boundary="===============2066306049915779121=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH v0 4/8] hfpmodem: Add support for storing the supported
 codecs
Date: Thu, 17 Jan 2013 15:55:40 -0300
Message-ID: <20130117185539.GA18094@samus>
In-Reply-To: <50F834F9.4010409@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============2066306049915779121==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 11:29 Thu 17 Jan, Denis Kenzior wrote:
> Hi Claudio,
> =

> On 01/17/2013 09:13 AM, Claudio Takahasi wrote:
> >From: Vinicius Costa Gomes<vinicius.gomes@openbossa.org>
> >
> >As informing the AG of the supported codecs is part of the setup
> >of the SLC, it makes sense to have this information inside the SLC
> >establishment part.
> >
> >Now the hfp_slc_info structure has dynamic information, and so the
> >hfp_slc_info_free() function is used.
> >---
> >  drivers/hfpmodem/slc.c  | 14 +++++++++++++-
> >  drivers/hfpmodem/slc.h  | 10 +++++++++-
> >  plugins/hfp_hf_bluez4.c |  5 ++++-
> >  plugins/phonesim.c      | 12 +++++++-----
> >  4 files changed, 33 insertions(+), 8 deletions(-)
> =

> This patch needs to be broken up.  First it needs to implement the
> hfp_slc_info_free function, then update all existing plugins to use
> that.  Then introduce hfp_slc_info_init changes and whatever else.

Ok. Sure.

[snip]

> =

> >diff --git a/plugins/hfp_hf_bluez4.c b/plugins/hfp_hf_bluez4.c
> >index 450c183..f27b0e1 100644
> >--- a/plugins/hfp_hf_bluez4.c
> >+++ b/plugins/hfp_hf_bluez4.c
> >@@ -165,12 +165,15 @@ static DBusMessage *hfp_agent_new_connection(DBusC=
onnection *conn,
> >  	struct ofono_modem *modem =3D data;
> >  	struct hfp_data *hfp_data =3D ofono_modem_get_data(modem);
> >  	guint16 version;
> >+	unsigned char codecs[1];
> >
> >  	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UNIX_FD,&fd,
> >  				DBUS_TYPE_UINT16,&version, DBUS_TYPE_INVALID))
> >  		return __ofono_error_invalid_args(msg);
> >
> >-	hfp_slc_info_init(&hfp_data->info, version);
> >+	memset(&codecs, 0, sizeof(codecs));
> >+	codecs[0] =3D HFP_CODEC_CVSD;
> >+	hfp_slc_info_init(&hfp_data->info, version, codecs, 1);
> =

> Why do you need this info for HFP 1.5?

You are right, I don't need it. But being pedantic, it is more because
in the BlueZ 4 case it won't support codec negotiation than because of
the version.

And that reminds me that in the case that I only have one codec (CVSD),
I am sending the supported codecs needlessly. Will fix it as well.


Cheers,
-- =

Vinicius

--===============2066306049915779121==--

