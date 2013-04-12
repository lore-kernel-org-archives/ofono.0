Content-Type: multipart/mixed; boundary="===============4889597384600117996=="
MIME-Version: 1.0
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: Re: [PATCH v2 1/7] hfpmodem: Watch for changes in the selected codec
Date: Fri, 12 Apr 2013 20:20:09 -0300
Message-ID: <20130412232009.GA24402@samus>
In-Reply-To: <516893B9.6080000@gmail.com>
List-Id: <ofono.ofono.org>
To: ofono@ofono.org

--===============4889597384600117996==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Hi Denis,

On 18:07 Fri 12 Apr, Denis Kenzior wrote:
> Hi Vinicius,
> =

> On 04/10/2013 02:37 PM, Vinicius Costa Gomes wrote:
> >This patch adds a function to monitor when the AG sends a new codec
> >before establishing the SCO connection.
> >---
> >  plugins/hfp_hf_bluez5.c | 51 +++++++++++++++++++++++++++++++++++++++++=
++++++++
> >  1 file changed, 51 insertions(+)
> >
> >diff --git a/plugins/hfp_hf_bluez5.c b/plugins/hfp_hf_bluez5.c
> >index c63b1a2..efbb209 100644
> >--- a/plugins/hfp_hf_bluez5.c
> >+++ b/plugins/hfp_hf_bluez5.c
> >@@ -314,9 +314,60 @@ static struct ofono_modem_driver hfp_driver =3D {
> >  	.post_sim	=3D hfp_post_sim,
> >  };
> >
> >+static void bcs_notify(GAtResult *result, gpointer user_data)
> >+{
> >+	struct hfp *hfp =3D user_data;
> >+	struct hfp_slc_info *info =3D&hfp->info;
> >+	GAtResultIter iter;
> >+	char str[32];
> >+	int value;
> >+
> >+	g_at_result_iter_init(&iter, result);
> >+
> >+	if (!g_at_result_iter_next(&iter, "+BCS:"))
> >+		return;
> >+
> >+	if (!g_at_result_iter_next_number(&iter,&value))
> >+		return;
> >+
> >+	memset(str, 0, sizeof(str));
> =

> Why do you need this exactly?

I don't. Will fix.

> =

> >+
> >+	switch (value) {
> >+	case HFP_CODEC_MSBC:
> >+		if (!ofono_handsfree_audio_has_wideband()) {
> >+			/* No wideband speech support, so we only have CVSD */
> >+			sprintf(str, "AT+BAC=3D%d", HFP_CODEC_CVSD);
> >+			break;
> >+		}
> >+
> >+		/* fall through */
> >+
> =

> This fall through and the default statement make this code extremely
> hard to read.  Why don't we move the codec selection logic into the
> core instead?
> =

> Then this becomes something like:
> =

> if (ofono_handsfree_audio_card_set_codec(card, value) =3D=3D FALSE) {
> 	if (ofono_handsfree_audio_has_wideband())
> 		...
> 	else
> 		...
> =

> 	goto done;
> }
> =

> sprintf(str, "AT+BCS=3D%d", value);
> =

> done:
> ....

Sounds good. Let's see how it ends up looking.

> =

> =

> >+	case HFP_CODEC_CVSD:
> >+		/* Confirm the codec */
> >+		sprintf(str, "AT+BCS=3D%d", value);
> >+		break;
> >+
> >+	default:
> >+		/* Unsupported codec, re-send our codecs */
> >+		if (ofono_handsfree_audio_has_wideband())
> >+			sprintf(str, "AT+BAC=3D%d,%d", HFP_CODEC_CVSD,
> >+							HFP_CODEC_MSBC);
> >+		else
> >+			sprintf(str, "AT+BAC=3D%d", HFP_CODEC_CVSD);
> >+	}
> >+
> >+	g_at_chat_send(info->chat, str, NULL, NULL, NULL, NULL);
> >+}
> >+
> >  static int hfp16_card_probe(struct ofono_handsfree_card *card,
> >  					unsigned int vendor, void *data)
> >  {
> >+	struct hfp *hfp =3D data;
> >+	struct hfp_slc_info *info =3D&hfp->info;
> >+
> >+	g_at_chat_register(info->chat, "+BCS:", bcs_notify, FALSE,
> >+								hfp, NULL);
> >+
> =

> You read my mind, I was going to suggest doing this exactly :)
> =

> >  	return 0;
> >  }
> >
> =

> Regards,
> -Denis


Cheers,
-- =

Vinicius

--===============4889597384600117996==--

