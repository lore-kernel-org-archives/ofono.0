Content-Type: multipart/mixed; boundary="===============1611831351735328969=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH v2 3/3] hfp_hf_bluez5: Register the SDP record with
 correct features
Date: Thu, 25 Apr 2013 15:48:16 -0300
Message-ID: <20130425184816.GC20988@samus>
In-Reply-To: <5178EC20.7000306@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============1611831351735328969==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 03:41 Thu 25 Apr, Denis Kenzior wrote:
> Hi Vinicius,
> =

> On 04/23/2013 04:21 PM, Vinicius Costa Gomes wrote:
> >---
> >  plugins/hfp_hf_bluez5.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> =

> Patch has been applied, thanks.
> =

> >diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
> >index 826796f..06b6fd3 100644
> >--- a/plugins/hfp_hf_bluez5.c
> >+++ b/plugins/hfp_hf_bluez5.c
> >@@ -636,10 +636,15 @@ static const GDBusMethodTable profile_methods[] =
=3D {
> >
> >  static void connect_handler(DBusConnection *conn, void *user_data)
> >  {
> >+	uint16_t features =3D HFP_SDP_HF_FEATURE_3WAY |
> >+				HFP_SDP_HF_FEATURE_CLIP |
> >+				HFP_SDP_HF_FEATURE_REMOTE_VOLUME_CONTROL |
> >+				HFP_SDP_HF_FEATURE_WIDEBAND_SPEECH;
> >+
> =

> Can we check whether the kernel supports wideband speech features
> here and not set this flag if it does not?

What we can do is exporting something like
ofono_handsfree_audio_has_defer_setup() or something like it, and set the
feature bit if it's available. I send the patches and let's see how it look=
s.

The other alternative would be only registering the profile after the Agent
registers, that way we can be sure that wideband speech is supported. But it
may bring little benefit, for example, the other side may cache the SDP sea=
rch
results.

> =

> >  	DBG("Registering External Profile handler ...");
> >
> >  	bt_register_profile(conn, HFP_HS_UUID, HFP_VERSION_1_6, "hfp_hf",
> >-					HFP_EXT_PROFILE_PATH, NULL, 0);
> >+					HFP_EXT_PROFILE_PATH, NULL, features);
> >  }
> >
> >  static gboolean has_hfp_ag_uuid(DBusMessageIter *array)
> =

> Regards,
> -Denis


Cheers,
-- =

Vinicius

--===============1611831351735328969==--

